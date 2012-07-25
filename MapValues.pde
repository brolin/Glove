class MapValues extends CalibrateSensor
{
  // directions
  float up, down, front, back, left, right;
  // 0 points
  float ceroForce_x, ceroForce_y, ceroForce_z;
  float lastForce_x, lastForce_y, lastForce_z;
  float tresh = 0.5;
  //movement
  boolean movement_x, movement_y, movement_z;

  //GUI elements
  float xoffset, yoffset, zoffset;
  int xwidth, yheight;
  // positions
  private Packet start_pos, last_pos;

  MapValues(int xwidth, int yheight)
  {
    this.xwidth= xwidth/2;
    this.yheight= yheight/2;
    this.start_pos = new Packet(0,0,0);
    this.last_pos = new Packet(0,0,0);
  }

  void scan_movement()
  {
    // busca cambios a partir de la lectura constante de las fuerzas
    // a partir de una direccion
    start_pos = getPosition();
    ceroForce_x = getForces().valX;
    ceroForce_y = getForces().valY;

    if ((ceroForce_x >= lastForce_x + tresh) || (ceroForce_x <= lastForce_x - tresh)) {
      movement_x = true;
      
      
      //println("X");
    } 
    else {
      movement_x= false;
       //println("NO X");
    } 
    if ((ceroForce_y >= lastForce_y + tresh) || (ceroForce_y <= lastForce_y - tresh)) {
      movement_y = true;
       //println("Y");
    } else {
      movement_y= false;
       //println("NO Y");
    } 
   
    lastForce_x = ceroForce_x;
    lastForce_y = ceroForce_y;
    last_pos = start_pos;
  }
  
  void mapForces()
  {
    //mapeo de valores dependiendo de si hay movimiento o no
    if(movement_x){
    
      /*back = map(ceroForce_x, -4,4 , 0, 255);
      
      println("mapped:" + back + "\t" + "before:" + ceroForce_x);*/
      println("in mapping" + "\t" + ceroForce_x + "\t" + lastForce_x);
    }
    
    
  
  }


  void draw()
  {
    /*yoffset = getPosition().valY;
     xoffset = getPosition().valX;*/
    if (movement_x || movement_y) {
      pushMatrix();
      stroke(255);
      translate(xwidth + xoffset, yheight + yoffset);
      beginShape();

      vertex(0, 0, 0);
      vertex();

      endShape();

      popMatrix();
    }
  }
}

