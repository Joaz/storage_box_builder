

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


// todo
module printed_edge(size=40, thickness=6){
   difference(){
       cube(size);
       #translate([thickness, thickness, thickness]) {
         union(){
            cube(size);
            #cylinder(r=1.5,h=size, $fn=64);
         }
       }
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
       // todo: how much spacing does the hinge need?
       #translate([0,distance_plate_to_wall_depth,0]) plate(width, depth-distance_plate_to_wall_depth, thickness);
    }
    
}


//printed_edge();
top_lid_box(1100,600,490,12);
