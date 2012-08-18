$fn=24;

// all dimensions are outside dimensions
// basic box assumes that top side is open
module basic_box(width, height, depth, thickness=12){
    // bottom plate
    plate(width, depth, thickness);  
    
    // front plate
    translate([0,thickness,thickness]) rotate([90,0,0]) plate(width, height-thickness, thickness);  
    // back plate
    translate([0,depth ,thickness]) rotate([90,0,0]) plate(width, height-thickness, thickness);  
    
    // side plate left
    translate([0,thickness,height]) rotate([0,90,0]) plate(height-thickness, depth-2*thickness, thickness);  
    // side plate right
    translate([width-thickness,thickness,height]) rotate([0,90,0]) plate(height-thickness, depth-2*thickness, thickness);  
   

}

module plate(x,y,z){
    color("LightGrey") cube([x,y,z]);
    echo("Plate: ",x/10,"x",y/10,"cm");

}


// not very elegant, but works
module printed_edge_3sides(size=50, thickness=6){
   difference(){
       cube(size);
       translate([thickness, thickness, thickness]) {
         difference(){
            cube(size);
            rotate(a=45,v=[0,0,1]) translate([-size+10,-size/2,0])   cube(size);
         }
       }
       translate(v=[size/3*2,thickness+0.5,size/3]) rotate([90,0,0]) cylinder(r=3.5/2, h=thickness+1);
       translate(v=[size/3*2,thickness+0.5,size/3*2]) rotate([90,0,0]) cylinder(r=3.5/2, h=thickness+1);
       translate(v=[-0.5,size/3*2,size/3]) rotate([0,90,0]) cylinder(r=3.5/2, h=thickness+1);
       translate(v=[-0.5,size/3*2,size/3*2]) rotate([0,90,0]) cylinder(r=3.5/2, h=thickness+1);
        
       translate([5,5,0]){
       translate(v=[size/3,size/3 ,-0.5]) rotate([0,0,0]) cylinder(r=3.5/2, h=thickness+1);
       translate(v=[size/3*2,size/3*2,-0.5]) rotate([0,0,0]) cylinder(r=3.5/2, h=thickness+1);
       }
   
   }
}

module printed_edge_2sides(size=30, thickness=6){
    difference(){
       cube(size);
       translate([thickness, thickness, 0]) {
       difference(){
            cube(size);
            rotate(a=45,v=[0,0,1]) translate([-size+3,-size/2,0])   cube(size);
         }
       } 
       translate(v=[size/3*2,thickness+0.5,size/3-3]) rotate([90,0,0]) cylinder(r=3.5/2, h=thickness+1);
       translate(v=[size/3*2,thickness+0.5,size/3*2+3]) rotate([90,0,0]) cylinder(r=3.5/2, h=thickness+1);
       translate(v=[-0.5,size/3*2,size/3-3]) rotate([0,90,0]) cylinder(r=3.5/2, h=thickness+1);
       translate(v=[-0.5,size/3*2,size/3*2+3]) rotate([0,90,0]) cylinder(r=3.5/2, h=thickness+1);
    }

}


// custom design: box with lid on top, fits in tight space where sides are inacessable
module top_lid_box(width, height, depth, thickness=12, distance_plate_to_wall_depth=100){
    // note that our rule is that the dimensions we state is what actually comes out
    // we're putting the lid on top of the box, so we make the box by parameter thickness smaller.
    basic_box(width, height-thickness, depth, thickness);
    
    
    translate([0,0,height-thickness]){
       // this one goes to the wall
       plate(width, distance_plate_to_wall_depth, thickness);
       // we're using a bought hindge to the ouside now that doesn't need any spacing
       translate([0,distance_plate_to_wall_depth,0]) plate(width, depth-distance_plate_to_wall_depth, thickness);
    }
    
}



//printed_edge_2sides();
top_lid_box(1150,600,485,12);
