class MapSelection {
	constructor (w, h) {
		this.mapWidth = w;
		this.mapHeight = h;

		this.selectionColumns = [];
		for (var i=0; i < this.mapWidth; i++) {
			this.selectionColumns[i] = new Set();
		}
	}

	// Accepts an array of {x: int, y: int}
	isSelected (x, y) {
		if ((x < 0) || (x >= this.mapWidth)) { return false; }
		if ((y < 0) || (y >= this.mapHeight)) { return false; }
		const s = this.selectionColumns[x];
		return s.has(y);
	}

	// Accepts an array of {x: int, y: int}
	select (changes) {
		changes.forEach(function(item, index, array) {
			if ((item.x >= 0) && (item.x < this.mapWidth)) {
				if ((item.y >= 0) && (item.y < this.mapHeight)) {
					const s = this.selectionColumns[item.x];
					s.add(item.y);
				}
			}
		});
	}

	// Accepts two sets of x,y values describing the opposite corners of a rectangle to fill.
	selectRectangle(first, second) {
		const xa = Math.max(Math.min(first.x, second.x), 0);
		const xb = Math.min(Math.max(first.x, second.x), this.mapWidth);
		const ya = Math.max(Math.min(first.y, second.y), 0);
		const yb = Math.min(Math.max(first.y, second.y), this.mapHeight);
		for (var x=xa; x <= xb; x++) {
			const s = this.selectionColumns[x];
			for (var y=ya; y <= yb; y++) {
				s.add(y);
			}
		}
	}

	// Accepts an array of {x: int, y: int}
	deselect (changes) {
		changes.forEach(function(item, index, array) {
			if ((item.x >= 0) && (item.x < this.mapWidth)) {
				if ((item.y >= 0) && (item.y < this.mapHeight)) {
					const s = this.selectionColumns[item.x];
					s.delete(item.y);
				}
			}
		});
	}

	// Returns an array of {x: int, y: int} describing all selected blocks
	all () {
		var wholeSelection = [];
		for (var i=0; i < this.mapWidth; i++) {
			const s = this.selectionColumns[i];
			for (let item of s) {
				wholeSelection.push({x: i, y: item});
			}
		}
		return wholeSelection;
	}

	clear () {
		for (var i=0; i < this.mapWidth; i++) {
			const s = this.selectionColumns[i];
			s.clear();
		}
	}
}
