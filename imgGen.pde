//  https://github.com/peterolson/BigInteger.js


// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);


VImage Img ;
VImage ImgUser = new VImage(30,30,5); //(100,100,2) tooooo much
VImage ImgDate = new VImage(30,30,3);



// @pjs preload must be used to preload the image 
/* @pjs preload="georgios.jpg"; */
PImage ImgInput;




int UI_lastId = uivars.id.length();
float UI_lastSlider = uivars.slider;
int Mill = 0;


boolean SinceMode = false;
boolean Overlay = false;




interface JavaScript {
  void UI_updateId(String t);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;









void setup ()
{
  size( 500, 550, JAVA2D );
 
  colorMode(RGB,1);
  background(0.18);
  
/* @pjs preload="in/georgios.jpg"; */
  ImgInput = loadImage("cat.jpg");


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
  translate(0,0);
  scale(500.0/Img.h);  //fit height in 500 pixels
  
  
  if( Img.w > 50 )
    Img.drawBitmap();
  else
    Img.draw(Overlay);
  
  popMatrix();
  
  

  //// UI
  
  // when the input chages
  if( UI_lastId != uivars.id )
  {
    UI_lastId = uivars.id;
    Img.setId(uivars.id, Img.cDepth);
  }
  
  if( UI_lastSlider != uivars.slider )
  {
    UI_lastSlider = uivars.slider;
    Img.setIdFromRange(float(uivars.slider));
    //Img.setIdFromRange(float(mouseX)/float(width));
  }
  
  float slider = uivars.slider; 
  text(slider, 10,510);
  text(Img.idLimit, 10,520);
  text("4", 10,530);
  text(Img.msg, 10,540);
  
  
  
  /*
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
  text("input      : " +uivars.id, 10, 40);
  
  
  text(Img.estimateComputeTime(), 10, 680);
  if(SinceMode)
    text("Since :" + RefTime, 200, 30);
    
    
  text( "Img         : "+Img.getId(), 10, 700);
  text( "ImgUser : "+ImgUser.getId() , 10, 710);
  text( "ImgDate : "+ImgDate.getId() , 10, 720);
  
  text( "Img         : "+Img.msg, 300, 700);
  text( "ImgUser : "+ImgUser.msg, 300, 710);
  text( "ImgDate : "+ImgDate.msg, 300, 720);  
  */

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
    Img.updateUI();
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
    ImgUser.setId(uivars.id, ImgUser.cDepth);
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
  
  if(key=='l')
  {
    Img.setIdFromRange(float(mouseX)/float(width));
  }
  
  
}











/*
TO DO

no characters to id textArea
mipos h updateUI() kalitera sto main kai oxi stin class?
clean up javascript/jQuery, check if everything can be on a tab

Slider YES!

fix bug with picture not updating slider

shift backwards
calculate since / until, in nice text
load image
non square ratio image


*/



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
