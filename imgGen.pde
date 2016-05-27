// UI buttons
HashMap UI_Simple = new HashMap();
HashMap UI_Explore = new HashMap();
HashMap UI_Common = new HashMap();


// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);

VImage Img ;
VImage ImgUser = new VImage(2,2,51); //(100,100,2) tooooo much
VImage ImgDate = new VImage(30,30,3);


PImage[] ImgFile = new PImage[4];


int HUI_lastId = uivars.id.length();
float HUI_lastSlider = uivars.slider;

//int Mill = 0;


boolean AutoMode = false;
boolean Overlay = false;
boolean About = false;
boolean Explore = true;

int Sample = -1;


var Step = bigInt(1);



int FrameSize = 650;


interface JavaScript {
  void HUI_updateId(String t);
}

void bindJavascript(JavaScript js) {
  javascript = js;
}

JavaScript javascript;
















void setup ()
{
  size( 1000, 700, JAVA2D );
 
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
    
    
    
    
    
  ///////////////////////////////////////////////////////////////
  // UIs

  ///////////////////////////////////////////////////////////////
  // UI_Simple
  int px = 700;
  int py = 0;
  int pw = 300;
  int bh = 50;
  int gap = 5;
  
  color baseC = color(0.1,0.1,0.1);
  color overC = color(0.15,0.15,0.15);
  color downC = color(0.8,0.8,0.8);

  UI_Simple.put( "next", new Button("next", false, px, py, width-px, bh*2, baseC, overC, downC));
  
  

  ///////////////////////////////////////////////////////////////
  // UI_Explore
  px = 700;
  py = 0;
  pw = 300;
  bh = 50;
  gap = 5;
  UI_Explore.put( "prev", new Button("-", false, px, py, pw/3-gap, bh*2, baseC, overC, downC) );
  UI_Explore.put( "next", new Button("+", false, px+2*(pw/3)+gap, py, pw/3-gap, bh*2, baseC, overC, downC) );
  
  UI_Explore.put( "incUp", new Button("incUp", false, px+(pw/3), py, pw/3, (bh*0.6), baseC, overC, downC) );
  UI_Explore.put( "incDown", new Button("incDown", false, px+(pw/3), py+(bh*2-bh*0.6), pw/3, (bh*0.6), baseC, overC, downC) );
  
  py += bh*3;
  int px1 = px + pw/6; 
  int px2 = px + pw/2;
  int px3 = px + pw*5.0/6.0;
  int bs = 35;
  UI_Explore.put( "xUp", new Button("+", false, px1-bs/2, py, bs, bs, baseC, overC, downC) );
  UI_Explore.put( "rUp", new Button("+", false, (px1+px2)/2-bs+gap, py, bs*2-gap*2, bs, baseC, overC, downC) );
  UI_Explore.put( "yUp", new Button("+", false, px2-bs/2, py, bs, bs, baseC, overC, downC) );
  UI_Explore.put( "cUp", new Button("+", false, px3-bs/2, py, bs, bs, baseC, overC, downC) );
  py += 80;
  UI_Explore.put( "xDown", new Button("-", false, px1-bs/2, py, bs, bs, baseC, overC, downC) );
  UI_Explore.put( "rDown", new Button("-", false, (px1+px2)/2-bs+gap, py, bs*2-gap*2, bs, baseC, overC, downC) );
  UI_Explore.put( "yDown", new Button("-", false, px2-bs/2, py, bs, bs, baseC, overC, downC) );
  UI_Explore.put( "cDown", new Button("-", false, px3-bs/2, py, bs, bs, baseC, overC, downC) );
  
  py = height - bh*2;
  
  py -= bh*1 + gap ;
  int bs = 4;
  float bw = (pw+gap)/float(bs);
  for( int b=0; b<bs; b++ )
    UI_Explore.put( ("sample"+str(b)), new Button(("s"+str(b+1)), true, px+(bw*b), py, bw-gap, bh, baseC, overC, downC) );
  
  py -= bh + gap;
  UI_Explore.put( "random", new Button("random", false, px, py, pw/2-(gap/2), bh, baseC, overC, downC) );
  UI_Explore.put( "clear", new Button("clear", false, px+pw/2-(gap/2)+gap, py, pw/2-(gap/2), bh, baseC, overC, downC) );
  
  
  
  
  py -= bh + gap;
  UI_Explore.put( "auto", new Button("auto", true, px, py, pw/2-(gap/2), bh, baseC, overC, downC) );
  UI_Explore.put( "overlay", new Button("overlay", true, px+pw/2-(gap/2)+gap, py, pw/2-(gap/2), bh, baseC, overC, downC) );
  
  UI_Explore.put( "slider", new Slider(0,height-20-gap, width, 20) );

  
  
  ///////////////////////////////////////////////////////////////
  // UI_Common
  
  
  py = height - bh*2;
  UI_Common.put( "explore", new Button("explore", true, px, py, pw/2-(gap/2), bh, baseC, overC, downC) );
  UI_Common.put( "about", new Button("about", true, px+pw/2-(gap/2)+gap, py, pw/2-(gap/2), bh, baseC, overC, downC) );
  
  
  
  UI_Common.get("explore").click = Explore;
  update_UI();
}
















