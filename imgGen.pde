//  https://github.com/peterolson/BigInteger.js


// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);


VImage Img ;
VImage ImgUser = new VImage(30,30,5); //(100,100,2) tooooo much
VImage ImgDate = new VImage(30,30,3);



// @pjs preload must be used to preload the image 
/* @pjs preload="georgios.jpg"; */
PImage ImgInput;




int UI_lastId = uivars.theId.length();
int Mill = 0;


boolean SinceMode = false;
boolean Overlay = false;



void setup ()
{
  size( 700, 800, JAVA2D );
 
  colorMode(RGB,1);
  background(0.18);
  
/* @pjs preload="in/georgios.jpg"; */
  ImgInput = loadImage("georgios.jpg");


  ImgDate.setIdFromDate( RefTime );
  //ImgDate.setId(9999999, ImgDate.cDepth);
  
  ImgUser.setId(999999999999999, ImgUser.cDepth);
  
  if( SinceMode )
    Img = ImgDate;
  else
    Img = ImgUser;
  
  
  
  
}








void draw()
{


  
  
  //// Logic
  
  if( SinceMode )
  {
    //ImgDate.step();
    Img.shift();
    //Img.setIdFromDate( RefTime );
  }
  
  background(0.18);
  smooth();
    
  
  //// Draw

  pushMatrix();
  translate(50,50);
  scale(600.0/Img.h);  //fit height in 500 pixels
  
  
  if( Img.w > 50 )
    Img.drawBitmap();
  else
    Img.draw(Overlay);
  
  popMatrix();
  
  

  //// UI
  
  // when the input chages
  if( UI_lastId != uivars.theId )
  {
    UI_lastId = uivars.theId;
    Img.setId(uivars.theId, Img.cDepth);
  }
  
  
  
  
  
  
  //// Temp text
  
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
  if(SinceMode)
    text("Since :" + RefTime, 200, 30);
    
    
  text( "Img         : "+Img.getId(), 10, 700);
  text( "ImgUser : "+ImgUser.getId() , 10, 710);
  text( "ImgDate : "+ImgDate.getId() , 10, 720);
  
  text( "Img         : "+Img.msg, 300, 700);
  text( "ImgUser : "+ImgUser.msg, 300, 710);
  text( "ImgDate : "+ImgDate.msg, 300, 720);  
  

}














void keyPressed()
{
  if(key=='c')
  {
    Img.clear();
  }
    
  if(key=='r')
    Img.randomise();

  if(key=='s')
  {
    Img.shift();
  }
  
  if(key=='d')
  {
    SinceMode = !SinceMode;
    if( SinceMode )
    {
      Img = ImgDate;
      //Img.setIdFromDate( RefTime );
    }
    else
    {
      Img = ImgUser;
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
  
  if(key=='v')
  {
    ImgDate.setIdFromDate( RefTime );
    
    var time = new Date(1970, 1, 1);
    println( time.getTime() );
  }
  
}




void mousePressed()
{
  
}




















/*

35    years
12460    days
299040    hours
17942400  minutes
1076544000  seconds
1076544000000  millis

64592640000  frames


birthday
353736000000
now
1456710681849

age
1102974681849  millis


66178507000

*/
