use <libs/aluprofiles.scad>
use <libs/roundedcornerbox.scad>
use <CutHolder.scad>

$fn=200;

COLOR_ALU = [0.77, 0.77, 0.8];
COLOR_WHITE = [0.9, 0.9, 0.8];

la_width = 230;
la_height = 150;
la_length = 600;
la_material_thickness = 10;

draw_upper = true;
draw_lower = true;
draw_aluprofile = true;
draw_bolt = false;
draw_bolts = false;
draw_sideparts = true;
draw_stangen = true;
draw_paper_roll = true;
draw_paper_holder_right = true;
draw_paper_holder_middle = true;
draw_paper_holder_left = true;
draw_justage_bed = true;
draw_label_end_indicator_bar = true;
draw_kurbel = true;

//Rolle mit Etiketten ist 107mm breit und 
//hat einen Durchmesser von 135
//Innendurchmesser 23
//608ZZ_house();

//translate([0, 0, 10])
//    la_sidepart();
//la_sidepart_as_2D();


translate([0, 0, 10]) {
    if (draw_paper_roll) {
            paper_roll();
    }

    paper_holder_left();
    paper_holder_middle(35);
    paper_holder_right();    
}


justage_bed();
translate([0, -31, 0])
    justage_bed();
translate([0, -62, 0])
    justage_bed();
translate([0, -93, 0])
    justage_bed();
translate([0, -124, 0])
    justage_bed();
translate([300, 230, 120])
    label_end_indicator_bar();


if (draw_stangen) {
    translate([30, 245, 130])
        set_stange();
    translate([200, 245, 130])
        set_stange();
    translate([240, 245, 116])
        set_stange();
    translate([260, 245, 100])
        set_stange();
    translate([380, 245, 100])
        set_stange();
    translate([490, 245, 40])
        set_stange();
    translate([570, 245, 30])
        set_stange();
}

