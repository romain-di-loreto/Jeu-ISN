class Target
{
  PImage target, targetMissile;
  float x=width+50, y=random(height/8+105,7*height/8-105), mx, my, t;
  int id;
  boolean isDestroyed=false, isFired=false, isLaunched=false, isFireFinish=true;

  Target()
  {
    target = loadImage("target.png");
    targetMissile = loadImage("targetmissile.png");
  }

  void visible()
  {
    imageMode(CENTER);
    image(target, x, y, 50, 50);
  }

  void move()
  {
    if (x>=width/2)
    {
      x-=0.5;
    }
  }

  void temporisation()
  {
    t++;
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
        mx=x;
        my=y;
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

  boolean isTargetDestroyed(float pmx, float pmy)
  {
    if (pmx>=x-50 && pmx<=x+50 && pmy>=y-50 && pmy<=y+50)
    {
      return true;
    }
    return false;
  }

  float getPositionMissileTargetX()
  {
    return mx;
  }

  float getPositionMissileTargetY()
  {
    return my;
  }

  boolean isFireFinish()
  {
    return isFireFinish;
  }

  void idDef(int i)
  {
    id=i;
  }
  
  int getID()
  {
    return id;
  }
  
  void targetPhysique()
  {
    this.visible();
    this.move();
    this.temporisation();
  }
}
