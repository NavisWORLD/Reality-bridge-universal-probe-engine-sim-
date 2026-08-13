// REALITY BRIDGE REFERENCE PROBE v0.2
// PARAMETRIC ASSEMBLY CAD // DESIGN TARGET - NOT YET PHYSICALLY VALIDATED
// Units: millimeters
//
// Change `part` at render time:
//   "assembly" | "base" | "lid" | "carrier" | "modules"
// Change `exploded` from 0..1 for exploded visualization.

$fn = 48;
part = "assembly";
exploded = 0;
show_labels = true;

// External envelope
outer_x = 150;
outer_y = 90;
outer_z = 34;
wall = 2.4;
corner = 7;
base_h = 27;
lid_h = 7;

// Carrier target
pcb_x = 120;
pcb_y = 70;
pcb_z = 1.6;
mount_dx = 112;
mount_dy = 62;
mount_hole = 3.2;

// Reference module proxy dimensions for visualization only.
// Verify exact purchased modules before fabrication.
esp = [54, 28, 12];
imu = [23, 18, 4];
lux = [18, 16, 4];
env = [18, 16, 4];
ppg = [22, 18, 5];
mic = [23, 15, 4];
gnss = [30, 25, 6];

module rounded_prism(size=[10,10,10], r=2) {
  minkowski() {
    cube([size[0]-2*r,size[1]-2*r,size[2]], center=true);
    cylinder(r=r,h=0.01,center=true);
  }
}

module vent_slot(len=10, d=2.2, depth=8) {
  hull() {
    translate([-len/2+d/2,0,0]) cylinder(d=d,h=depth,center=true);
    translate([ len/2-d/2,0,0]) cylinder(d=d,h=depth,center=true);
  }
}

module base_shell() {
  difference() {
    translate([0,0,base_h/2]) rounded_prism([outer_x,outer_y,base_h],corner);
    translate([0,0,base_h/2+wall]) rounded_prism([outer_x-2*wall,outer_y-2*wall,base_h],corner-wall);

    // USB-C access opening on +X wall.
    translate([outer_x/2,0,17]) cube([12,18,10],center=true);

    // Microphone vent array on -X wall.
    for (yy=[-14,-7,0,7,14])
      translate([-outer_x/2,yy,19]) rotate([0,90,0]) vent_slot(7,2.2,8);

    // Side ventilation slots.
    for (xx=[-28,-14,0,14,28])
      translate([xx,outer_y/2,19]) rotate([90,0,0]) vent_slot(8,2,8);
  }

  // Internal board standoffs.
  for (sx=[-mount_dx/2,mount_dx/2])
    for (sy=[-mount_dy/2,mount_dy/2])
      translate([sx,sy,4]) difference() {
        cylinder(d=8,h=8,center=false);
        translate([0,0,-0.5]) cylinder(d=mount_hole,h=9,center=false);
      }
}

module lid_shell() {
  difference() {
    translate([0,0,lid_h/2]) rounded_prism([outer_x,outer_y,lid_h],corner);
    translate([0,0,-0.5]) rounded_prism([outer_x-2*wall,outer_y-2*wall,lid_h],corner-wall);

    // PPG optical window
    translate([-38,2,0]) rounded_prism([24,20,lid_h+2],3);
    // Environment/light window bank
    translate([15,-27,0]) rounded_prism([50,18,lid_h+2],3);
    // status / access window
    translate([44,25,0]) rounded_prism([24,12,lid_h+2],3);

    for (sx=[-mount_dx/2,mount_dx/2])
      for (sy=[-mount_dy/2,mount_dy/2])
        translate([sx,sy,-1]) cylinder(d=mount_hole,h=lid_h+3,center=false);
  }
}

module carrier_board() {
  color([0.02,0.22,0.18])
  difference() {
    translate([0,0,pcb_z/2]) rounded_prism([pcb_x,pcb_y,pcb_z],2.5);
    for (sx=[-mount_dx/2,mount_dx/2])
      for (sy=[-mount_dy/2,mount_dy/2])
        translate([sx,sy,-1]) cylinder(d=mount_hole,h=pcb_z+2,center=false);
  }

  // Generic connector proxies on carrier edges.
  color([0.08,0.08,0.09]) {
    translate([-52,-23,3.8]) cube([10,10,6],center=true); // I2C
    translate([-52,0,3.8]) cube([12,12,6],center=true);   // MIC
    translate([52,16,3.8]) cube([10,12,6],center=true);   // GNSS
  }
}

module module_proxy(name, pos, size, col=[0.2,0.8,0.5]) {
  color(col) translate(pos) rounded_prism(size,1.5);
  if(show_labels)
    color([0.9,0.95,1]) translate([pos[0],pos[1],pos[2]+size[2]/2+0.6])
      linear_extrude(height=0.25) text(name,size=3.2,halign="center",valign="center");
}

module electronics() {
  module_proxy("ESP32-S3", [0,0,pcb_z+esp[2]/2+1.5], esp, [0.31,0.25,0.72]);
  module_proxy("PPG", [-38,3,pcb_z+ppg[2]/2+2], ppg, [0.18,0.65,0.38]);
  module_proxy("BME280", [-5,-25,pcb_z+env[2]/2+2], env, [0.18,0.65,0.38]);
  module_proxy("BH1750", [26,-25,pcb_z+lux[2]/2+2], lux, [0.18,0.65,0.38]);
  module_proxy("IMU", [37,4,pcb_z+imu[2]/2+2], imu, [0.18,0.65,0.38]);
  module_proxy("INMP441", [-44,-24,pcb_z+mic[2]/2+9], mic, [0.18,0.65,0.38]);
  module_proxy("GNSS", [42,23,pcb_z+gnss[2]/2+2], gnss, [0.72,0.48,0.14]);
}

module complete_assembly() {
  color([0.12,0.34,0.40,0.82]) base_shell();
  translate([0,0,7 + 18*exploded]) carrier_board();
  translate([0,0,7 + 18*exploded]) electronics();
  color([0.18,0.48,0.55,0.65]) translate([0,0,base_h + 8 + 34*exploded]) lid_shell();
}

if(part=="base") base_shell();
else if(part=="lid") lid_shell();
else if(part=="carrier") carrier_board();
else if(part=="modules") electronics();
else complete_assembly();
