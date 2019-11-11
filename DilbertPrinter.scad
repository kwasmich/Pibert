use <box.scad>

$fn = 60;

psu = [87, 59, 34];
printer = [104, 58, 50];
button = [29, 56];
plug = [26, 12.5, 17.5];
rpi = [110, 64, 21];
box = [170 - 4, printer[1] + psu[2] + 1, psu[1] + 3];


module RPi() {
    color("#f08") cube(rpi);
}

module PSU() {
    color("#bbb") cube(psu);
}

module Printer() {
    color("#444") cube(printer + [0, 0, 1]);
    color("#4448") translate([-4, 0, 0]) cube(printer + [8, 0, -5]);
}

module Button() {
    color("#44F") cylinder(d=button[0], h=button[1] + 1);
    color("#44F") cylinder(d=button[0] + 10, h=button[1] - 5);
}

module Plug() {
    hull() {
        color("#080") translate([0 + 1, 0, 17 + 0.1]) cube(plug + [0, 0, -17]);
        color("#080") translate([0, 0, 15]) cube(plug + [2, 0, -17]);
    }
    
    //color("#080") translate([(plug[0] - 28) / 2, (plug[1] - 16) / 2, plug[2] + 0.001]) cube([28, 16, 3]);
}


module printbox() {
    intersection() {
        difference() {
            translate([170 - 4 - 6 - 2, -8 - 30 + 21 - 1, -13 - 30 + 21 - 1]) chamferBox([32, 34, 33], 1.5);
            translate([170 - 4 - 6 - 1, -8 - 30 + 21, -13 - 30 + 21]) chamferBox([30, 31, 31], 1);
            translate([155, -4.5, -7]) cube([10, 16.5, 14]);
        }
        
        color("#8888") translate([-5, -9, -14]) chamferBox([172, 104, 76], 1.5);
    }

    difference() {
        union() {
            difference() {
                color("#888") translate([-5, -9, -14]) chamferBox([172, 104, 76], 1.5);
                color("#0f0") translate([-3, -7, -12]) chamferBox([168, 100, 63], 1);
            }
            
            hull() {
                translate([154, -6.8, -4]) cube([11, 2.25, 14]);
                translate([158, -6.8, -7.25]) cube([7, 0.15, 17]);
            }
        }
        
        translate([170 - 4 - 6 - 2, -8 - 30 + 21 - 1, -13 - 30 + 21 - 1]) chamferBox([32, 33, 33], 1.5);
        
        translate([4, 0, box[2] - printer[2]]) Printer();
        translate([20, printer[1] + psu[2] + 1, box[2] - psu[1] - 1]) rotate([90, 0 ,0]) PSU();
        translate([printer[0] + button[0]/2 + 21, 101/2 - 8, box[2] - button[1]]) Button();
        translate([box[0] - plug[2] + 1, box[1] - plug[0] - 12, -9]) rotate([90, 0, 90]) Plug();
        
        translate([112, 58, -10]) screwHole(10);
        translate([-3, -7, -10]) screwHole(7);
        translate([-3, 86, -10]) screwHole(7);
        translate([158, 86, -10]) screwHole(7);
    }
    
    translate([-3, 58, 11]) cube([116, 1, 40]);
    translate([-3, 59, 11]) cube([23, 34, 40]);
    translate([112, -7, 11]) cube([1, 66, 40]);
    
}

module screwPost(thickness) {
    t = thickness;
    difference() {
        cube([t, t, 70]);
        translate([t/2, t/2, -1]) cylinder(d=3.5, h=10);
        translate([t/2, t/2, -1]) cylinder(d=4.25, h=4);
    }
}

module screwHole(thickness) {
    t = thickness;
    translate([t/2, t/2, -4]) cylinder(d=6, h=3);
    translate([t/2, t/2, -0.8]) cylinder(d=3.5, h=10);
}

module screwHole2(thickness) {
    t = thickness;
    translate([t/2, t/2, -2]) cylinder(d1=thickness * 2, d2=thickness * 1.4, h=2);
}



union() {
    difference() {
        printbox();
        translate([-3, -7, -15]) chamferBox([168, 100, 26], 1);
    }
    
    translate([112, 58, -10]) screwPost(10);
    translate([-3, -7, -10]) screwPost(7);
    translate([-3, 86, -10]) screwPost(7);
    translate([158, 86, -10]) screwPost(7);
    
    translate([158, -7, 10]) cube([7, 7, 50]);
    
    color("#0ff") translate([165, 57, -9]) cube([0.15, 24, 12.5]);
    color("#0ff") translate([166.85, 57, -9]) cube([0.15, 24, 12.5]);
}


intersection() {
    union() {
        printbox();
        difference() {
            union() {
                translate([112, 58, -10]) screwHole2(10);
                translate([-3, -7, -10]) screwHole2(7);
                translate([-3, 86, -10]) screwHole2(7);
                translate([158, 86, -10]) screwHole2(7);
            }
            
            translate([112, 58, -10]) screwHole(10);
            translate([-3, -7, -10]) screwHole(7);
            translate([-3, 86, -10]) screwHole(7);
            translate([158, 86, -10]) screwHole(7);
        }
        
        translate([153, 37.5, -12]) cylinder(d=2.5, h=8);
        translate([153, 37.5, -12]) cylinder(d1=8.5, d2=2.5, h=3);
        translate([98, 12, -12]) cylinder(d=2.5, h=8);
        translate([98, 12, -12]) cylinder(d1=8.5, d2=2.5, h=3);
        
        hull() { 
            translate([157 - 86, -7, -12]) cube([1, 10, 6]);
            translate([157 - 86 - 5, -7, -12]) cube([1, 10, 1]);
        }
        
        translate([0, 45, 0]) hull() { 
            translate([157 - 86, -7, -12]) cube([1, 10, 6]);
            translate([157 - 86 - 5, -7, -12]) cube([1, 10, 1]);
        }

        translate([157 - 86 + 20, -6 + 57, -12]) rotate([0, 0, -90]) hull() { 
            cube([1, 10, 6]);
            translate([-5, 0, 0]) cube([1, 10, 1]);
        }
        
        color("#f0f") {
            hull() {
                translate([160, -6, -14]) cube([4, 19, 1]);
                translate([164.65, -6, -14]) cube([0.15, 19, 23]);
            }
            
            hull() {
                translate([160, -6, -14]) cube([4, 1, 1]);
                translate([160, -6.8, -14]) cube([4, 0.15, 23]);
            }
            
            hull() {
                translate([161, -3.5, -14]) cube([4, 14.5, 1]);
                translate([158, -3.5, 3]) cube([0.15, 14.5, 4]);
            }
            
            hull() {
                translate([160, -3.5, -14]) cube([4, 14.5, 1]);
                translate([158.85, -3.5, 3]) cube([0.15, 14.5, 4]);
            }
        }
    }
    
    d = 0.2;
    dd = 0.4;
    translate([-3 + d, -7 + d, -15 + 1]) chamferBox([168 - dd, 100 - dd, 25], 0.7);
    //translate([65, -10, -30]) cube([110, 85, 50]);
    //translate([65, -10, -30]) cube([110, 85, 50]);
}

    
    //translate([60, -140, -200]) cube([200, 200, 200]);
    //translate([-20, -20 - 30, -20 + 20]) cube([200, 200, 200]);

