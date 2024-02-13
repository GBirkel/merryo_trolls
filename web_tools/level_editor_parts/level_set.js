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
}
