
//rounded_corner_box(20, 100, 5, 5);
rounded_corner_box_2D(20, 100, 5);

module rounded_corner_box_2D(x, y, d) {
    translate([d, d])
    union() {
        translate([-d/2, -d/2])
            circle(d=d);
        translate([x-(1.5*d), -d/2])
            circle(d=d);
        translate([x-(1.5*d), y-(1.5*d)])
            circle(d=d);
        translate([-d/2, y-(1.5*d)])
            circle(d=d);
        translate([-d, -d/2])
            square([x, y-d]);
        translate([-d/2, -d])
            square([x-d, y]);      
    }
}

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