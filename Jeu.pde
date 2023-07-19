/* CLASSE AUDIOVIZUALISER
 * 
 * AudioVizualiser(PApplet p, String adresse)
 * playPause()
 * SongInitiate()
 * previsualisation()
 * colorEffect()
 * impulse() <boolean>
 * fullSpectrumDrawing()
 * verticalSpectrumDrawing()
 * beatSpectrumDrawing()
 * soundWave(int wave1height, int wave2Height)Q
 * cursorPosition()
 * metaDataShow()
 * progression() <int>
 * isPlaying() <boolean>
 * void runAll()
 * stop()
 *
 *
 *
 * CLASSE FILESELECT
 *
 * Adresse(String lien)
 * showButton(int x,int y)
 * showAdress(int x,int y)
 * showFileButton(int x, int y)
 * fileSelect()
 * colorEdit(color colorRep, color colorFile, color colorAdress)
 * void exeAll(int xB, int yB, int xA, int yA, int xFB, int yFB)
 *
 *
 *
 * CLASSE MP
 *
 * pressStart()
 * pressExit()
 *
 *
 *
 * CLASSE MISSILE
 *
 * update()
 * fire()
 * getX() <boolean>
 * getY() <boolean>
 *
 *
 *
 * CLASSE SHIP
 *
 * visible()
 * shield()
 * shieldHit()
 * move()
 * isDestroyed(float pmx, float pmy) <boolean>
 * getY() <float>
 * reset()
 * temporisation()
 * playerPhysique()
 *
 *
 * CLASSE TARGET
 *
 * visible()
 * move()
 * temporisation()
 * fire()
 * isTargetDestroyed(float pmx, float pmy) <boolean>
 * getPositionMissileTargetX() <float>
 * getPositionMissileTargetY() <float>
 * isFireFinish() <boolean>
 * idDef(int i)
 * getID() <int>
 * targetPhysique()
 *
 */

MP Menu_Principal;
FileSelect Select;
AudioVizualiser Audio;
AudioVizualiser Previsu;
Ship Ship;

ArrayList<Target> Targets;
ArrayList<Missile> Missiles;

String lienAudio="Alcubiere.mp3";
int t=0, tTarget=0, targetID, targetIDDelet;
boolean isPrevisuCharged=false, gameOn=false, inPlaying=false, pause=false, deadMissile=false, deadTarget=false, isDestroyed=false, gameEnd=false;

void setup()
{  
  Menu_Principal=new MP();
  Select=new FileSelect();
  Ship=new Ship();
  Targets=new ArrayList<Target>();
  Missiles=new ArrayList<Missile>();
  //size(800,370,P2D);
  fullScreen(P2D);
  frameRate(60);
}

void draw()
{
  background(0);
  temporisation(); //defini un repere dans le temps pour limier la vitesse de spawn et de tire
  if (inPlaying)
  {
    if (!gameEnd)
    {
      targetID=0; //ID de reperage des cible ennemie
      Audio.runAll();
      Ship.playerPhysique(); //Ensemble des sytemes gerant la physique du joueur
      text(Audio.progression()+1, width/2, height/4);
      text("%", width/2+16, height/4);
      stroke(150, 150, 255);
      line(0, height/8+80, width, height/8+80);
      line(0, 7*height/8-80, width, 7*height/8-80);
      if ((tTarget>=50 && Audio.impulse || tTarget>=200) && Targets.size()<=30) //spawn automatique des ennemis
      {
        Targets.add(new Target());
        tTarget=0;
      }

      for (Target targets : Targets) //Tableau d'objet sur les ennemies
      {
        targets.idDef(targetID); //attribution de l'ID
        targets.targetPhysique(); //Physique des cibles 
        targetID++;

        if (!targets.isFireFinish()) //Système de fonction permettant le tir reguler des cibles
        {
          targets.fire();
        }
        if (Audio.impulse() && targets.isFireFinish())
        {
          targets.fire();
        }
        if (Ship.isDestroyed(targets.getPositionMissileTargetX(), targets.getPositionMissileTargetY())) //detection d'une touche en faveur de l'ennemie
        {
          isDestroyed=true;
        }
        for (Missile missiles : Missiles) //tableau d'objet des missiles allié
        {
          if (targets.isTargetDestroyed(missiles.getX(), missiles.getY())) //detection d'une touche en faveur du joueur
          {
            targetIDDelet=targets.getID();
            deadTarget=true;
          }
        }
      }

      if (deadTarget) //suppression d'un ennemi
      {
        Targets.remove(targetIDDelet);
        Missiles.remove(0);
        deadTarget=false;
      }    




      for (Missile missiles : Missiles) //Rafal de missiles
      {
        missiles.update();
        missiles.fire();
        if (missiles.getX()>=width)
        {
          deadMissile=true;
        }
      }

      if (deadMissile) //suppression des missiless
      {
        Missiles.remove(0);
        deadMissile=false;
      }



      if (isDestroyed) //mort du joueur
      { 
        Audio.stop();
        gameFinishFail();
      }


      if (Audio.progression()+1>=100) //detection de la fin de partie victorieuse
      {
        gameFinishVictory();
      }
    }
  } else
  {
    if (gameOn && !inPlaying) //Initialisation des donnees audios
    {
      Previsu.stop(); //Arret de la lecture de l'echantillon audio
      Audio=new AudioVizualiser(this, lienAudio); //Initialisation de l'Audio de la map
      Audio.SongInitiate();
      inPlaying=true;
    } else if (!inPlaying) //Menu principale
    {
      rectMode(CORNERS);
      if (!isPrevisuCharged)
      {
        Previsu=new AudioVizualiser(this, lienAudio);
        Previsu.SongInitiate();
        Previsu.previsualisation();
        isPrevisuCharged=true;
      } else if (isPrevisuCharged)
      {
        Previsu.metaDataShow();
        Previsu.update();
        Previsu.verticalSpectrumDrawing();
      }
      Menu_Principal.pressStart();
      Menu_Principal.pressExit();
      Select.exeAll(20, 60, 20, 100, 20, 20);
      CursorColorEffect();
      CursorChange();
    } else
    {
    }
  }
  loop();
}


