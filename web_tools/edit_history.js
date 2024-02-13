// Represents a list of changes to blocks. { x, y, value }
// If preferNewer is set, later changes to the same coordinates will overwrite old ones.
// This is generally set to true for forward history and false for backward (undo) history.
class BlockChanges {
	constructor (preferNewer) {
		this.preferNewer = preferNewer;
    	this.changes = []; // { x, y, value }
	}

	add (change) {
		if (this.preferNewer) {
			// Remove any previous change at this x,y before pushing.
			var c =
				this.changes.filter(function(item) {
					if ((item.y != change.y) || (item.x != change.x)) { return true; } else { return false; }
				});
			c.push(change);
			this.changes = c;
		} else {
			// Only push the change if there isn't one for that x,y already.
			var s =
				this.changes.some(function(item) {
					if ((item.y == change.y) && (item.x == change.x)) { return true; } else { return false; }
				});
			if (!s) {
				this.changes.push(change);
			}
		}
	}

    asSelection () {
		return this.changes.map(function(item) {
	        return { x: item.x, y: item.y};
		});
	}

	isEmpty() {
		if (this.changes.length > 0) { return false; }
		return true;
	}
}


// Represents one set of changes to the contents of a level.
class LevelChanges {
	constructor (level, preferNewer) {
		this.preferNewer = preferNewer;
		this.levelNumber = level;
    	this.blockTypeChanges = new BlockChanges(preferNewer);
      	this.blockPicChanges = new BlockChanges(preferNewer);
	}

	isEmpty() {
		if (!this.blockTypeChanges.isEmpty()) { return false; }
		if (!this.blockPicChanges.isEmpty()) { return false; }
		return true;
	}

    asSelection () {
		const typeSelection = this.blockTypeChanges.asSelection();
		const picSelection = this.blockPicChanges.asSelection();

		const exclusionSet = new Set();
		typeSelection.forEach(function(item) {
			exclusionSet.add(item.x + "," + item.y);
		});

		const filteredPicSelection = picSelection.filter(function(item) {
			return !exclusionSet.has(item.x + "," + item.y);
		});

		return typeSelection.concat(filteredPicSelection);
	}
}


// Pairs one set of changes to the contents of a level,
// with a copy of the original un-altered data.
// These can be used to move forward and backward in the history of edits.
class LevelUndoHistoryEntry {
	constructor (level) {
    	this.oldChanges = new LevelChanges(level, false);	// LevelChanges
      	this.newChanges = new LevelChanges(level, true);	// LevelChanges
	}
	isEmpty() {
		if (!this.oldChanges.isEmpty()) { return false; }
		if (!this.newChanges.isEmpty()) { return false; }
		return true;
	}
}


// A history of modifications to a level.
// Contains a queue for sending modifications to a server, and stacks for undo/redo on the client.
class LevelHistory {
	constructor () {
		this.undoHistory = [];	// LevelUndoHistoryEntry[]
		this.redoHistory = [];	// LevelUndoHistoryEntry[]
	}

	addEvent(entry) {
		this.undoHistory.push(entry);
		// Adding a new event (as opposed to Redo-ing one) always clears the Redo stack.
		this.redoHistory = [];
	}

	undo() {
		if (this.undoHistory.length < 1) { return null; }

        const u = this.undoHistory.pop();
		this.redoHistory.push(u);
		return u.oldChanges;
	}

    redo() {
        if (this.redoHistory.length < 1) { return null; }
        const r = this.redoHistory.pop();
		this.undoHistory.push(r);
		return r.newChanges;
	}
}


class MapClipboardContents {
	constructor (w, h) {
		this.mapWidth = w;
		this.mapHeight = h;

    	this.blockTypeChanges = new BlockChanges(true);
      	this.blockPicChanges = new BlockChanges(true);
	}

