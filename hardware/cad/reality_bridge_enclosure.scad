// Reality Bridge Reference Probe v0.1 enclosure
// DESIGN TARGET — verify exact purchased module dimensions before fabrication.
$fn=48;
outer=[150,90,34]; wall=2.4; corner=6; screw_d=3.2;
module rounded_box(size,r){minkowski(){cube([size[0]-2*r,size[1]-2*r,size[2]],center=true);cylinder(r=r,h=0.01,center=true);}}
module shell(){difference(){
 translate([0,0,outer[2]/2]) rounded_box(outer,corner);
 translate([0,0,outer[2]/2+wall]) rounded_box([outer[0]-2*wall,outer[1]-2*wall,outer[2]],corner-wall);
 // USB-C opening
 translate([outer[0]/2,0,15]) cube([12,18,10],center=true);
 // acoustic / ventilation slots
 for(y=[-12,-6,0,6,12]) translate([-outer[0]/2+1,y,22]) rotate([0,90,0]) cylinder(d=2.2,h=8,center=true);
}}
module posts(){for(x=[-62,62])for(y=[-32,32])translate([x,y,4])difference(){cylinder(d=8,h=8);cylinder(d=screw_d,h=9);}}
module lid(){difference(){
 translate([0,0,2]) rounded_box([outer[0],outer[1],4],corner);
 for(x=[-62,62])for(y=[-32,32])translate([x,y,-1])cylinder(d=screw_d,h=8);
 // reference sensor windows
 translate([-38,0,-1]) cube([22,12,8],center=true);
 translate([0,0,-1]) cube([14,14,8],center=true);
 translate([38,0,-1]) cube([18,10,8],center=true);
}}
shell(); posts(); translate([0,115,0]) lid();
