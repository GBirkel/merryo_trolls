class EditorTileset {
	constructor (tempCanvas) {
		this.tempCanvas = tempCanvas;
		this.tiles = [];
		this.tilesColumns = 0;
		this.tilesRows = 0;
		this.tileWidth = 0;
		this.tileHeight = 0;
	}

	async load(sourceImage, tilesColumns, tilesRows, tileWidth, tileHeight) {

		this.tilesColumns = tilesColumns;
		this.tilesRows = tilesRows;
		this.tileWidth = tileWidth;
		this.tileHeight = tileHeight;

		// Load the source image.
		const editorTilesImg = new Image();
		editorTilesImg.src = sourceImage;
		// Fancy new Image property, solving the "IS IT LOADED?" problem:
		// https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/decode
		await editorTilesImg.decode();

		var editorTiles = [];

		// Grab our temporary canvas and draw the source image to it, so we can read chunks back out.
		var tempContext = this.tempCanvas.getContext("2d");
		tempCanvas.width = editorTilesImg.width;
		tempCanvas.height = editorTilesImg.height;
		tempContext.drawImage(editorTilesImg, 0, 0);

		for (var i=0; i < tilesRows; i++) {
			for (var j=0; j < tilesColumns; j++) {
				editorTiles.push(tempContext.getImageData(j*tileWidth, i*tileHeight, tileWidth, tileHeight));
			}
		}

		this.tiles = editorTiles;
	}
}


class WorldTileset {
	constructor (tempCanvas, tempBlocksetCanvas, tempBlockCanvas) {
		this.tempCanvas = tempCanvas;
		this.tempBlocksetCanvas = tempBlocksetCanvas;
		this.tempBlockCanvas = tempBlockCanvas;

		this.tilesColumns = 0;
		this.tilesRows = 0;
		this.tileWidth = 0;
		this.tileHeight = 0;

		this.tiles = [];
		this.tilePointers = [];
	}

	async load(sourceImage, blocksetPointers, tilesColumns, tilesRows, tileWidth, tileHeight) {

		this.tilesColumns = tilesColumns;
		this.tilesRows = tilesRows;
		this.tileWidth = tileWidth;
		this.tileHeight = tileHeight;

		// Load the source image.
		const mapTilesImg = new Image();
		mapTilesImg.src = sourceImage;
		// Fancy new Image property, solving the "IS IT LOADED?" problem:
		// https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement/decode
		await mapTilesImg.decode();

		// Grab our temporary canvas and draw the source image to it, so we can read chunks back out.
		var tempContext = this.tempCanvas.getContext("2d");
		tempCanvas.width = mapTilesImg.width;
		tempCanvas.height = mapTilesImg.height;
		tempContext.drawImage(mapTilesImg, 0, 0);

		// Prepare our second canvas where we unroll the blockset into one vertical stripe.
		var secondContext = this.tempBlocksetCanvas.getContext("2d");
		secondContext.width = tileWidth;
		secondContext.height = tileHeight * (tilesColumns * tilesRows);

		for (var i=0; i < tilesRows; i++) {
			for (var j=0; j < tilesColumns; j++) {
				const oneBlock = tempContext.getImageData(
						j*tileWidth,
						i*tileHeight,
						tileWidth,
						tileHeight
				);
				secondContext.putImageData(oneBlock,0,((i*tilesColumns)+j)*tileHeight);
			}
		}

		const tilePointersBlob = await fetch(blocksetPointers).then(res => res.blob()).then(res => res.arrayBuffer())
 
		// Make a dataview object to inspect our raw data,
		// then we declare an array of exactly the structure we want
		// (in this case 8-bit unsigned bytes) and cast the data into that array.
		var data = new DataView(tilePointersBlob);
		// The resulting tilePointers data should always be 512 bytes long
		var tilePointers = new Uint8Array(512 / Uint8Array.BYTES_PER_ELEMENT);
		for (var j = 0; j < 512; ++j) {
			tilePointers[j] = data.getUint8(j * Uint8Array.BYTES_PER_ELEMENT, true);
		}

		this.tilePointers = tilePointers;
		this.resolvePointers();
	}


	changeBlockPointer(block, x, y, xOffset, yOffset) {
		const oneBlockInBytes = (this.tileWidth / 2) * (this.tileHeight / 2) / 2;
		const blockOffset = oneBlockInBytes * (x + (y * this.tilesColumns));
		const hOffset = xOffset / 4;
		const vOffset = (yOffset / 2) * (this.tileWidth / 4);
		const offset = blockOffset + vOffset + hOffset;
		this.tilePointers[block*2] = offset % 0x100;
		this.tilePointers[(block*2)+1] = Math.floor(offset / 0x100);
	}


	resolvePointers() {
		var mapTiles = [];

		var secondContext = this.tempBlocksetCanvas.getContext("2d");

		// Prepare our single-block canvas where we assemble completed blocks from pieces.
		var singleBlockContext = this.tempBlockCanvas.getContext("2d");
		singleBlockContext.width = this.tileWidth;
		singleBlockContext.height = this.tileHeight;

		for (var j = 0; j < 256; ++j) {
			// We combine byte pairs to make 16-bit pointers into the image data.
			// Note that these pointers refer to bytes, and in Super Hi Res, each byte contains two
			// pixels.  So these values need to be doubled to reach the correct pixel values in our canvas.
			const tilePointer = (this.tilePointers[j*2] + (256 * this.tilePointers[(j*2)+1])) * 2;
			const blockFraction = tilePointer % 20;
			const blockIndex = Math.floor(tilePointer / 20);
			// The canvas is using blocks drawn at 2x scale, e.g. 40x32 instead of 20x16.
			// So we need to double our values again.
			const blockRightPart = secondContext.getImageData(
					blockFraction * 2,
					blockIndex * 2,
					this.tileWidth - (blockFraction*2),
					this.tileHeight
			);
			singleBlockContext.putImageData(blockRightPart,0,0);

			// If the pointer has a fractional remainder, the block wraps partially around
			// to the next "row" in the stipe data, so we need to do a second copy to catch
			// the right side of the block, one row down.
			if (blockFraction > 0) {
				// The canvas is using blocks drawn at 2x scale, e.g. 40x32 instead of 20x16.
				// So we need to double our values again.
				const blockRightPart = secondContext.getImageData(
						0,
						(blockIndex * 2) + 2,
						blockFraction * 2,
						this.tileHeight
				);
				singleBlockContext.putImageData(blockRightPart,this.tileWidth - (blockFraction * 2),0);
			}

			const blockComplete = singleBlockContext.getImageData(
					0, 0, this.tileWidth, this.tileHeight
			);
			mapTiles.push(blockComplete);
		}

		this.tiles = mapTiles;
	}


	pointersAsHrefData() {
		const d = this.tilePointers;
		const binstr = Array.prototype.map.call(d, function (ch) {
			return String.fromCharCode(ch);
		}).join('');
	    const b64encoded = btoa(binstr);
    	const linkSource = 'data:application/octet-stream;base64,' + b64encoded;
		return linkSource;
	}
}
