

module rounded_corner_box(x, y, z, d)  {
    translate([d, d, 0])
    union() {
        cylinder(z, d , d);
        translate([x-(2*d), 0, 0])
            cylinder(z, d , d);
        translate([x-(2*d), y-(2*d), 0])
            cylinder(z, d , d);
        translate([0, y-(2*d), 0])
            cylinder(z, d , d);
        translate([-d, 0, 0])
            cube([x, y-(2*d), z]);
        translate([0, -d, 0])
            cube([x-(2*d), y, z]);      
    }
}