	// Accepts an object of class LevelChanges
	fromLevelChanges (c) {
    	const t = new BlockChanges(true);
      	const p = new BlockChanges(true);

		if (c.isEmpty()) {
	    	this.blockTypeChanges = t;
    	  	this.blockPicChanges = p;
			return;	
		}

		// We need to find the "upper left" corner of the selection,
		// so we can subtract it from the entire selection,
		// to move the selection so the corner is at 0,0 .
		var xLowest;
		var yLowest;

		// At this point at least one array should have one entry.
		if (c.blockTypeChanges.isEmpty()) {
			xLowest = c.blockPicChanges.changes[0].x;
			yLowest = c.blockPicChanges.changes[0].y;
		} else {
			xLowest = c.blockTypeChanges.changes[0].x;
			yLowest = c.blockTypeChanges.changes[0].y;
		}

		// Run through all entries to find the smallest x and y.
		c.blockTypeChanges.changes.forEach(function(item) {
			xLowest = Math.min(xLowest, item.x);
			yLowest = Math.min(yLowest, item.y);
		});
		c.blockPicChanges.changes.forEach(function(item) {
			xLowest = Math.min(xLowest, item.x);
			yLowest = Math.min(yLowest, item.y);
		});

		c.blockTypeChanges.changes.forEach(function(item) {
			t.add({x: item.x-xLowest, y: item.y-yLowest, value: item.value});
		});
		c.blockPicChanges.changes.forEach(function(item) {
			p.add({x: item.x-xLowest, y: item.y-yLowest, value: item.value});
		});

    	this.blockTypeChanges = t;
      	this.blockPicChanges = p;
	}

	// The object we expect from the clipboard: {
	//	  fromMerryoTrollsEditor: true,
	//    blockTypeChanges: [{x: int, y: int, value: int }],
	//    blockPicChanges: [{x: int, y: int, value: int }]
	// }
	fromClipboardPasteEvent (event) {

		const rawPaste = (event.clipboardData || window.clipboardData).getData("text");

		// If there's any parsing error, this content didn't come from us.
		var c;
		try {
			c = JSON.parse(rawPaste);
		} catch (e) {
			return;
		}

		// If this isn't set, the content didn't come from us.
		if (!c.fromMerryoTrollsEditor) { return; }

    	const t = new BlockChanges(true);
      	const p = new BlockChanges(true);

		const mw = this.mapWidth;
		const mh = this.mapHeight;

		c.blockTypeChanges.forEach(function(item) {
			if ((item.x < 0) || (item.x >= mw)) { return; }
			if ((item.y < 0) || (item.y >= mh)) { return; }
			t.add(item);
		});
		c.blockPicChanges.forEach(function(item) {
			if ((item.x < 0) || (item.x >= mw)) { return; }
			if ((item.y < 0) || (item.y >= mh)) { return; }
			p.add(item);
		});
    	this.blockTypeChanges = t;
      	this.blockPicChanges = p;
	}

	isEmpty() {
		if (!this.blockTypeChanges.isEmpty()) { return false; }
		if (!this.blockPicChanges.isEmpty()) { return false; }
		return true;
	}

	sendToClipboard (event) {

		if (this.isEmpty()) { return ; }

		const forClipboard = {
			fromMerryoTrollsEditor: true,
			blockTypeChanges: this.blockTypeChanges.changes,
			blockPicChanges: this.blockPicChanges.changes
		};

		//const asBlob = new Blob([JSON.stringify(forClipboard)], {type: 'text/plain'});
		//const item = new ClipboardItem({'text/plain': asBlob });

		event.preventDefault();
		event.clipboardData.setData("text/plain", JSON.stringify(forClipboard));

		//navigator.permissions.query({name: 'clipboard-write'}).then((result) => {
		//	if (result.state === 'granted' || result.state === 'prompt') {
		//	navigator.clipboard.write([item]).catch((ex) => { 
		//		console.log(ex) 
		//		} ); 
		//	}
		//});
	}

	asLevelChanges (level, offset) {
		const c = new LevelChanges(level, true)
		this.blockTypeChanges.changes.forEach(function(item) {
			c.blockTypeChanges.add({x: item.x+offset.x, y: item.y+offset.y, value: item.value});
		});
		this.blockPicChanges.changes.forEach(function(item) {
			c.blockPicChanges.add({x: item.x+offset.x, y: item.y+offset.y, value: item.value});
		});
		return c;
	}
}
