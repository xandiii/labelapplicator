use <libs/aluprofiles.scad>

$fn=200;

COLOR_ALU = [0.77, 0.77, 0.8];

la_width = 200;
la_height = 150;
la_length = 600;
la_material_thickness = 10;

draw_upper = false;
draw_lower = true;
draw_aluprofile = false;
draw_bolt = false;
draw_bolts = false;
draw_sideparts = false;


if (draw_sideparts) {
    difference() {
        la_sidepart();

        translate([350, la_width - la_material_thickness, 90])
            rotate([90, 0, 0])
                la_walze();
        translate([500, la_width - la_material_thickness, 90])
            rotate([90, 0, 0])
                la_walze();

    }
}


if (draw_aluprofile) {
    color(COLOR_ALU) {
        translate([10, 75, 5])
            rotate([90, 0, ,0])
                2020Profile(150);
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



if (draw_upper || draw_lower) {
    difference() {
        union() {
            if (draw_upper) {
                608ZZ_Roof();        
            }
            if (draw_lower) {
                translate([0, 35, 15])
                    cube([20, 80, 20]);                //block
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
            translate([-1, 10, 80])
                rotate([0, 90, 0])
                    cylinder(22, d1=30, d2=30);
            translate([10, 45 , 0])                 //fixing hole 
                cylinder(35, d1=5.2, d2=5.2);      
            translate([10, 45, 18])    
                cylinder(8, d1=8.2, d2=8.2);
            translate([10, 105 , 0])           
                cylinder(35, d1=5.2, d2=5.2);      //fixing hole
            translate([10, 105, 18])    
                cylinder(8, d1=8.2, d2=8.2);
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
            lippe();
        translate([0, 150, 70])
            rotate([180, 0, 0])
                #lippe();
    }
}






// modules

module 608ZZ() {
    //608zz has outer diameter of 22mm
    //and inner 8mm (15mm with thread and bolt)
    //thickness of 7mm
    //adding 0.2 tolerance
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
            cube([7.6, 3.8, 3.4], center=true);                
        }
    }
}    
module M3() {
    hull() {
        for (i=[0:60:180]) {
            rotate([0, 0, i])
            cube([6.1, 3.0, 3.0], center=true);                
        }
    }
}    


module lippe() {
    difference() {
        union() {
            translate([10, 53, 35])
                cylinder(4, d1=10, d2=10);
            translate([5, 53, 35])
                cube([10, 7, 4]);
        }
        translate([10, 53, 30])
            cylinder(12, d1=3.2, d2=3.2);
    }
}






module la_walze() {
    cylinder(180, 56, 56);
    translate([0, 0, -30])
        cylinder(240, 8, 8);
}

module la_set_hole_at(x, y, d) {
        translate([x, y, 0])
            cylinder(la_material_thickness * 2, d, d);
}

module la_sidepart_both() {
    difference() {
        rounded_corner_box(la_length, la_height, 10, 20);
        la_set_hole_at(30, 30, 10);
        la_set_hole_at(30, 120, 10);
        la_set_hole_at(la_length-30, 30, 10);
        la_set_hole_at(la_length-30, 120, 10);
        translate([la_length / 4 , -20, 0])
            rounded_corner_box(la_length/2, 40, 10, 10);
    }
}
module la_sidepart() {
    rotate([90, 0, 0]) 
        la_sidepart_both();
    translate([0, la_width + la_material_thickness, 0])
        rotate([90, 0, 0])
            la_sidepart_both();
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

    