if (draw_sideparts) {
    union() {
        la_sidepart_both();

        translate([455, la_width - 25, 100])
            rotate([90, 0, 0])
                union() {    
                    la_walze();
                    translate([0, 0, -70])
                        kurbelwelle();
                    translate([0, 0, -71])
                        kurbel();
                }
                
        translate([537, la_width - 25, 100])
            rotate([90, 0, 0])
                la_walze();
        if (draw_aluprofile) {
            color(COLOR_ALU) {
                translate([425, 10, 70])
                    rotate([0, 90, 0])
                        2020Profile(350);
                translate([425, la_width-10, 70])
                    rotate([0, 90, 0])
                        2020Profile(350);
            }
        }
        translate([530, 0, 65])
            rotate([0, 0, 90])
                608ZZ_house();                  //ball bearing house 1

        translate([612, 0, 65])
            rotate([0, 0, 90])
                608ZZ_house();                  //ball bearing house 2

        translate([530, la_width-20, 65])
            rotate([0, 0, 90])
                608ZZ_house();                  //ball bearing house 3

        translate([612, la_width-20, 65])
            rotate([0, 0, 90])
                608ZZ_house();                  //ball bearing house 4
    
        color(COLOR_WHITE) {                    //cut holder 1
            translate([560, la_width - 20, 60])
                rotate([90, 270, 0])
                    cut_holder();

            translate([350, 20, 60])            //cut holder 2
                rotate([90, 270, 180])
                    cut_holder();
        }
        translate([485, 205, 56])               //alu profile for cut holder
            rotate([90, 0, 270])
                alu_profile(180);
        
        
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

module kurbel() {
    color(COLOR_WHITE) {
        difference() {
            hull() {
                cylinder(h=10, d=18);
                translate([0, -70, 0])
                    cylinder(h=10, d=18);
            }
            translate([0, 0, -1])
            kurbelwelle();
        }
        hull() {
        translate([0, -70, 0])
            cylinder(h=10, d=18);
        translate([0, -70, -70])
            sphere(r=9);
        }
    }
}

module kurbelwelle() {
    difference() {
        cylinder(h=280, d=8);
        translate([3, -5, -1])
            cube([10, 10, 10]);
        translate([-13, -5, -1])
            cube([10, 10, 10]);
    }
}

module label_end_indicator_bar() {
    if (draw_label_end_indicator_bar) {
        union() {
            difference() {
                union() {
                    hull(){    
                        translate([-10, 0, 0])
                            rotate([90, 0, 0])
                                cylinder(h=5, d=10);
                        translate([10, 0, 0])
                            rotate([90, 0, 0])
                                cylinder(h=5, d=10);
                    }
                    hull() {
                        translate([-10, 0, 0])
                            rotate([90, 0, 0])
                                cylinder(h=5, d=10);
                        translate([-10, 0, 0])
                            rotate([90, 0, 0])
                                cylinder(h=10, d=3);

                    }
                    translate([-10, 0, 0])
                        rotate([90, 0, 0])
                            cylinder(h=100, d=3);
                    
                    translate([-14, -1.35, -1.35])
                        rotate([0, 0, 0])
                            cube([28, 2.7, 2.7]);

                }
                translate([0, -3.8, 0])
                    rotate([90, 0, 0])
                    M3();
                translate([0, -7, 0])
                    rotate([90, 0, 0])
                    M3();
                translate([0, 10, 0])
                    rotate([90, 0, 0])
                        cylinder(h=100, d=3);
            }
        }
    }
}
module justage_bed() {
    if (draw_justage_bed) {
        color(COLOR_WHITE) {
            difference() {
                hull() {
                    width = 30;
                    translate([260, 210, 100])
                        rotate([90, 0, 0])
                            cylinder(h=width, d=30);
                    translate([380, 210, 100])
                        rotate([90, 0, 0])
                            cylinder(h=width, d=30);
                }
                translate([260, 215, 100])
                    rotate([90, 0, 0])
                        cylinder(h=150, d=11);
                translate([380, 215, 100])
                    rotate([90, 0, 0])
                        cylinder(h=150, d=11);
                translate([385.5, 65, 80])
                    rotate([0, 0, 90])
                        cube([150, 11, 20]);
                translate([265.5, 65, 80])
                    rotate([0, 0, 90])
                        cube([150, 11, 20]);
                
                nut_height=98.2;
//                translate([253.2, 85, nut_height])          //M3 Nut 1
//                    rotate([0, 90, 0])
//                        #M3();
//                translate([230, 85, nut_height])
//                    rotate([0, 90, 0])
//                        cylinder(h=30, d=3.3);

                translate([253.2, 195, nut_height])          //M3 Nut 2
                    rotate([0, 90, 0])
                        M3();
                translate([230, 195, nut_height])
                    rotate([0, 90, 0])
                        cylinder(h=30, d=3.3);

//                translate([386.9, 85, nut_height])          //M3 Nut 3
//                    rotate([0, 90, 0])
//                        #M3();
//                translate([380, 85, nut_height])
//                    rotate([0, 90, 0])
//                        cylinder(h=30, d=3.3);

                translate([386.9, 195, nut_height])          //M3 Nut 4
                    rotate([0, 90, 0])
                        M3();
                translate([380, 195, nut_height])
                    rotate([0, 90, 0])
                        cylinder(h=30, d=3.3);
                
            } //difference
        } //color
    } //if
}

module paper_holder_right() {
    if (draw_paper_holder_right) {
        difference() {
            paper_holder();
            
            translate([10, 69, 0])
                cube([210, 31, 200]);
            translate([10, 100, 0])
               cube([210, 40, 200]);
            translate([10, 140, 0])
               cube([210, 40, 200]);
            4hole_M3_stange_mount(23.2, 85, 118, 110, 178.4);
        }    
    }
}
module paper_holder_left() {
    if (draw_paper_holder_left) {
        difference() {
            paper_holder();
            
            translate([10, 100, 0])
               cube([210, 40, 200]);
            translate([10, 140, 0])
               cube([210, 40, 200]);
            translate([10, 180, 0])
                cube([210, 31, 200]);
            4hole_M3_stange_mount(23.2, 85, 118, 110, 178.4);
        }
    }
}
module paper_holder_middle(width) {
    if (draw_paper_holder_middle) {
        difference() {
            paper_holder();
            
            translate([10, 69, 0])
                cube([210, 120-(30+width), 200]);
            translate([10, 211-(120-(30+width)), 0])
                cube([210, 121-(30+width), 200]);
            4hole_M3_stange_mount(23.2, 85, 118, 110, 178.4);
        }
    }
}
module paper_holder() {
    color(COLOR_WHITE) {
        difference() {
            hull() {
                translate([30, 210, 120])
                    rotate([90, 0, 0])
                        cylinder(h=140, d=30);
                translate([200, 210, 120])
                    rotate([90, 0, 0])
                        cylinder(h=140, d=30);
                translate([115, 210, 130])
                    rotate([90, 0 , 0])
                        cylinder(h=140, d=155);
            }        
            translate([30, 245, 120])
                rotate([90, 0, 0])
                    cylinder(h=300, d=11);
            translate([200, 245, 120])
                rotate([90, 0, 0])
                    cylinder(h=300, d=11);
            translate([115, 200, 140])
                rotate([90, 0, 0])
                    cylinder(h=120,d=144.5);
            translate([205.5, 65, 60])
                rotate([0, 0, 90])
                    cube([150, 11, 60]);
            translate([35.5, 65, 60])
                rotate([0, 0, 90])
                    cube([150, 11, 60]);
            translate([220, 60, 123])
                rotate([0, 0, 90])
                    cube([160, 240, 100]);

            4hole_M3_stange_mount(23.2, 85, 118, 110, 178.4);
        }
        difference() {
            union() {
                translate([30, 210, 120])
                    rotate([90, 0, 0])
                        cylinder(h=140, d=30);
                translate([200, 210, 120])
                    rotate([90, 0, 0])
                        cylinder(h=140, d=30);

            }
            translate([30, 245, 120])
                rotate([90, 0, 0])
                    cylinder(h=300, d=11);
            translate([200, 245, 120])
                rotate([90, 0, 0])
                    cylinder(h=300, d=11);
            translate([205.5, 65, 60])
                rotate([0, 0, 90])
                    cube([150, 11, 60]);
            translate([35.5, 65, 60])
                rotate([0, 0, 90])
                    cube([150, 11, 60]);
            
        }
                    
    }
}

module 4hole_M3_stange_mount(nut_base_x, nut_base_y, nut_base_z, nut_base_length, nut_base_width) {
                translate([nut_base_x, nut_base_y, nut_base_z])          //M3 Nut 1
                    rotate([0, 90, 0])
                        M3();
                translate([nut_base_x-25, nut_base_y, nut_base_z])
                    rotate([0, 90, 0])
                        cylinder(h=30, d=3.3);

                translate([nut_base_x, nut_base_y + nut_base_length, nut_base_z])          //M3 Nut 2
                    rotate([0, 90, 0])
                        M3();
                translate([nut_base_x-25, nut_base_y + nut_base_length, nut_base_z])
                    rotate([0, 90, 0])
                        cylinder(h=30, d=3.3);

                translate([nut_base_x + nut_base_width + 5, nut_base_y, nut_base_z])          //M3 Nut 3
                    rotate([0, 90, 0])
                        M3();
                translate([nut_base_x + nut_base_width, nut_base_y, nut_base_z])
                    rotate([0, 90, 0])
                        cylinder(h=30, d=3.3);

                translate([nut_base_x + nut_base_width + 5, nut_base_y + nut_base_length, nut_base_z])          //M3 Nut 4
                    rotate([0, 90, 0])
                        M3();
                translate([nut_base_x + nut_base_width, nut_base_y + nut_base_length, nut_base_z])
                    rotate([0, 90, 0])
                        cylinder(h=30, d=3.3);
}

module set_stange() {
    color(COLOR_ALU) {    
        rotate([90, 0, 0])
        union() {
            cylinder(h=260, d=8);
            translate([0, 0, 15])
                cylinder(h=230, d=10);
        };
    }
}

module paper_roll() {
    translate([115, 195, 120])
        rotate([90, 0, 0])
        difference() {
            cylinder(h=107,d=115); 
            translate([0,0,-1])
                cylinder(h=109,d=23);
        }
}


module 608ZZ_house() {
    if (draw_upper || draw_lower) {
        difference() {
            union() {
                if (draw_upper) {
                    608ZZ_Roof();        
                }
                if (draw_lower) {
                    translate([0, 35, 15])
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
                    cylinder(35, d1=5.4, d2=5.4);       //fixing hole  1
                translate([10, 45, 19])    
                    cylinder(h=5, d=9);                 //fixing hole 1 head
                translate([10, 105 , 0])           
                    cylinder(35, d1=5.4, d2=5.4);       //fixing hole 2
                translate([10, 105, 19])    
                    cylinder(h=5, d=9);                 //fixing hole 2 head
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
    //-0.2 - -6.0
    translate([0, 0, 0.2])
        cylinder(h=7.2, d=22.2);
    translate([0, 0, -7])
       cylinder(h=22, d=17);
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
        translate([x, y, -2])
            cylinder((la_material_thickness * 2) + 2, d1=d + 0.2, d2=d + 0.2);
}

module la_sidepart_as_2D() {
    difference() {
        union() {
            difference() {
                rounded_corner_box_2D(la_length, la_height, 20);
                translate([400, 130])
                    square([22, 22]);
            }
            translate([400, 130])
                circle(d=40);
        }
        union() {
            tolerance = 0.2;
            translate([30, 30]) circle(d=8 + tolerance);
            translate([30, 130]) circle(d=8 + tolerance);
            translate([200, 130]) circle(d=8 + tolerance);
            translate([240, 116]) circle(d=8 + tolerance);
            translate([260, 100]) circle(d=8 + tolerance);
            translate([380, 100]) circle(d=8 + tolerance);
            translate([455, 100]) circle(d=15 + tolerance);
            translate([537, 100]) circle(d=15 + tolerance);
            translate([la_length-30, 30]) circle(d=8 + tolerance);
            translate([la_length-30, 120]) circle(d=8 + tolerance);
            translate([490, 40]) circle(d=8 + tolerance);
            hull() {
                translate([390, 120]) circle(d=3 + tolerance);
                translate([250, 120]) circle(d=3 + tolerance);
            }    
            translate([300, 70]) circle(d=5 + tolerance);
            translate([390, 70]) circle(d=5 + tolerance);
            translate([480, 70]) circle(d=5 + tolerance);
            translate([570, 70]) circle(d=5 + tolerance);
            
            translate([la_length / 4 , -20])
                rounded_corner_box_2D(la_length / 2, 40, 14);
            translate([la_length - 180 , 80])
                rounded_corner_box_2D(200, 80, 14);
            
        }
    }

}

module la_sidepart() {
    difference() {
        union() {
            difference() {
                rounded_corner_box(la_length, la_height, la_material_thickness, 20);
                translate([400, 130, 11])
                    rotate([0, 90, 0])
                        cube([15, 22, 22]);
            }
            translate([400, 130, 0])
                cylinder(h=la_material_thickness, d = 40);
        }
        union() {
            la_set_hole_at(30, 30, 8);
            la_set_hole_at(30, 130, 8);
            la_set_hole_at(200, 130, 8);
            la_set_hole_at(240, 116, 8);
            la_set_hole_at(260, 100, 8);
            la_set_hole_at(380, 100, 8);
            la_set_hole_at(455, 100, 15);
            la_set_hole_at(537, 100, 15);           
            la_set_hole_at(la_length-30, 30, 8);    // Ein-Einroller
            la_set_hole_at(la_length-30, 120, 8);
            la_set_hole_at(490, 40, 8);            // Abziehrohr
            
            //hole bar for mounting the label end indicator
            union() {
                hull(){
                    la_set_hole_at(390, 120, 3);
                    la_set_hole_at(250, 120, 3);
                }
            }
                    
                    
            
            //holes for mounting the alu bars
            //la_set_hole_at(30, 70, 5);
            //la_set_hole_at(120, 70, 5);
            //la_set_hole_at(210, 70, 5);
            la_set_hole_at(300, 70, 5);
            la_set_hole_at(390, 70, 5);
            la_set_hole_at(480, 70, 5);
            la_set_hole_at(570, 70, 5);
            
            
            translate([la_length / 4 , -20, -1])
                rounded_corner_box(la_length / 2, 40, 14, 14);
            translate([la_length - 180 , 80, -1])
                rounded_corner_box(200, 80, 14, 14);
            
        }
    }
}

module la_sidepart_both() {
    rotate([90, 0, 0]) 
        la_sidepart();
    translate([0, la_width + la_material_thickness, 0])
        rotate([90, 0, 0])
            la_sidepart();
}



    

