// use <box.scad>

module roundedBox(box, c = 1, fn = 10) {
    translate([c, c, c])
    minkowski() {
        cube(box - [2*c, 2*c, 2*c]);
        sphere(r=c, $fn = fn);
    }
}


module chamferBox(box, d = 1, fn = 4) {
    cc = min(box);
    c = min(cc/2 - 0.001, d);
    translate([c, c, c])
    minkowski() {
        cube(box - [2*c, 2*c, 2*c]);
    
        union() {
            cylinder(h=c, r1=c, r2=0, $fn = fn);
            scale(-1) cylinder(h=c, r1=c, r2=0, $fn = fn);
        }
    }
}

module roundedChamferBox(box, r = 1, c = 1) {
    assert(r > c);
    assert(box[0] > 2*r);
    c = max(0.001, c);

    translate([r, r, c])
    minkowski() {
        minkowski() {
            cube(box - [2*r, 2*r, 3*c]);
            cylinder(h=c, r=r - c);
        }
        
        union() {
            cylinder(h=c, r1=c, r2=0);
            scale(-1) cylinder(h=c, r1=c, r2=0);
        }
    }
}


//roundedChamferBox([10, 20, 15], 3, 1, $fn=60);
//chamferBox([10, 20, 15], 1, 4);
//roundedBox([10, 20, 15], 1, 30);
//cube([10, 20, 15]);

for (z = [0.5:0.2:5]) {
    translate([z * 60, 0, 0]) chamferBox([10, 30, z], 1, 4);
}
