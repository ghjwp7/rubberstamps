// openscad module to make a text-stamp.  Written 2 June 2019 by
// James Waldby.  © 2019.  Available for use without warranty under
// GPL v3 terms per http://www.gnu.org/licenses/gpl.html

module jStamp (theText="Put your text here", // The text of stamp
               stampScale=9,   // scale, as "height above baseline"
               baseWidth=70,   // Base Width, mm
               baseBreadth=24, // Base Breadth, mm
               baseThick=4,    // Base Thickness, mm
               standOut=2 )    // Letter projection, mm
{ union() {
    linear_extrude(baseThick+standOut)
      mirror([1,0,0]) text(theText, size=stampScale, halign="center");
    translate([-baseWidth/2, -baseBreadth/3, 0]) 
      cube([baseWidth, baseBreadth, baseThick], center=false);
  }
}
/* Local Variables:   */
/* mode:        scad  */
/* tab-width:      2  */
/* c-basic-offset: 2  */
/* End:               */
