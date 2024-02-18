class ConnectsEditing {
	constructor (mapColumns, mapRows, spriteCanvas, editorTiles) {
		this.mapColumns = mapColumns;
		this.mapRows = mapRows;
		this.spriteCanvas = spriteCanvas;
		this.editorTiles = editorTiles;
	}


	drawAllGuidoConnects(levelData, levelNumber, selectedConnect) {
        const connects = levelData.getDoorConnects(levelNumber);

        for (var index=0; index < 32; index++) {
            const c = connects[index];
            if (c.destinationType == 0) {
                if ((c.x != 0) || (c.y != 11) || (c.destinationX != 0) || (c.destinationY != 0)) {
                    const isSelected = selectedConnect == index;
                    this.drawOneGuidoConnect(
                        c, isSelected, levelData, levelNumber);
                }
            }
        }
        // Redraw the selected connect, even though we're doing it twice,
        // to make sure it appears on top of all the others 
        this.drawOneGuidoConnect(
            connects[selectedConnect], true, levelData, levelNumber);
	}


	drawOneGuidoConnect(c, isSelected, levelData, levelNumber) {

		var canvasContext = this.spriteCanvas.getContext("2d");

		var guidoOutTop = 78;    // Default: Unselected, facing forward, labeled "OUT"
		var guidoOutBottom = 94;

		if (isSelected) {
			guidoOutTop += 32;
			guidoOutBottom += 32;
		}

		canvasContext.putImageData(
			this.editorTiles.tiles[guidoOutBottom],
			(tileWidth*c.destinationX) + (c.destinationXFifthOffset * 8),
			((mapRows-1)-c.destinationY)*tileHeight+16
		);
		canvasContext.putImageData(
			this.editorTiles.tiles[guidoOutTop],
			(tileWidth*c.destinationX) + (c.destinationXFifthOffset * 8),
			((mapRows-2)-c.destinationY)*tileHeight+16
		);

		// We're going to draw an "In" Guido in approximately the
		// location he needs to be standing to activate the type of door tile
		// that the source block is over.

		var guidoInTop = 75;    // Default: Unselected, facing forward, labeled "IN"
		var guidoInBottom = 91;

		const inType = levelData.getTypeBlock(c.x, (mapRows-1)-c.y, levelNumber);

		var guidoInLocation = { xFifth: c.x * 5, yBlock: c.y };

		// Default assumption is that it's a "background door", type 17, so no need to shift

		if (inType == 44) { // Down
			guidoInLocation.yBlock += 1;
			guidoInLocation.xFifth += 3;
		} else if (inType == 45) { // Up
			guidoInLocation.yBlock -= 2;
			guidoInLocation.xFifth += 3;
		} else if (inType == 46) { // To the right
			guidoInLocation.xFifth -= 5;
			guidoInTop -= 1;
			guidoInBottom -= 1;
		} else if (inType == 47) { // To the left
			guidoInLocation.xFifth += 5;
			guidoInTop += 1;
			guidoInBottom += 1;
		}

		if (isSelected) {
			guidoInTop += 32;
			guidoInBottom += 32;
		}

		canvasContext.putImageData(
			this.editorTiles.tiles[guidoInBottom],
			guidoInLocation.xFifth * 8,
			((mapRows-1)-guidoInLocation.yBlock)*tileHeight+16
		);
		canvasContext.putImageData(
			this.editorTiles.tiles[guidoInTop],
			guidoInLocation.xFifth * 8,
			((mapRows-2)-guidoInLocation.yBlock)*tileHeight+16
		);
	}
}
