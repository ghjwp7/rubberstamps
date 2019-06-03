/* [Stamp Text and Base Params:] */
// Text of stamp
theText="Vote by Mail";
// Scale of stamp, "height above baseline"
stampScale=9;
// Base Width, mm
baseWidth=70;
// Base Length, mm
baseBreadth=24;
// Base Thickness, mm
baseThick=4;
// Letter projection, mm
standOut=2;

use <jStamp.scad>

jStamp (theText, stampScale, baseWidth, baseBreadth, baseThick, standOut, showDetails);

/* Local Variables:   */
/* mode:        scad  */
/* tab-width:      2  */
/* c-basic-offset: 2  */
/* End:               */
