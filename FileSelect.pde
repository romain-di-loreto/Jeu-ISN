class FileSelect {

  String adresse = "NNN";
  color colorButtonRep=255, colorButtonFile=255, colorAdresse=255;
  PImage bouton, boutonSelect; 
  
  FileSelect()
  {
    bouton = loadImage("bouton.png");
    boutonSelect = loadImage("boutonSelect.png");
  }
  
  //objet servant juste a recuperer l'adresse pour le stocker
  void Adresse(String lien)
  {
   adresse = lien; 
  }

  //Fonction affichage de bouton
  void showButton(int x,int y)
  {
    rectMode(CORNER);
    fill(colorButtonRep);
    textSize(10);
    text("Changer de répertoire", x, y);
    stroke(colorButtonRep);
    line(x, y+2, x+107, y+2);
    noFill();
    rect(x-2, y+5, 112, -16);
  }

  //affichage des adresses 
  void showAdress(int x,int y)
  {
    fill(colorAdresse);
    stroke(colorAdresse);
    text(adresse, x, y);
    //text(adresse1, 100, 120);
  }

  //affichage du bouton "file
  void showFileButton(int x, int y)
  {
    imageMode(CORNER);
    if (mouseX>=x && mouseX<=x+100 && mouseY>=y && mouseY<=y+75){
    image(boutonSelect,x,y);
    }else{
      image(bouton,x,y);
    }
  }
  
  void fileSelect()
  {
    selectInput("Select music", "fileSelected");
  }

  void colorEdit(color colorRep, color colorFile, color colorAdress)
  {
    colorAdresse=colorAdress; //La seule difference entre les deux varible est le 'e' a la fin. Faire attention. colorAdresse etant la variable de la classe
    colorButtonRep=colorRep;
    colorButtonFile=colorFile;
  }

  //tout executer sauf fileSelected et fileSelect
  void exeAll(int xB, int yB, int xA, int yA, int xFB, int yFB)
  {
    this.showFileButton(xFB,yFB);
    //this.showAdress(xA,yA);
    //this.showButton(xB,yB);
  }
}
