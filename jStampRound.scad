// openscad module to make a text-stamp.  Written 3 June 2019 by
// James Waldby.  © 2019.  Available for use without warranty under
// GPL v3 terms per http://www.gnu.org/licenses/gpl.html
// Note, for comments on more-accurate text-on-cylinder, see:
// https://openhome.cc/eGossip/OpenSCAD/2DtoCylinder.html

/* [Stamp Text and Base Width:] */
// Text of stamp
theText="Vote by Mail!";
// Font description
fontCode="Liberation Sans:style=Bold";
// Scale of text, "height above baseline"
textScale=9;
// Letter projection, mm
standOut=1.8;
// Base Width, mm
baseWidth=80;
// Render before view if checked
renderFirst=true;

/* [Handle and Cylinder parameters] */
// Base Thickness, mm
baseThick=3.9;
// Handle height
hHeight=15;
// Handle rounding radius
hRRadius=5;
// Handle thickness
hThick=5;
// Cylinder Radius
cylRadius = 120;
// Segments per Circle
$fn=60;

baseBreadth = (textScale*3)/2;
hFlatCutoff = hRRadius*(1-sqrt(1/2));
hFinalRaise = -hHeight-hRRadius+hFlatCutoff;
segArm = sqrt(cylRadius*cylRadius-baseWidth*baseWidth/4);
textdepth  = standOut + cylRadius - segArm;
overallHeight = hRRadius+hHeight+textdepth-hFlatCutoff;

module handle() {
  // Rounded part near top of handle
  translate([0,hHeight,0]) {
    intersection() {
      rotate([0, 90, 0])
      cylinder(r=hRRadius, h=baseWidth, center=true);
      translate([0,-hFlatCutoff,0])
        cube([baseWidth, 2*hRRadius, 2*hRRadius], center=true);
    }
  }
  // Thin part at middle of handle
  translate([-baseWidth/2, 0, -hThick/2])
    cube([baseWidth, hHeight, hThick], center=false);
  // Triangular sloping part of handle, to support text part
  translate([-baseWidth/2,baseBreadth/sqrt(3)/2,0])
    rotate([0, 90, 0])          // align triangular prism with x axis
      linear_extrude(baseWidth) // extrude the triangle along z axis
        rotate([0, 0, -30])     // put base of triangle to left
          circle(r=baseBreadth/sqrt(3), $fn=3);
}

// Create text-on-cylinder-segment, offset from origin by ? 
module textPart() {
  intersection() {
    translate([0,segArm,0]) {
      union() {
        intersection() {
          cylinder(r=cylRadius+standOut, h=baseBreadth, center=true);
          rotate([90, 0, 0]) linear_extrude(cylRadius+standOut)
            mirror([1,0,0])
            text(theText, size=textScale, valign="center", halign="center");
        }
        cylinder(r=cylRadius, h=baseBreadth, center=true);
      }
    }
    translate([-baseWidth/2,-textdepth,-baseBreadth/2])
      cube([baseWidth, textdepth, baseBreadth], center=false);
  }
}

module assembly() {
  rotate ([-90,0,0])
    translate ([0, hFinalRaise, 0]) {
      textPart();
      handle();
  }
  // Kludge: move head away from assembly at end, since my slicer doesn't
  translate([baseWidth/2-1, baseBreadth/2-1, overallHeight+1]) cube(1);
}

if (renderFirst) {  
  render() assembly();
} else {
  assembly();
}
