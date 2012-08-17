

// all dimensions are outside dimensions
// basic box assumes that top side is open
module basic_box(width, height, depth, thickness=12){
    // bottom plate
    plate(width, depth, thickness);  
    
    // front plate
    translate([0,thickness,thickness]) rotate([90,0,0]) plate(width, height, thickness);  
    // back plate
    translate([0,depth ,thickness]) rotate([90,0,0]) plate(width, height, thickness);  
    
    // side plate left
    translate([0,thickness,height+thickness]) rotate([0,90,0]) plate(height, depth-2*thickness, thickness);  
    // side plate right
    translate([width-thickness,thickness,height+thickness]) rotate([0,90,0]) plate(height, depth-2*thickness, thickness);  
   

}

module plate(x,y,z){
    color("LightGrey") cube([x,y,z]);
    echo("Plate: ",x/10,"x",y/10,"cm");

}


basic_box(1100,600,490,12);
