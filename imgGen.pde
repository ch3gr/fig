//  https://github.com/peterolson/BigInteger.js


// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);


vImage Img ;
VImage ImgUser = new VImage(2,2,2); //(100,100,2) tooooo much
VImage ImgDate = new VImage(25,25,3);




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
  if( SinceMode )
    Img = ImgDate;
  else
    Img = ImgUser;
  
  
  text("Hello World!", 50, 50);
  
}



void draw()
{
  background(0.18);
  smooth();
  
  if( SinceMode )
    Img.shift();

  pushMatrix();
  translate(50,50);
  scale(600.0/Img.h);  //fit height in 500 pixels
  
  Img.drawBitmap();
  //Img.draw(Overlay);
  
  popMatrix();
  
  
  
  
  
  
  
  // Temp text
  
  fill(color(0.7));
  textSize(14);
  
  textSize(11);
  string t = Img.getId();
  text("id              : " +t, 10, 10);
  text("id length  : " + t.length(), 10, 20);
  text("framerate : " +floor(frameRate), 10, 30);
  text("rate : " +floor(1000.0/(millis()-Mill)), 100, 30);
  Mill = millis();
  text("input      : " +uivars.theId, 10, 40);
  
  
  text(Img.msg, 10, 665);
  text(Img.msg, 10, 675);
  text("Since :" + RefTime, 200, 40);
  
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
      Img.setIdFromDate();
    }
    else
      Img = ImgUser;
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
  
  // DELETE - test class copy /////////////////////
  if(key=='t')
  {
    Img = ImgDate;
    Img.setCanvas(10, 10, 4);
  }
  if(key=='T')
  {
    Img = ImgUser;
    Img.setCanvas(40, 40, 2);
  }
  /////////////////////////////////////////////////
  
  if(key=='o')
    Overlay = !Overlay;
    
  if(key=='i')
  {
    ImgUser.setId(uivars.theId, ImgUser.cDepth);
  } 
}

void mousePressed()
{
  ImgUser.shift();
  
}




/*
void importId()
{
  if (uivars.theId.length() > letterSizes.length)
  {
    letterSizes = expand(letterSizes);                // expand array size if new word is longer
  }
}
*/




