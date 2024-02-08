var mousey = {

	// Internal utility function for adding parent left-offsets, used by findOffset
	findLeftOffset: function(element) {
        if (element.offsetParent == null) {
            return element.offsetLeft;
		} else {
            return element.offsetLeft + mousey.findLeftOffset(element.offsetParent);
		}
	},

	// Internal utility function for adding parent top-offsets, used by findOffset
	findTopOffset: function(element, lastOffsetParent) {
        const offsetTop = element.offsetTop;
        const scrollTop = element.scrollTop;
        const hasParent = element.parentElement ? true : false;
        // Elements with position "fixed" are pulled out of the context of the regular layout.
        // They appear anchored to the corner of the screen regardless of where the document has scrolled.
        // The offset we're looking for is relative to the document, not the screen.  So, if we encounter
        // an fixed element in our walk upward through the DOM, we return the window scroll offset instead.
        if (element.style.position == "fixed") {
			return window.scrollY;
		} else {
            // Elements with an offsetParent factor in to the positioning of our target element
            // relative to the top corner of the document, but there are sometimes intervening elements
            // in the tree - between the ones linked by offsetParents - that have been scrolled within
            // their containers.  We need to find and account for those as well.
            var usableOffset = 0.0;
			if (lastOffsetParent) {
				if (element === lastOffsetParent) {
					usableOffset = offsetTop;
				}
			}
            const nextOffsetParent = element.offsetParent || null;
            // If the element has no parent, it's the BODY.  Even if the BODY has a scrollTop,
            // it's relative to the window, so we should ignore it.
            if (!hasParent) {
                return usableOffset;
			} else {
                return usableOffset + mousey.findTopOffset(element.parentElement, nextOffsetParent) - scrollTop;
			}
		}
	},

	// Internal utility function to find the page location of an element by walking up the DOM, adding offsets
	// Based on procedure outlined in https://www.w3.org/TR/WCAG-TECHS/SCR34.html
	findOffset: function(element) {
		const x = mousey.findLeftOffset(element);
		let y = mousey.findTopOffset(element, element);
		return { x: x, y: y};
	},


	// Using the given block canvas, and a click event, determine the map block beneath the click.
	mouseEventToBlockLocation: function(container, ev, topGutter, xMax, yMax) {

		const s = getComputedStyle(container);
		const borderTop = parseInt(s.getPropertyValue("border-top-width").replace('px',''));
		const borderLeft = parseInt(s.getPropertyValue("border-left-width").replace('px',''));
		const x = ev.offsetX - borderLeft;
		const y = ev.offsetY - borderTop;

		const blockX = Math.min(Math.floor(x / 40.0), xMax);
		// Subtracting 16 for the gutter at the top of the canvas.
		// Note this means we can return an X of -1.
		const blockY = Math.min(Math.floor((y - topGutter) / 32.0), yMax);

		return { x: blockX, y: blockY};
	}
};