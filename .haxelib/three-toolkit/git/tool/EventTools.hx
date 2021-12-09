package tool;

import js.html.WheelEvent;

/**
	Tries to isolate vertical or horizontal scrolling with a continuous mapping.
	Originally written for valis
**/
function scrollDirectionDisambiguation(event: WheelEvent): {x: Float, y: Float} {
	// gesture disambiguation; when dominantly zooming we want to reduce panning speed
	// normalize scroll vector
	var scrollVectorLengthSq = event.deltaX * event.deltaX + event.deltaY * event.deltaY;
	// avoid divide by 0 normalization issues
	if (scrollVectorLengthSq <= 0) {
		scrollVectorLengthSq = 1;
	}
	var scrollVectorLength = Math.sqrt(scrollVectorLengthSq);
	var normScrollX = event.deltaX / scrollVectorLength; // cosAngleY
	var normScrollY = event.deltaY / scrollVectorLength; // cosAngleX
	// as normScrollVectorY approaches 1, we should scale event.deltaX to
	var absAngleY = Math.acos(Math.abs(normScrollY));
	var fractionalAngleY = 2 * absAngleY / (Math.PI); // 0 = points along y, 1 = points along x
	var absAngleX = Math.acos(Math.abs(normScrollX));
	var fractionalAngleX = 2 * absAngleX / (Math.PI); // 0 = points along x, 1 = points along y

	// use fraction angle to reduce x as angle approaches y-pointing
	// see https://www.desmos.com/calculator/butkwn0xdt for function exploration
	var edge = 0.75;
	var xReductionFactor = Math.sin(
		Math.pow(Math.min(fractionalAngleY / edge, 1), 3) * (Math.PI / 2)
	);
	var yReductionFactor = Math.sin(
		Math.pow(Math.min(fractionalAngleX / edge, 1), 3) * (Math.PI / 2)
	);

	return {
		x: event.deltaX * xReductionFactor,
		y: event.deltaY * yReductionFactor,
	}
}