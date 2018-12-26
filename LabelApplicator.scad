use <libs/aluprofiles.scad>

$fn=200;

COLOR_ALU = [0.77, 0.77, 0.8];

la_width = 230;
la_height = 150;
la_length = 600;
la_material_thickness = 10;

draw_upper = false;
draw_lower = true;
draw_aluprofile = true;
draw_bolt = false;
draw_bolts = false;
draw_sideparts = false;


608ZZ_house();

if (draw_sideparts) {
    union() {
        la_sidepart_both();

        translate([455, la_width - 25, 100])
            rotate([90, 0, 0])
                la_walze();
        translate([537, la_width - 25, 100])
            rotate([90, 0, 0])
                la_walze();
        if (draw_aluprofile) {
            color(COLOR_ALU) {
                translate([300, 10, 70])
                    rotate([0, 90, 0])
                        2020Profile(600);
                translate([300, la_width-10, 70])
                    rotate([0, 90, 0])
                        2020Profile(600);
            }
        }
        translate([530, 0, 65])
            rotate([0, 0, 90])
                608ZZ_house();

        translate([612, 0, 65])
            rotate([0, 0, 90])
                608ZZ_house();

        translate([530, la_width-20, 65])
            rotate([0, 0, 90])
                608ZZ_house();

        translate([612, la_width-20, 65])
            rotate([0, 0, 90])
                608ZZ_house();


        
    }
}

if (draw_bolt || draw_bolts) {
    translate([10, 45, 11.5])
        rotate([0, 180, 0])
            bolt();
}
if (draw_bolts) {
    translate([10, 105, 11.5])
        rotate([0, 180, 0])
            bolt();
}







// modules

module 608ZZ_house() {
    if (draw_upper || draw_lower) {
        difference() {
            union() {
                if (draw_upper) {
                    608ZZ_Roof();        
                }
                if (draw_lower) {
                    translate([0, 35, 15])
                        //#cube([20, 80, 20]);                //block
                        rounded_corner_box(20, 80, 20, 10);
                }
            }
            union() {
                union() {                           //Rundungen
                    translate([-1, 45, 35])
                        rotate([0, 90, 0])
                            cylinder(22, d1=25, d2=25);
                    translate([-1, 105, 35])
                        rotate([0, 90, 0])
                            cylinder(22, d1=25, d2=25);
                    translate([-1, 20, 22.5])
                        cube([22, 25, 25]);
                    translate([-1, 105, 22.5])
                        cube([22, 25, 25]);
                }
                translate([6, 75, 35])
                    rotate([0, 90, 0])
                        608ZZ();
                translate([10, 45 , 0])                 
                    cylinder(35, d1=5.4, d2=5.4);      //fixing hole  1
                translate([10, 45, 18])    
                    cylinder(8, d1=8.5, d2=8.5);       //fixing hole 1 head
                translate([10, 105 , 0])           
                    cylinder(35, d1=5.4, d2=5.4);      //fixing hole 2
                translate([10, 105, 18])    
                    cylinder(8, d1=8.5, d2=8.5);       //fixing hole 2 head
             }
        }
    }
    if (draw_upper) {
        union() {                           // upper lippen
            lippe();
            translate([0, 150, 74])
                rotate([180, 0, 0])
                    #lippe();
        }
    }

    if (draw_lower) {
        union() {                           // lower lippen
            translate([0, 0, -4])
                difference() {
                    lippe();
                    translate([10, 52, 36])
                        rotate([0, 0, 30])
                            M3();
                }
            translate([0, 150, 70])
                rotate([180, 0, 0])
                    difference() {
                        lippe();
                        translate([10, 52, 38])
                            rotate([0, 0, 30])
                                M3();
                    }
        }
    }

}

module lippe() {
    difference() {
        union() {
            translate([10, 52, 35])
                cylinder(4, d1=10, d2=10);
            translate([5, 52, 35])
                cube([10, 7, 4]);
        }
        translate([10, 52, 30])
            cylinder(12, d1=4.0, d2=4.0);
    }
}

module 608ZZ() {
    //608zz has outer diameter of 22mm
    //and inner 8mm (15mm with thread and bolt)
    //thickness of 7mm
    //adding 0.2 tolerance
    translate([0, 0, 0.2])
        cylinder(7.2, d1=22.2, d2=22.2);
    translate([0, 0, -7])
       cylinder(22, d1=15, d2=15);
}
module 608ZZ_Roof() {
    difference() {
        union() {
            translate([0, 75, 35])
                rotate([0, 90, 0])
                    cylinder(20, d1=35, d2=35);
        }
        translate([-1, 57.5, 17.5])
            cube([22, 35, 17.5]);                //block
        translate([6, 75, 35])
            rotate([0, 90, 0])
                608ZZ();
    }
}

module bolt() {
    translate([-5.5, -7.6, 2.6])
    rotate([270,0,0])
    difference() {
        linear_extrude(15.2)
            polygon(points=[[3, 0.2],
                            [0, 3], 
                            [0, 4],
                            [3.2, 4], 
                            [3.2, 5.2], 
                            [7.8, 5.2], 
                            [7.8, 4], 
                            [11, 4], 
                            [11, 3], 
                            [8, 0.2], 
                            [3,0.2]], convexity=10);
            
            translate([5.5, 1.80, 7.6]) 
                rotate([90,0,0]) 
                    M4();
            translate([5.5, 15.2, 7.6])  
                rotate([90,0,0])
                    cylinder(15, d1=4.3, d2=4.3);
    }
}

module M4() {
    hull() {
        for (i=[0:60:180]) {
            rotate([0, 0, i])
                //real: 6.95, 4.0, 3.0
                cube([7.6, 3.8, 3.4], center=true);                
        }
    }
}    
module M3() {
    hull() {
        for (i=[0:60:180]) {
            rotate([0, 0, i])
                //real: 5.5, 3.4, 2.4
                cube([6.1, 3.2, 2.8], center=true);                
        }
    }
}

module M3_TestPrint() {
    difference() {
        cylinder(5, d1=10, d2=10);
        translate([0, 0, 1])
            M3();
        cylinder(10, d1=3.4, d2=3.4);
    }
}

module la_walze() {
    cylinder(180, d1=56, d2=56);
    translate([0, 0, -30])
        cylinder(240, d1=8, d2=8);
}

module la_set_hole_at(x, y, d) {
        translate([x, y, -4])
            cylinder((la_material_thickness * 2) + 2, d1=d + 0.2, d2=d + 0.2);
}

module la_sidepart() {
    difference() {
        rounded_corner_box(la_length, la_height, 10, 20);
        la_set_hole_at(30, 30, 8);
        la_set_hole_at(30, 120, 8);
        la_set_hole_at(230, 120, 8);
        la_set_hole_at(455, 100, 15);
        la_set_hole_at(537, 100, 15);
        la_set_hole_at(la_length-30, 30, 8);
        la_set_hole_at(la_length-30, 120, 8);
        translate([la_length / 4 , -20, -1])
            rounded_corner_box(la_length / 2, 40, 14, 14);
        translate([la_length - 180 , 100, -1])
            rounded_corner_box(200, 60, 14, 14);

    }
}
module la_sidepart_both() {
    rotate([90, 0, 0]) 
        la_sidepart();
    translate([0, la_width + la_material_thickness, 0])
        rotate([90, 0, 0])
            la_sidepart();
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

    