void draw()
{
  ////////////////////////////////////////////////////
  //// Logic
  
  
  if( AutoMode )
  {
    //ImgDate.step();
    update_UI();
    Img.shift();
    
    //Img.setIdFromDate( RefTime );
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
  
  // Draw overlay
  
  if( Overlay && Img.w <= 50 && Img.h <= 50)
    Img.overlay();
  
  
  
  
  //// Canvas UI
  ui_common();
  
  
  
  if( UI_Common.get("explore").click )
    ui_explore();
  else
    ui_simple();
  
  

  //// HTML UI to Processing
  /*
  // when the input chages
  if( HUI_lastId != uivars.id )
  {
    HUI_lastId = uivars.id;
    Img.setId(uivars.id, Img.cDepth);
    update_UI();
  }
  
  if( HUI_lastSlider != uivars.slider )
  {
    HUI_lastSlider = uivars.slider;
    Img.setIdFromRange(float(uivars.slider));
    //Img.setIdFromRange(float(mouseX)/float(width));
    update_UI();
  }
  */
  
  
  
  
  //// Temp text
  
  textAlign(LEFT, BOTTOM);
  fill(color(1,0,0));
  textSize(18);
  //text(frameRate, 50, 50);
  text(Img.msg, 10,540);
  
  bigInt a = bigInt(Img.id);
  
  text( a.toString(), 50, 100);
  String aa = a.toString(Img.cDepth);
  text( aa, 50, 130);
  
  String out = "";
  for(int i=0; i<aa.length(); i++)
  {
    if( aa[i] != "<" )
    {
      out += bigInt(aa[i], Img.cDepth);
      out += "_";
    }
    else
    {
      i++;
      while( aa[i] != ">" )
       out += aa[i++];
      
      out += "_";
    }
  }
  text( out, 50, 160);
  
  
  
  
  
  
  
  //textAlign(RIGHT, TOP);
  //text( str(mouseX)+":"+str(mouseY+5), mouseX-5, mouseY+5);
  
  
  //text(Sample, 700, 330);
  /*
  float slider = uivars.slider;
  textSize(12);
  fill(1,1,1);
  text(slider, 10,510);
  text(Img.idLimit, 10,520);
  text("4", 10,530);
  text(Img.msg, 10,540);
  
  text(duration(Img.id), 10, 560);
  text(duration(Img.idLimit.minus(Img.id)), 200, 560);
  
  
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
  if(AutoMode)
    text("Since :" + RefTime, 200, 30);
    
    
  text( "Img         : "+Img.getId(), 10, 700);
  text( "ImgUser : "+ImgUser.getId() , 10, 710);
  text( "ImgDate : "+ImgDate.getId() , 10, 720);
  
  text( "Img         : "+Img.msg, 300, 700);
  text( "ImgUser : "+ImgUser.msg, 300, 710);
  text( "ImgDate : "+ImgDate.msg, 300, 720);  
  */

}




















//////////////////////////////////////////////////////////////////
// KEYBOARD

void keyPressed()
{
  if(key=='c')
  {
    Img.clear();
    update_UI();
  }
    
  if(key=='r')
  {
    Img.randomise();
    update_UI();
  }

  if(key=='s')
  {
    Img.offset(1);
    update_UI();
  }
  if(key=='S')
  {
    Img.offset(-1);
    update_UI();
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
    Overlay = !Overlay;
    //UI_Common.get("overlay").click = !UI_Common.get("overlay").click;
  }
    
  if(key=='i')
  {
    ImgUser.setId(uivars.id, ImgUser.cDepth);
    update_UI();
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
  if(key=='u')
  {
    update_UI();
  }
}




















/*
TO DO

really clear img when reset canvas
when re-set canvas color depth, regenerate img

optimise step (kateuthian apo to id)


touch screen buttons?
HTML UI doesn't update when it's running online
no characters in id textArea
clean up javascript/jQuery, check if everything can be on a tab

Finish layout/graphics
hardcode text coord
About



To Del ??
canvasToId()


DONE:
Slider YES!
fix bug with picture not updating slider
non square ratio image
shift backwards
calculate since / until, in nice text
slider doesn't update Img when in auto mode
sliders/id dont update when canvas is adjusted
combined + / - button


Nah
load image
mipos h updateUI() kalitera sto main kai oxi stin class? (den ta katafera)
prefix ID with canvas resolution
Bug: breaks in certain colorDepths (perfectly fits the step increment)

*/
