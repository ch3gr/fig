//  html javascript functions
//interface JavaScript {
//  void HUI_updateId(String theId);
//  void HUI_updateDivs( boolean explore, boolean about );
//  void HUI_debug(String text);
//}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;








// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);

VImage Img ;
VImage ImgUser = new VImage(25,25,3); //(100,100,2) tooooo much
VImage ImgDate = new VImage(30,30,3);


PImage[] ImgFile = new PImage[4];


//int HUI_lastId = uivars.id.length();




boolean AutoMode = false;
boolean Values = false;
boolean About = false;
boolean Explore = true;
boolean HUI_Update = true;

int Sample = -1;


var Step = bigInt(1);



int FrameSize = 700;













void setup ()
{
  size( 700, 700, JAVA2D );
 
  colorMode(RGB,1);
  background(0.18);
  frameRate(60);



// @pjs preload must be used to preload the image 
/* @pjs preload="georgios.jpg"; */
/* @pjs preload="cat.jpg"; */
/* @pjs preload="emc.jpg"; */
/* @pjs preload="monaLisa.jpg"; */
  ImgFile[0] = loadImage("georgios.jpg");
  ImgFile[1] = loadImage("monaLisa.jpg");
  ImgFile[2] = loadImage("cat.jpg");
  ImgFile[3] = loadImage("emc2.jpg");
  


  ImgDate.setIdFromDate( RefTime );
  
  if( AutoMode )
    Img = ImgDate;
  else
    Img = ImgUser;
    
}
















void draw()
{
  ////////////////////////////////////////////////////
  //// Logic
  
  
  if( AutoMode )
  {
    Img.offset(Step);
    Sample = -1;
    HUI_Update = true;
  }
  
    
  
  ////////////////////////////////////////////////////
  //// Draw Iamge
  
  background(0.18);
  
  
  smooth();
  pushMatrix();
  translate(0,0);
  if( Img.h > Img.w )  // fit img in the frame square
    scale(float(FrameSize)/Img.h);
  else
    scale(float(FrameSize)/Img.w);
  
  if( Img.w > 50 || Img.h > 50)
    Img.drawBitmap();
  else
    Img.draw();
  
  popMatrix();
  
  // Draw values
  
  if( Values && Img.w <= 50 && Img.h <= 50)
    Img.values();
  
  
  
  
  

  //// HTML UI to Processing
  /*
  // when the input chages
  if( HUI_lastId != uivars.id )
  {
    HUI_lastId = uivars.id;
    Img.setId(uivars.id);
    Img.setPixFromId();
  }
  */
  
  //// update HTML UI if needed
  if( HUI_Update )
  {
    HUI_updateImgInfo( compactBig(Step), Img.w, Img.h, Img.cDepth, compactBig(Img.idLimit.add(1)) );
    HUI_updateSlider( Img.getFraction(), duration(Img.id), duration(Img.idLimit.minus(Img.id)));
    HUI_updateId( Img.getId() );
    HUI_Update = false;
    
  }
  
  
  
  
  //// Temp text
  
  textAlign(LEFT, BOTTOM);
  fill(color(1,0,0));
  textSize(18);
  text(frameRate, 50, 500);
  text("AutoMode: "+AutoMode, 50, 530);
  text("Sample: "+Sample, 50, 560);
  text("Msg: "+Img.msg, 50, 590);

  
}




















//////////////////////////////////////////////////////////////////
// KEYBOARD

void keyPressed()
{
  if(key=='z')
  {
    next();
  }
  if(key=='Z')
  {
    prev();
  }

  
  if(key=='c')
  {
    Img.clear();
  }
    
  if(key=='r')
  {
    Img.randomise();
  }

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
    AutoMode = !AutoMode;
    if( AutoMode )
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
  
  if(key=='e')
    UI_Common.get("explore").click = !UI_Common.get("explore").click;
    
  if(key=='o')
  {
    Values = !Values;
    //UI_Common.get("values").click = !UI_Common.get("values").click;
  }
    
  if(key=='i')
  {
    //ImgUser.setId(uivars.id);
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
  }
}














/*
TO DO


Finish layout/graphics/fonts!?!
hardcode text coord?
About



To Del ??
canvasToId()
setIdFromDate()


DONE:
touch screen buttons?
Slider YES!
fix bug with picture not updating slider
non square ratio image
shift backwards
calculate since / until, in nice text
slider doesn't update Img when in auto mode
sliders/id dont update when canvas is adjusted
combined + / - button
optimise step (kateuthian apo to id)
HTML UI doesn't update when it's running online !!!!
really clear img when reset canvas
when re-set canvas color depth, regenerate img
no characters in id textArea
clean up javascript/jQuery, check if everything can be on a tab


Nah
load image
mipos h updateUI() kalitera sto main kai oxi stin class? (den ta katafera)
prefix ID with canvas resolution
Bug: breaks in certain colorDepths (perfectly fits the step increment)

*/
