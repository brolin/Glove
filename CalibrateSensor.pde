class CalibrateSensor
{
  // define constants
  public static final float ADC_ref = 3.3;
  public static final float zero_x = 1.65;
  public static final float zero_y = 1.65;
  public static final float zero_z = 1.65;
  public static final float sensitividad_x = 0.3;
  public static final float sensitividad_y = 0.3;
  public static final float sensitividad_z = 0.3;

  // force, position, angle variables
  float xG, yG, zG;
  float angle_x, angle_y, angle_z;
  float posX, posY, posZ;
  //XYZ variables
  float value_x, value_y, value_z;

  //Position
  private Packet position, forces, angles;


  CalibrateSensor()
  {
    this.position = new Packet(0, 0, 0);
    this.forces = new Packet(0, 0, 0);
    this.angles = new Packet(0, 0, 0);
  }
  void update_calib(float x, float y, float z)
  {
    this.value_x = x;
    this.value_y = y;
    this.value_z = z;
    // round forces to get overall position
    posX = round((value_x/1024.0*ADC_ref - zero_x)/sensitividad_x);
    posY = round((value_y/1024.0*ADC_ref - zero_y)/sensitividad_y);
    posZ = round((value_z/1024.0*ADC_ref - zero_z)/sensitividad_z);
    // raw forces
    xG = (value_x/1024.0*ADC_ref - zero_x)/sensitividad_x;
    yG = (value_y/1024.0*ADC_ref - zero_y)/sensitividad_y;
    zG = (value_z/1024.0*ADC_ref - zero_z)/sensitividad_z;
    //angles
    angle_x = degrees(atan2(-yG, -zG) + PI);
    angle_y = degrees(atan2(-xG, -zG) + PI);
    angle_z = degrees(atan2(-yG, -xG) + PI);
    // Packet everything
    position = new Packet(posX, posY, posZ);
    forces = new Packet(xG, yG, zG);
    angles = new Packet(angle_x, angle_y, angle_z);
  }
  Packet getPosition()
  {
    return this.position;
  }
  Packet getForces()
  {
    return this.forces;
  }
  Packet getAngles()
  {
    return this.angles;
  }
 
};