void CursorChange()
{
  if (gameOn)
  {
    cursor(ARROW);
  } else 
  {
    if (mouseX>=20 && mouseX<=20+100 && mouseY>=20 && mouseY<=20+75)
    {
      cursor(HAND);
    } /*else if (mouseX>=18 && mouseX<=126 && mouseY>=49 && mouseY<=65)
     {
     cursor(HAND);
     } */
    else if (mouseX>=width/2-180 && mouseX<=width/2+180 && mouseY>=height/2-60 && mouseY<=height/2+60)
    {
      cursor(HAND);
    } else if (mouseX>=width*7/8-50 && mouseX<=width*7/8+50 && mouseY>=height*7/8-25 && mouseY<=height*7/8+25 && !gameOn && !inPlaying)
    {
      cursor(HAND);
    } else  
    {
      cursor(ARROW);
    }
  }
  loop();
}

void CursorColorEffect()
{
  if (mouseX>=18 && mouseX<=130 && mouseY>=20-16 && mouseY<=20)
  {
    Select.colorEdit(color(255, 0, 0), 255, 255);
  } else if (mouseX>=18 && mouseX<=126 && mouseY>=49 && mouseY<=65)
  {
    Select.colorEdit(255, color(255, 0, 0), 255);
  } else  
  {
    Select.colorEdit(255, 255, 255);
  }
  loop();
}

void temporisation()
{
  tTarget++;
  t++;
}

void keyPressed()
{
  if (!gameOn && !inPlaying && key==' ')
  {
    begin();
  }
  if (gameOn)
  {
    if (key == 'p' || key == 'P') { 
      Audio.playPause();
    } else if (key == 'x' || key == 'X') { 
      stop();
      isPrevisuCharged=false;
      Targets.removeAll(Targets);
    }
  } else
  {
  }

  if (gameOn && inPlaying)
  {
    if (key==' ' && (t>=8))
    {
      t=0;
      Missiles.add(new Missile(Ship.getY()));
    }
  }
  
  loop();
}

void mouseClicked()
{
  if (mouseX>=18 && mouseX<=130 && mouseY>=20-16 && mouseY<=20 && !gameOn && !inPlaying) //répertoire
  {
  } else if (mouseX>=20 && mouseX<=20+100 && mouseY>=20 && mouseY<=20+75 && !gameOn && !inPlaying) //choisir musique
  {
    Select.fileSelect();
    Previsu.stop();
  } else if (mouseX>=width/2-180 && mouseX<=width/2+180 && mouseY>=height/2-60 && mouseY<=height/2+60 && !gameOn && !inPlaying) //lancement
  {
    begin();
  } else if (mouseX>=width*7/8-50 && mouseX<=width*7/8+50 && mouseY>=height*7/8-25 && mouseY<=height*7/8+25 && !gameOn && !inPlaying)
  {
    Previsu.stop();
    exit();
  }
  loop();
}

//fonction selection de fichier
void fileSelected(File selection)
{
  noLoop();
  if (selection == null)
  {
    println("Window was closed or the user hit cancel.");
    isPrevisuCharged=false;
  } else
  {
    println("User selected " + selection.getAbsolutePath());
    lienAudio = selection.getAbsolutePath();
    Select.Adresse(lienAudio);
    isPrevisuCharged=false;
  }
}

void gameFinishFail()
{
  gameEnd=true;
  inPlaying=false;
  gameOn=false;
  isPrevisuCharged=false;
  isDestroyed=false;
  Targets.removeAll(Targets);
}

void gameFinishVictory()
{
  gameEnd=true;
  Targets.removeAll(Targets);
}

void begin()
{
  if (lienAudio=="NNN")
  {
    println("No file found for play the game");
    gameEnd=true;
    gameOn=false;
  } else
  {
    noLoop();
    Ship.reset();
    gameEnd=false;
    gameOn=true;
  }
}

void stop()
{
  Audio.stop();
  inPlaying=false;
  gameOn=false;
}
