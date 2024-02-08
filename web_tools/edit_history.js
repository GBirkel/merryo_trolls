// Represents one set of changes to the contents of a level.
class LevelChanges {
	constructor (level) {
		this.levelNumber = level;
    	this.blockTypeChanges = []; // { x, y, value }
      	this.blockPicChanges = []; // { x, y, value }
	}

	isEmpty() {
		if (this.blockTypeChanges.length > 0) { return false; }
		if (this.blockPicChanges.length > 0) { return false; }
		return true;
	}
}


// Pairs one set of changes to the contents of a level,
// with a copy of the original un-altered data.
// These can be used to move forward and backward in the history of edits.
class LevelUndoHistoryEntry {
	constructor (level) {
    	this.oldChanges = new LevelChanges(level);	// LevelChanges
      	this.newChanges = new LevelChanges(level);	// LevelChanges
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
		if (undoHistory.length < 1) { return null; }

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
