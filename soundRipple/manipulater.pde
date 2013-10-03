class Manipulate
{
  boolean type; //type -> speed|| !type -> amplitude
  float radius;
  PVector center;
  float speed, volume;
  boolean M2M, M2Speed, M2Vol;
  
  Manipulate(PVector pos, float contact, boolean speedOrAmplitude)
  {
    center = pos;
    radius = contact;
    type = speedOrAmplitude;
    speed = volume = 1;
    M2M = false;
    M2Speed = false;
    M2Vol = false;
  }
  
  PVector getPos()
  {
    return center;
  }
  
  boolean getContact(int rel)
  {
    if(rel == 1)//m2m
    {
      return M2M;
    }
    else if(rel == 2)//m2Speed
    {
      return M2Speed;
    }
    else
    {
      return M2Vol;
    }
  }
  
  void checkRipple_M(Ripple rip)
  {
    PVector posR = rip.getPos();
    if(posR.dist(center)<=radius)
    {
      makeManipulation(rip);
      if(type)
      {
        M2Speed = true;
      }
      else
      {
        M2Vol = true;
      }
    }
  }
  
  void checkManipulator_M(Manipulate manip)
  {
    PVector posM = manip.getPos();
    if(posM.dist(center)<=radius)
    {
      M2M = true;
      line(posM.x, posM.y, center.x, center.y);
    }
  }
  
  void makeManipulation(Ripple rip)
  {
    if(type)
    {
      rip.setSpeed(speed);
      speed -= 0.1;
    }
    else
    {
      rip.setVolume(volume);
      volume -= 0.1;
    }
  }
  
  void reset()
  {
    speed = volume = 1;
  }
  
}
