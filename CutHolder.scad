use <libs/aluprofiles.scad>
use <libs/roundedcornerbox.scad>
use <LabelApplicator.scad>

$fn=200;

COLOR_ALU = [0.77, 0.77, 0.8];

draw_aluprofile = false;
draw_cutholder = true;

if (draw_aluprofile) {
    color(COLOR_ALU) {
        translate([0, 5, 10])
            rotate([0, 90, 0])
                2020Profile(600);
        translate([200, 0, 20])
            rotate([0, 90, 90])
                608ZZ_house();

    }
    translate([125, 35, 30])
        la_walze();
}


translate([230, -5, 20])
    rotate([0, 0, 90])
        cut_holder();


module alu_profile(x) {
    tolerance = 0.2;
    
    color(COLOR_ALU) {
        cube([x, 40.5 + tolerance, 2.0 + tolerance]);        
        translate([0, 1.5 + tolerance, 0])
            rotate([90, 0, 0])
                cube([x, 20.25 + tolerance, 2.0 + tolerance]);
    }
}

module cut_holder() {
    difference() {
        union() {
            hull() {
                translate([10, 65, 0])
                    cylinder(h=10, d=20);
                translate([10, 145, 0])
                    cylinder(h=10, d=20);

                translate([0, 75, 0])
                    cylinder(h=10, d=20);
                translate([0, 135, 0])
                    cylinder(h=10, d=20);


            }
        }
        union() {
            translate([40, 105, -2])
                cylinder(h=22, d=66);
            translate([-5, 75, 5])
                rotate([0, -90, -90])
                    #alu_profile(50);
            translate([-5, 135, 55])
                rotate([0, 90, -90])
                    #alu_profile(50);

            translate([10, 65 , -2])                 
                cylinder(h=25, d=5.4);       //fixing hole  1
            translate([10, 65, 6])   
                cylinder(h=5, d=9);          //fixing hole 1 head
            translate([10, 145 , -2])           
                cylinder(h=25, d=5.4);       //fixing hole 2
            translate([10, 145, 6])    
                cylinder(h=5, d=9);          //fixing hole 2 head            
        }
    }
}
