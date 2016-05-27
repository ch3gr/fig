//  https://github.com/peterolson/BigInteger.js


// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);


VImage Img ;
VImage ImgUser = new VImage(30,30,4); //(100,100,2) tooooo much
VImage ImgDate = new VImage(5,5,5);
VImage ImgFile = new VImage(100,100,5);



// @pjs preload must be used to preload the image 
/* @pjs preload="georgios.jpg"; */
PImage ImgInput;




int LastSize = 0;
int Mill = 0;


boolean SinceMode = true;
boolean Overlay = false;



void setup ()
{
  size( 700, 700, JAVA2D );
  
  
  colorMode(RGB,1);
  background(0.18);
  

  ImgDate.setIdFromDate();
  //ImgDate.id = 100;
  if( SinceMode )
    Img = ImgDate;
  else
    Img = ImgUser;
  
/* @pjs preload="in/georgios.jpg"; */
  ImgInput = loadImage("georgios.jpg");
  
  text("Hello World!", 50, 50);
}



void draw()
{
  background(0.18);
  smooth();
  
  if( SinceMode )
    ImgDate.shift();

  pushMatrix();
  translate(50,50);
  scale(600.0/Img.h);  //fit height in 500 pixels
  
  //Img.drawBitmap();
  Img.draw(Overlay);
  
  popMatrix();
  
  
  
  // Temp text
  
  fill(color(0.7));
  textSize(14);
  
  textSize(11);
  string idStr = Img.getId();
  text("id              : " +idStr, 10, 10);
  text("id length  : " + idStr.length(), 10, 20);
  text("framerate : " +floor(frameRate), 10, 30);
  text("rate : " +floor(1000.0/(millis()-Mill)), 100, 30);
  Mill = millis();
  text("input      : " +uivars.theId, 10, 40);
  
  
  text(Img.estimateComputeTime(), 10, 680);
  text(Img.msg, 10, 690);
  if(SinceMode)
    text("Since :" + RefTime, 200, 30);
  
  if( LastSize != uivars.theId.length() )
  {
    LastSize = uivars.theId.length();
    Img.setId(uivars.theId, Img.cDepth);
  }
  
}


void keyPressed()
{
  if(key=='c')
  {
    ImgUser.clear();
  }
    
  if(key=='r')
    ImgUser.randomise();

  if(key=='s')
  {
    ImgUser.shift();
  }
  
  if(key=='d')
  {
    SinceMode = !SinceMode;
    if( SinceMode )
    {
      Img = ImgDate;
//      Img.setIdFromDate();
    }
    else
    {
      Img = ImgUser;
//      Img.updateId();
    }
  }
  
  
  if(key=='+')
  {
    Img.setCanvas(Img.w+1, Img.h+1, Img.cDepth);  
  }
    if(key=='-')
  {
    Img.setCanvas(Img.w-1, Img.h-1, Img.cDepth);
  }
  if(key=='*')
  {
    Img.setCanvas(Img.w, Img.h, Img.cDepth+1);
  }
  if(key=='.')
  {
    Img.setCanvas(Img.w, Img.h, Img.cDepth-1);
  }
  
  
  if(key=='o')
    Overlay = !Overlay;
    
  if(key=='i')
  {
    ImgUser.setId(uivars.theId, ImgUser.cDepth);
  }
  if(key=='p')
  {
    ImgUser.setIdFromImg(ImgInput);
  }
}

void mousePressed()
{
  ImgDate.setIdFromDate();
}



/*
  OLD MOUSE CONTROL
  
  if(mouseX>50 && mouseY>50 && mouseX<width-50 && mouseY<height-50)
    ImgUser.shift();
  
  
  if(mouseX<50 && mouseY<50)
  {
    SinceMode = !SinceMode;
    if( SinceMode )
    {
      Img = ImgDate;
      Img.setIdFromDate();
    }
    else
    {
      Img = ImgUser;
      Img.updateId();
    }
  }
  
  if(mouseX<50 && mouseY>height-50)
    ImgUser.setIdFromImg(ImgInput);
  
  if(mouseX>50 && mouseX<width-50 && mouseY<50)
    Img.setCanvas(Img.w+1, Img.h+1, Img.cDepth);  
  if(mouseX>50 && mouseX<width-50 && mouseY>height-50)
    Img.setCanvas(Img.w-1, Img.h-1, Img.cDepth);
  if(mouseX<50 && mouseY>50 && mouseY<height-50)
    Img.setCanvas(Img.w, Img.h, Img.cDepth-1);
  if(mouseX>50 && mouseY>50 && mouseY<height-50)
    Img.setCanvas(Img.w, Img.h, Img.cDepth+1);
    
*/



/*
void importId()
{
  if (uivars.theId.length() > letterSizes.length)
  {
    letterSizes = expand(letterSizes);                // expand array size if new word is longer
  }
}
*/




