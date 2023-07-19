class Missile {

  PImage missile;
  boolean  isFired=false;
  float my, mx=width*1/6;

  Missile(float Y)
  {
    my=Y;
    missile = loadImage("missile.png");
  }

  void update()
  {
    image(missile,mx,my,50,50);
  }
  
  void fire()
  {
    if(!isFired)
    {
      isFired=true;
    }
    else
    {
      mx+=40;
    }
  }
  
  float getX()
  {
    return mx;
  }
  
  float getY()
  {
    return my;
  }
}
