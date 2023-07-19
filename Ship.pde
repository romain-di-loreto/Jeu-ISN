class Ship
{
  int shield=3;
  PImage ship;
  boolean isDestroyed=false, hit=false, z = false,q = false,s = false,d=false,space=false;
  float x=width*1/6, y, mx, my, t=400;

  Ship()
  {
    ship = loadImage("ship.png");
    y=height/2;
  }

  void visible()
  {
    imageMode(CENTER);
    image(ship, x, y, 50, 50);
    this.shield();
    this.shieldHit();
  }

  void shield()
  {
    stroke(190, 190, 255);
    if (shield>=1)
    {
      ellipse(x-5, y, 60, 60);
    }
    if (shield>=2)
    {
      ellipse(x-5, y, 70, 70);
    }
    if (shield==3)
    {
      ellipse(x-5, y, 80, 80);
    }
  }

  void shieldHit()
  {
    int a;
    if (hit)
    {
      if (shield==2)
      {
        a=80;
      } else if (shield==1)
      {
        a=70;
      } else
      {
        a=60;
      }

      if (t<100)
      {
        stroke(255, 0, 0);
        ellipse(x-5, y, a, a);
      } else if (t>=100)
      {
        hit=false;
      }
    }
  }

  void move()
  {
    if (keyPressed)
    {
      if (key=='z'||key=='Z' || (key=='z' && key==' ')) {
        if (y-23<=height/8+80)
        {
        } else {
          y-=5;
        }
      }
      if (key=='s'||key=='S' || (key=='s' && key==' ')) {
        if (y+23>=7*height/8-80)
        {
        } else {
          y+=5;
        }
      }
    }
  }

  boolean isDestroyed(float pmx, float pmy)
  {
    if (pmx<=x+19 && pmx>=x-25 && pmy<=y+21 && pmy>=y-21 && shield>0 && t>=100)
    {
      if (!hit)
      {
        shield--;
        t=0;
        hit=true;
      }
      return false;
    } else if (pmx<=x+19 && pmx>=x-25 && pmy<=y+21 && pmy>=y-21 && shield<=0 && t>=100)
    {
      return true;
    } else
    {
      return false;
    }
  }

  float getY()
  {
    return y;
  }

  void reset()
  {
    x=width*1/6;
    y=height/2;
    shield=3;
    isDestroyed=false;
    t=400;
  }

  void temporisation()
  {
    t++;
  }

  void playerPhysique()
  {
    this.temporisation();
    this.visible();
    this.move();
  }
}
