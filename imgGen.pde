//  https://github.com/peterolson/BigInteger.js


// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);


VImage ImgUser = new VImage(5,5,4); //(100,100,2) tooooo much
VImage ImgDate = new VImage(4,4,4);




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
  
  
  
  text("Hello World!", 50, 50);
  
}



void draw()
{
  background(0.18);

  smooth();
  
  pushMatrix();
  translate(50,50);
  if( SinceMode )
  {
    
    
    scale(600.0/ImgDate.h);  //fit height in 500 pixels
    ImgDate.shift();
    ImgDate.draw(Overlay);
    //ImgDate.drawBitmap();
  }
  else
  {
    scale(600.0/ImgUser.h);  //fit height in 500 pixels
    ImgUser.draw(Overlay);
    //ImgUser.resize(60,60);
    //ImgUser.drawBitmap();
  }
  popMatrix();
  
  
  
  
  
  
  
  // Temp text
  
  fill(color(0.7));
  textSize(14);
  
  textSize(11);
  string t = ImgUser.getId();
  text("id              : " +t, 10, 10);
  text("id length  : " + t.length(), 10, 20);
  text("framerate : " +floor(frameRate), 10, 30);
  text("rate : " +floor(1000.0/(millis()-Mill)), 100, 30);
  Mill = millis();
  text("input      : " +uivars.theId, 10, 40);
  
  
  text(ImgUser.msg, 10, 665);
  text(ImgDate.msg, 10, 675);
  text("Since :" + RefTime, 200, 40);
  
  if( LastSize != uivars.theId.length() )
  {
    LastSize = uivars.theId.length();
    ImgUser.setId(uivars.theId, ImgUser.cDepth);
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
      ImgDate.setIdFromDate();
  }
  
  
  if(key=='+')
  {
    ImgDate.setCanvas(ImgDate.w+1, ImgDate.h+1, ImgDate.cDepth);  
  }
    if(key=='-')
  {
    ImgDate.setCanvas(ImgDate.w-1, ImgDate.h-1, ImgDate.cDepth);
  }
  if(key=='*')
  {
    ImgDate.setCanvas(ImgDate.w, ImgDate.h, ImgDate.cDepth+1);
  }
  if(key=='.')
  {
    ImgDate.setCanvas(ImgDate.w, ImgDate.h, ImgDate.cDepth-1);
  }
  
  
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




