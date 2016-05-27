//  https://github.com/peterolson/BigInteger.js


// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);


VImage Img ;
VImage ImgUser = new VImage(20,20,3); //(100,100,2) tooooo much
VImage ImgDate = new VImage(30,30,3);




PImage ImgInput;



int UI_lastId = uivars.id.length();
float UI_lastSlider = uivars.slider;
int Mill = 0;


boolean SinceMode = false;
boolean Overlay = false;

int FrameSize = 500;


interface JavaScript {
  void UI_updateId(String t);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;









void setup ()
{
  size( 500, 600, JAVA2D );
 
  colorMode(RGB,1);
  background(0.18);
  frameRate(60);

 
// @pjs preload must be used to preload the image 
/* @pjs preload="georgios.jpg"; */
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
  translate(0,0);
  if( Img.h > Img.w )  // fit img in the frame square
    scale(float(FrameSize)/Img.h);
  else
    scale(float(FrameSize)/Img.w);
  
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
  
  text(duration(Img.id), 10, 560);
  text(duration(Img.idLimit.minus(Img.id)), 200, 560);
  text(frameRate, 10, 580);
  
 
  
  
  
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
    Img.offset(1);
  }
  if(key=='S')
  {
    Img.offset(-1);
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
  
  if(key=='z')
  {
    var t = bigInt( Img.id );
    //var t = bigInt( (float(mouseX)/float(width)) * 10000000000000000000000000000);
    Img.msg = duration( t );
  }
}







String duration( bigInt f)
{
  // f in frames
  if( f.lesser(60) )
    return( "less than a second");
  
  
  // s = t in seconds
  var s = bigInt(f).divide(60);
  
  // t variable time unit, starting in seconds
  var t = s;
  
  
  
  if( t.lesser(60) )
    if( t.lesser(2) )
      return (t.toString() + " second");
    else
      return (t.toString() + " seconds");
  
  // t in minutes
  t = t.divide(60);
  if( t.lesser(60) )
    if( t.lesser(2) )
      return (t.toString() + " minute");
    else
      return (t.toString() + " minutes");
    
  // t in hours
  t = t.divide(60);
  if( t.lesser(24) )
    if( t.lesser(2) )
      return (t.toString() + " hour");
    else
      return (t.toString() + " hours");
    
  // t in days
  t = t.divide(24);
  if( t.lesser(31) )
    if( t.lesser(2) )
      return (t.toString() + " day");
    else
      return (t.toString() + " days");
  
  // t in days
  // months
  if( t.lesser(365) )
  {
    var m = bigInt(t).divide(31);
    if( m.lesser(2) )
      return (m.toString() + " month");
    else
      return (m.toString() + " months");
  }

  // y = s in years
  var y = bigInt(s).divide(31536000);
  
  // t in years
  t = y;
  if( t.lesser(10) )
  {
    if( t.lesser(2) )
      return (t.toString() + " year");
    else
      return (t.toString() + " years");
  }
  
  // t in decades
  t = y.divide(10);
  if( t.lesser(10) )
  {
    if( t.lesser(2) )
      return (t.toString() + " decade");
    else
      return (t.toString() + " decades");
  }
  
  // t in centuries
  t = y.divide(100);
  if( t.lesser(10) )
  {
    if( t.lesser(2) )
      return (t.toString() + " century");
    else
      return (t.toString() + " centuries");
  }
  
  // t in millenia
  t = y.divide(1000);
  if( t.lesser(1000) )
  {
    if( t.lesser(2) )
      return (t.toString() + " millenium");
    else
      return (t.toString() + " millenia");
  }
  
  // t in megga-annums
  t = y.divide(1000000);
  if( t.lesser(230) )
  {
    if( t.lesser(2) )
      return (t.toString() + " mega-annum");
    else
      return (t.toString() + " mega-annums");
  }
  
  // t in galactic years
  t = y.divide(230000000);
  if( t.lesser(5) )
  {
    if( t.lesser(2) )
      return (t.toString() + " galactic year");
    else
      return (t.toString() + " galactic years");
  }
  
  // t in gigaannum
  t = y.divide(1000000000);
  if( t.lesser(14) )
  {
    if( t.lesser(2) )
      return (t.toString() + " gigaannum");
    else
      return (t.toString() + " gigaannums");
  }
  
  // t in Cosmic years
  t = y.divide(14000000000);
//  if( t.lesser(72) )
  {
    if( t.lesser(2) )
      return (t.toString() + " cosmic year");
    else
      return (t.toString() + " cosmic years");
  }
}


/*
@60fps
<

second        60 itterations                        60 it
minute        60 seconds                            3600 it
hour          60 minutes                            216000 it
day           24 hours                              5184000 it
month         31 days                               160704000 it
year          365 days                              1892160000 it  or 31536000 sec

decade         10 years
ceunturie      100 years
millennium        1,000 years
mega-annum        1,000,000 years
galactic year     230,000,000 years
gigaannum         1,000,000,000 years
Sun's lifespan    12,000,000,000 years
Cosmic callendar  14,000,000,000 years
teraannum         1,000,000,000,000 years
petaannum         1,000,000,000,000,000 years


sun : 12 billion years
universe : 14 billion years



*/








/*
TO DO

no characters to id textArea
clean up javascript/jQuery, check if everything can be on a tab

shift backwards
calculate since / until, in nice text



DONE:
Slider YES!
fix bug with picture not updating slider
non square ratio image


Nah
load image
mipos h updateUI() kalitera sto main kai oxi stin class? (den ta katafera)


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
