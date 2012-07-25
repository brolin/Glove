class Packet {
  private float valX;
  private float valY;
  private float valZ;
  private int tiempo;

  Packet(float a, float b, float c) {
    this.valX = a;
    this.valY = b;
    this.valZ = c;
    this.tiempo = millis();
  } 

  float getValX() {
    return this.valX;
  }
  float getValY() {
    return this.valY;
  }
  float getValZ() {
    return this.valZ;
  }
  int getTiempo() {
    
    return this.tiempo;
    
  }

  void setValX(float valX) {
    this.valX = valX;
  }
  void setValY(float valY) {
    this.valY = valY;
  }
  void setValZ(float valZ) {
    this.valZ = valZ;
  }

  void setTime(int time) {
    this.tiempo = time;
  }
}

