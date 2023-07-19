class TargetMissile {

  PImage targetMissile;
  boolean  isFired=false, isLaunched=false, isFireFinish=true;
  float my, mx;

  TargetMissile(float Y, float X)
  {
    my=Y;
    mx=X;
    targetMissile = loadImage("targetmissile.png");
  }

  void update()
  {
    image(targetMissile,mx,my,50,50);
  }
  
  void fire()
  {
    if (!isFired)
    {
      if (t>=40)
      {
        isFireFinish=false;
        isFired=true;
        t=0;
      }
    } else
    {
      if (!isLaunched && isFired)
      {
        image(targetMissile, mx+10, my, 50, 50);
        isLaunched=true;
      } else if (isLaunched && mx>0)
      {
        mx-=15;
        image(targetMissile, mx+10, my, 50, 50);
      } else if (isLaunched && isFired && mx<=0)
      {
        isFireFinish=true;
        isFired=false;
        isLaunched=false;
      }
    }
  }
  
  float getPositionMissileTargetX()
  {
    return mx;
  }

  float getPositionMissileTargetY()
  {
    return my;
  }
}
