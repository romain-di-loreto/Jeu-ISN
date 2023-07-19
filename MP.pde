class MP {
  PImage start,stop;
  MP()
  {
    start = loadImage("Press-Start.png");
    stop = loadImage("exit.png");
  }

  void pressStart()
  {
    imageMode(CENTER);
    image(start, width/2, height/2, 608, 342);
  }
  void pressExit()
  {
    imageMode(CENTER);
    image(stop, 7*width/8, 7*height/8, 100,50);
  }  
}
