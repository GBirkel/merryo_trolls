class LevelSet {
	constructor (mapColumns, mapRows) {
		this.mapColumns = mapColumns;
		this.mapRows = mapRows;
		this.levelData = null;
	}


	async load(levelEncoded) {
		const levelBlob = await fetch(levelEncoded).then(res => res.blob()).then(res => res.arrayBuffer())

		// Make a dataview object to inspect our raw data,
		// then declare an array of exactly the structure we want
		// (in this case 8-bit unsigned bytes) and cast the data into that array.
		const data = new DataView(levelBlob);
		var byteData = new Uint8Array(data.byteLength / Uint8Array.BYTES_PER_ELEMENT);
		var len = byteData.length;
		for (var j = 0; j < len; ++j) {
			byteData[j] = data.getUint8(j * Uint8Array.BYTES_PER_ELEMENT, true);
		}
		this.levelData = byteData;
	}

	getTypeBlock(x, y, levelNumber) {
    	return this.levelData[y+(x*this.mapRows) + (levelNumber * 0x4000)] & 0x3F;
	}

	getPictureBlock(x, y, levelNumber) {
    	return this.levelData[y+(x*this.mapRows) + (levelNumber * 0x4000) + 0x1000];
	}

	setTypeBlock(x, y, levelNumber, value) {
    	this.levelData[y+(x*this.mapRows) + (levelNumber * 0x4000)] = value;
	}

	setPicBlock(x, y, levelNumber, value) {
    	this.levelData[y+(x*this.mapRows) + (levelNumber * 0x4000) + 0x1000] = value;
	}


	// An inline cheat-sheet on the "destinationType" and "destinationNumber" values, taken
	// from the Super Merryo Trolls writeup:
	// 0: Door opens to another location on the same level.
	//    The second half of the byte (destinationNumber) is the letter to use as a subscript.
	//	  (0 for 'a', 1 for 'b', et cetera.)  For example, the fourth pipe on World 1-Aa
	//	  leads to an underground chamber on the same level, and that chamber is World 1-Ab.
	//	  That door's value for byte 8 is $10.  Inside the underground chamber, another pipe
	//    leads back to the surface.  In that case, the destination is 1-Aa, so the value for
	//	  byte 8 is $00.
	// 1: Door opens on a different level in the same four-level chunk.
	//    The second half of the byte identifies the level.
	//	  For example, if the chunk contains levels 5 through 8, then a byte of $21 would
	//	  pint to level 7, and $31 would point to level 8
	// 2: Door opens on a level in a different four-level chunk.
	//    The second half of byte 8 identifies which chunk to load, and the first level
	//    in the chunk is where Guido resumes play.
	// 3: Door leads to a different world.
	//	  The second half of the byte identifies the world.

	getDoorConnects(levelNumber) {
		var connects = [];
		for (var c = 0; c < 32; c++) {
			// Offset to this connect in given level
			const cOffset = (c*8) + (levelNumber * 0x4000) + 0x2800;
			const sourceLocationWord = this.levelData[cOffset] + (this.levelData[cOffset+1] * 0x100);
			// This was not stored in a straightforward way.  See MapLocWrite in MAIN.S code.
			const sourceLocationX = Math.floor(sourceLocationWord / this.mapRows);
			const sourceLocationY = (this.mapRows - 1) - (sourceLocationWord % this.mapRows)

			const connect = {
				x: sourceLocationX,
				y: sourceLocationY,
				destinationX: this.levelData[cOffset+2],
				destinationY: this.levelData[cOffset+3],
				destinationWindowX: this.levelData[cOffset+4],
				destinationXFifthOffset: this.levelData[cOffset+5],
				extraData: this.levelData[cOffset+6],
				destinationType: this.levelData[cOffset+7] & 0x03,
				destinationId: (this.levelData[cOffset+7] & 0xF0) / 16
			};
			connects.push(connect);
		}
		return connects;
	}

	writeDoorConnect(levelNumber, connectNumber, connectData) {
		// Offset to this connect in given level
		const cOffset = (connectNumber*8) + (levelNumber * 0x4000) + 0x2800;

		// This was not stored in a straightforward way.  See MapLocWrite in MAIN.S code.
		const sourceLocationWord = (connectData.x*this.mapRows)+(this.mapRows-1) - connectData.y;
		this.levelData[cOffset] = sourceLocationWord & 0xFF;
		this.levelData[cOffset+1] = Math.floor(sourceLocationWord / 0x100);
		
		this.levelData[cOffset+2] = connectData.destinationX;
		this.levelData[cOffset+3] = connectData.destinationY;
		this.levelData[cOffset+4] = connectData.destinationWindowX;
		this.levelData[cOffset+5] = connectData.destinationXFifthOffset;

		this.levelData[cOffset+6] = connectData.extraData;
		this.levelData[cOffset+7] = connectData.destinationType + (connectData.destinationId * 0x10);
	}
}
