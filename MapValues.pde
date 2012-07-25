class MapValues extends CalibrateSensor
{
  // directions
  float up, down, front, back, left, right;
  // 0 points  
  float ceroForce_x, ceroForce_y, ceroForce_z;
  
  float now_x, now_y, now_z, last_x, last_y, last_z; // fuerzas antes y despues
  
  float tresh = 0.5;//cantidad de cambio para considerar movimiento
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
  
  void setDirections(){
  
  ceroForce_x = getPosition().valX;
  now_x = getForces().valX;
  //if(last_x + tresh < ceroForce_x){println("YES");}else{println("NOT");}
  last_x = now_x;
  
  //println(now_x);
  
  }




  void draw()
  {
    /*yoffset = getPosition().valY;
     xoffset = getPosition().valX;*/
    if (movement_x || movement_y) {
      pushMatrix();
      stroke(255);
      //translate(xwidth + xoffset, yheight + yoffset);
      beginShape();

      vertex(0, 0, 0);
      vertex();

      endShape();

      popMatrix();
    }
  }
}

