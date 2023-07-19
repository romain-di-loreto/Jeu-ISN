import ddf.minim.*;
import ddf.minim.analysis.*;

class AudioVizualiser {

  Minim minim;
  AudioPlayer song;
  FFT fft;
  AudioMetaData meta;

  int echantillonage, prg;
  float colorSave=255, gain, stroke=255, duree, pos, volume=0.5;
  boolean start=true, isEnd, isFullScreen=true, impulse=false;

  AudioVizualiser(PApplet p, String adresse)
  {
    if (width<512+20) { //taille du spectre en fonction de la taille de l'ecran
      echantillonage=512;
    } else if (width>=512+20 && width<1024+20) {
      echantillonage=1024;
    } else if (width>=1024+20 && width<2048+20) {
      echantillonage=2048;
    } else if (width>=2048+20) {
      echantillonage=4096;
    }
    println("echantillonage : ", echantillonage);
    minim = new Minim(p);
    song = minim.loadFile(adresse, echantillonage);
  }

  void playPause()
  {
    if (song.isPlaying()) { 
      song.pause();
    } else if (song.position()==song.length()) {
      stop();
    } else { 
      song.play();
    }
  }

  void SongInitiate() //Calcule obligatoire pour commencer a analyser un fichier audio
  {
    //Metadata
    meta = song.getMetaData();
    //Faste Fourier Transformation
    fft = new FFT(song.bufferSize(), song.sampleRate());
    duree=meta.length();
    song.play();
    noFill();
    noLoop();
  }

  void previsualisation() //musique dans le menu
  {
    song.setGain(-50);
    song.play(song.length()/4);
    song.shiftGain(-50,-15,3000);
    noLoop();
  }

  void colorEffect()
  {
    if ((fft.getBand(4)) >= 100)
    {
      colorSave=0;
      stroke(stroke, 0, 0);
    } else if (colorSave>=0 && colorSave<stroke)
    {
      colorSave+=110;
      stroke(stroke, colorSave, colorSave);
    } else if (colorSave>=stroke)
    {
      colorSave=stroke;
      stroke(stroke, colorSave, colorSave);
    }
    loop();
  }

  boolean impulse()
  {
    if ((fft.getBand(4) >= 100))
    {
      impulse=true;
    } else
    {
      impulse=false;
    }
    return impulse;
  }

  void update()
  {
    fft.forward(song.mix);
  }

  void fullSpectrumDrawing()
  {
    //drawing full spectrum
    stroke(75);
    for (int i = 0; i < fft.specSize(); i+=5)
    {
      line(i+10, (height/2) + fft.getBand(i)*2, i+10, (height/2) - fft.getBand(i)*2);
    }
    loop();
  }
  
  void verticalSpectrumDrawing()
  {
    //drawing a vertical spectrum
    stroke(200);
    for(int i = 0; i < fft.specSize(); i+=5)
    {
      line((width*3/4) + fft.getBand(i)*1.2, i+10, (width*3/4) - fft.getBand(i)*1.2, i+10); 
    }
  }

  void beatSpectrumDrawing() //spectre de basse frequence uniquement. Peut toujours etre utile au cas ou
  {
    for (int i=0; i<5; i++)
    {
      line(3*width/4-100, (3*height/4)+i, 3*width/4 + fft.getBand(i)/2 - 100, (3*height/4)+i);
    }
    loop();
  }

  void soundWave(int wave1height, int wave2Height)
  {
    for (int i = 0; i < song.left.size() - 1; i++)
    {
      stroke(255, 0, 255, stroke);
      line(i, wave1height + song.left.get(i)*50, i+1, wave1height + song.left.get(i+1)*50);
      stroke(0, 150, 255, stroke);
      line(i, wave2Height + song.right.get(i)*50, i+1, wave2Height + song.right.get(i+1)*50);
      stroke(stroke);
    }
    loop();
  }

  void cursorPosition() //barre de progression de l'audio
  {
    stroke(255);
    noFill();
    line(0, height-40, map(song.position(), 0, song.length(), 0, width), height-40);
    loop();
  }

  void metaDataShow()
  {
    fill(fft.getBand(4), 0, stroke-fft.getBand(4), stroke);
    textSize(50);
    text(meta.title(), width/3, 3*height/4+70);
    textSize(20);
    text(meta.author(), width/3, 3*height/4+100);
    textSize(10);
    loop();
  }

  int progression()
  {
    prg=song.position()*100/meta.length();
    return prg;
  }

  boolean isPlaying()
  {
    boolean isPlaying = song.isPlaying();
    return isPlaying;
  }

  void runAll()
  {
    this.update();
    this.fullSpectrumDrawing();
    this.cursorPosition();
    //this.beatSpectrumDrawing();
    this.soundWave(height/8, 7*height/8);
    //this.metaDataShow();
    this.colorEffect();
    this.impulse();
    this.cursorPosition();
    noLoop();
  }

  void stop()
  {
    song.close();
    minim.stop();
  }
}
