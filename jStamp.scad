// openscad module to make a text-stamp.  Written 2 June 2019 by
// James Waldby.  © 2019.  Available for use without warranty under
// GPL v3 terms per http://www.gnu.org/licenses/gpl.html

/* [Stamp Text and Base Params:] */
// Text of stamp
theText="Vote by Mail";
// Font description
fontCode="Liberation Serif:style=Bold";
// Scale of stamp, "height above baseline"
stampScale=9;
// Base Width, mm
baseWidth=70;
// Base Thickness, mm
baseThick=3.9;
// Letter projection, mm
standOut=1.8;

baseBreadth=(stampScale*3)/2;
{ union() {
    color("green")
    linear_extrude(baseThick+standOut)
      mirror([1,0,0])
        text(theText, size=stampScale, font=fontCode, halign="center");
    translate([-baseWidth/2, -baseBreadth/4, -0.01]) 
      cube([baseWidth, baseBreadth, baseThick], center=false);
  }
}

/* Local Variables:   */
/* mode:        scad  */
/* tab-width:      2  */
/* c-basic-offset: 2  */
/* End:               */
