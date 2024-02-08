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
				this.changes.filter(function(item, index, array) {
					if ((item.y != change.y) || (item.x != change.x)) { return true; } else { return false; }
				});
			c.push(change);
			this.changes = c;
		} else {
			// Only push the change if there isn't one for that x,y already.
			var s =
				this.changes.some(function(item, index, array) {
					if ((item.y == change.y) && (item.x == change.x)) { return true; } else { return false; }
				});
			if (!s) {
				this.changes.push(change);
			}
		}
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
		if (this.blockTypeChanges.changes.length > 0) { return false; }
		if (this.blockPicChanges.changes.length > 0) { return false; }
		return true;
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
