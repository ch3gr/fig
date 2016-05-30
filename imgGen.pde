
VImage Img = new VImage(25,25,3); //(100,100,2) tooooo much

PImage[] ImgFile = new PImage[4];

boolean AutoMode = false;
boolean Values = false;
boolean About = false;
//boolean Explore = true;
boolean HUI_Update = true;
boolean URL_Update = false;
int URL_UpdateMillis = 0;

int Sample = -1;

var Step = bigInt(1);


int FrameSize = 1000;



void setup ()
{
  size( 1000, 1000, JAVA2D );
 
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
  

}
















void draw()
{
  ////////////////////////////////////////////////////
  //// Logic
  
  
  if( AutoMode )
  {
    next();
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
  
  
  
  
  
  //// update HTML UI if needed
  if( HUI_Update )
  {
    String res = str(Img.w) +" x "+ str(Img.h);
    HUI_updateImgInfo( compactBig(Step), res, Img.cDepth, compactBig(Img.idLimit.add(1)) );
    HUI_updateSlider( Img.getFraction(), duration(Img.id), duration(Img.idLimit.minus(Img.id)));
    HUI_updateId( Img.getId() );
    HUI_updateToggle( AutoMode, Values, Sample );
    HUI_Update = false;
  }
  
  
  
  
  
  //// update URL # if needed
  //URL_Update = true;
  //if( URL_Update )
  //if( millis() > URL_UpdateMillis + 500 )
  if(0)
  {

   
    URL_change(createURL());
    
    URL_UpURL_Update = false;
    URL_UpdateMillis = millis();
  }
  
  
  
  
  
  //// Temp text
  
  textAlign(LEFT, BOTTOM);
  fill(color(1,0,0));
  textSize(18);
  text(frameRate, 50, 500);
  text("AutoMode: "+AutoMode, 50, 530);
  text("Sample: "+Sample, 50, 560);
  text("Msg: "+Img.msg, 50, 590);
  text("values: "+Values, 50, 620);
  text("URL: "+URL_Update, 50, 120);
  
  
}












//////////////////////////////////////////////////////////////////
// KEYBOARD

void keyPressed()
{
  if(key=='n' || key==' ' || keyCode == RIGHT)
    next();
  
  if(key=='p' || keyCode == BACKSPACE || keyCode == LEFT)
    prev();
  
  if(key=='c')
    clearCanvas();
    
  if(key=='r')
    randomImg();

  if(key=='a')
    autoMode();
  
  if(key=='t')
    xUp();

  if(key=='g')
    xDown();

  if(key=='y')
    rUp();

  if(key=='h')
    rDown();

  if(key=='u')
    yUp();
    
  if(key=='j')
    yDown();
  
  if(key=='i')
    cUp();
  
  if(key=='k')
    cDown();
  
  if(key=='v')
    showValues();
  
}






void mousePressed()
{
  next();
  }







/*
TO DO

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

*/
