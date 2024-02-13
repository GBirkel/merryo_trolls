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
		const mw = this.mapWidth;
		const mh = this.mapHeight;
		const sc = this.selectionColumns;

		changes.forEach(function(item) {
			if ((item.x >= 0) && (item.x < mw)) {
				if ((item.y >= 0) && (item.y < mh)) {
					const s = sc[item.x];
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
		const mw = this.mapWidth;
		const mh = this.mapHeight;
		const sc = this.selectionColumns;

		changes.forEach(function(item) {
			if ((item.x >= 0) && (item.x < mw)) {
				if ((item.y >= 0) && (item.y < mh)) {
					const s = sc[item.x];
					s.delete(item.y);
				}
			}
		});
	}

	isEmpty () {
		for (var i=0; i < this.mapWidth; i++) {
			const s = this.selectionColumns[i];
			if (s.size > 0) { return false; }
		}
		return true;
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

	// Returns {x: int, y: int} for the block at the upper left corner of the
	// smallest rectangle that encompasses the entire selection.
	getUpperLeftCorner () {
		const wholeSelection = this.all();
		if (wholeSelection.length <= 0) { return {x: 0, y: 0}; }

		var xLowest = wholeSelection[0].x;
		var yLowest = wholeSelection[0].y;

		for (var i=1; i < wholeSelection.length; i++) {
			xLowest = Math.min(xLowest, wholeSelection[i].x);
			yLowest = Math.min(yLowest, wholeSelection[i].y);
		}
		return { x: xLowest, y: yLowest };
	}

	clear () {
		for (var i=0; i < this.mapWidth; i++) {
			const s = this.selectionColumns[i];
			s.clear();
		}
	}
}
