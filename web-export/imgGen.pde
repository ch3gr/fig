// UI buttons
HashMap UI_Simple = new HashMap();
HashMap UI_Explore = new HashMap();
HashMap UI_Common = new HashMap();


// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);

VImage Img ;
VImage ImgUser = new VImage(25,25,3); //(100,100,2) tooooo much
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
  UI_Explore.put( "yUp", new Button("+", false, px2-bs/2, py, bs, bs, baseC, overC, downC) );
  UI_Explore.put( "cUp", new Button("+", false, px3-bs/2, py, bs, bs, baseC, overC, downC) );
  py += 80;
  UI_Explore.put( "xDown", new Button("-", false, px1-bs/2, py, bs, bs, baseC, overC, downC) );
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
  
  UI_Explore.put( "slider", new Slider(0,660, width, 30) );

  
  
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
  
  if( Img.w > 50 )
    Img.drawBitmap();
  else
    Img.draw(Overlay);
  
  popMatrix();
  
  
  //// Canvas UI
  //update_UI();
  ui_common();
  
  if( UI_Common.get("explore").click )
    ui_explore();
  else
    ui_simple();
  
  

  //// HTML UI to Processing
  
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
  
  
  
 
  
  //// Temp text
  text(Sample, 700, 330);
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
  text(frameRate, 10, 580);
  
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
    Overlay = !Overlay;
    
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
    Img.msg = duration( t );
  }
  if(key=='u')
  {
    update_UI();
  }
}




















/*
TO DO


sliders/id dont update when canvas is adjusted

touch screen buttons?

HTML UI doesn't update when it's running online
no characters in id textArea
clean up javascript/jQuery, check if everything can be on a tab


To Del ??
canvasToId()


DONE:
Slider YES!
fix bug with picture not updating slider
non square ratio image
shift backwards
calculate since / until, in nice text
slider doesn't update Img when in auto mode


Nah
load image
mipos h updateUI() kalitera sto main kai oxi stin class? (den ta katafera)
prefix ID with canvas resolution
Bug: breaks in certain colorDepths (perfectly fits the step increment)

*/
// Global to track if one button is pressed, to prevent more at any one time
boolean OneButtonClicked = false;

// Need this global to check if mouse is over the sketch
boolean MouseOver = true;
void mouseOver()
{
  MouseOver = true;
}
void mouseOut()
{
  MouseOver = false;
  mousePressed = false;
}



// http://processingjs.org/learning/topic/buttons/
// by Casey Reas and Ben Fry

class Button
{
  int x, y, sx, sy;
  color baseC, overC, downC;
  
  boolean over = false;
  boolean down = false;
  boolean click = false;
  boolean toggle;
  int timer;
  
  String label;

  Button(String ilabel, boolean itoggle, int ix, int iy, int isx, int isy, color ibaseC, color ioverC, color idownC)
  {
    label = ilabel;
    x = ix;
    y = iy;
    sx = isx;
    sy = isy;
    baseC = ibaseC;
    overC = ioverC;
    downC = idownC;
    toggle = itoggle;
    timer = -1;
  }


  boolean isOver() 
  {
    if ( !OneButtonClicked && MouseOver && mouseX >= x && mouseX <= x+sx && mouseY >= y && mouseY <= y+sy)
    {
      over = true;
      return true;
    }
    else
    {
      over = false;
      return false;
    }
  }
  
  boolean isDown()
  {
    if( !down && mousePressed && over )
    {
      down = true;
      OneButtonClicked = true;
      return true;
    }
    // Keep it down even not over
    if( down && !mousePressed )
    {
      down = false;
      OneButtonClicked = false;
      return false;
    }
    
    // Auto release when not over
    /*
    else
    {
      down = false;
      return false;
    }
    */
  }
  
  
  
  
  void update() 
  {
    boolean pDown = down;
    
    isOver();
    isDown();
    
    if( !toggle )
    {
      click = false;
      // first frame down
      if( !pDown && down )
      {
        click = true;
        timer = millis();
      }
      
      // continious press
      if( timer>-1 && millis()-timer > 500 )
        click = true;
      
      // last frame down
      if( pDown && !down )
      {
        click = false;
        timer = -1;
      }
    }
    else
    {
     if( !pDown && down )
       click = !click;
    }
    
  }
  
  
  void draw() 
  {
    color c; 
    if( down || click )
      c = downC;
    else if ( over )
      c = overC;
    else
      c = baseC;
 
    stroke(0.2,0.2,0.2);
    strokeWeight(2);
    fill(c);
    rect(x, y, sx, sy);
    
    fill(0.2,0.2,0.2);
    textSize(sy* 0.75);
    textAlign(CENTER, CENTER);
    text(label, x+sx/2, y+sy/2);
    
    
    
    // Debug info
    /*
    fill(0.8,0,0);
    textSize(10);
    textAlign(LEFT, TOP);
    text(over, x, y);
    text(down, x, y+sy/2);
    text(click, x, y+sy-10);
    */
  }

}


void update_UI()
{
  
  ////////////////////////////////////////////////////
  // Calculate and Update sliders
  // integer that holds id/idLimit * 1000000
  bigInt mil = bigInt(Img.id.multiply(1000000)).divide(Img.idLimit.multiply(1));
  float portion = mil.toString();
  portion /= 1000000.0;
  
  // Update HTML slider
  if(javascript!=null)
  {
    boolean explore = UI_Common.get("explore").click;
    boolean about = UI_Common.get("about").click;
    
    // Prefix id with ImgAttr -- Nah
    //id = str(Img.w)+":"+str(Img.w)+":"+str(Img.cDepth)+"|";
    String id = Img.getId();
    
    javascript.HUI_updateId(id, portion, explore, about);
  }

  // Update processing slider
  UI_Explore.get("slider").v = portion;
  
}








////////////////////////////////////////////////////
////////////////////////////////////////////////////
// UI SETS
////////////////////////////////////////////////////




void ui_common()
{
  ////////////////////////////////////////////////////
  // RENDER UI  
  
  // Loop through all the buttons
  Iterator i = UI_Common.entrySet().iterator();  // Get an iterator
  while (i.hasNext())
  {
    Map.Entry me = (Map.Entry)i.next();
    me.getValue().update();
    me.getValue().draw();
  }
  
  
  ////////////////////////////////////////////////////
  // Button actions

  if( UI_Common.get("explore").click )
    Explore = true;
  else
    Explore = false;
  
  if( UI_Common.get("about").down )  // Bit crap that updates all the time while it's down, but oh well
    update_UI();
  if( UI_Common.get("explore").down )  // Bit crap that updates all the time while it's down, but oh well
    update_UI();
}





void ui_simple()
{
  ////////////////////////////////////////////////////
  // RENDER UI  
  
  // Loop through all the buttons
  Iterator i = UI_Simple.entrySet().iterator();  // Get an iterator
  while (i.hasNext())
  {
    Map.Entry me = (Map.Entry)i.next();
    me.getValue().update();
    me.getValue().draw();
  }
  
  ////////////////////////////////////////////////////
  // Button actions
  
  if( UI_Simple.get("next").click )
  {
    Img.offset(Step);
    update_UI();
    
    if(Sample > -1)
      resetSamples(-1);
  }
}






void ui_explore()
{
  ////////////////////////////////////////////////////
  // RENDER UI  
  
  // Loop through all the buttons
  Iterator i = UI_Explore.entrySet().iterator();  // Get an iterator
  while (i.hasNext())
  {
    Map.Entry me = (Map.Entry)i.next();
    me.getValue().update();
    me.getValue().draw();
  }
  
  // Print some info
  textSize(20);
  textAlign(CENTER, CENTER);
  fill(0.8);
  int xc, yc;
  
  xc = ((UI_Explore.get("prev").x + UI_Explore.get("prev").sx/2) + (UI_Explore.get("next").x + UI_Explore.get("next").sx/2))/2;
  yc = ((UI_Explore.get("incUp").y + UI_Explore.get("incUp").sy/2) + (UI_Explore.get("incDown").y + UI_Explore.get("incDown").sy/2))/2;
  text( compactBig(Step), xc, yc);
  
  yc = ((UI_Explore.get("xUp").y + UI_Explore.get("xUp").sy/2) + (UI_Explore.get("xDown").y + UI_Explore.get("xDown").sy/2))/2;
  xc = (UI_Explore.get("xUp").x + UI_Explore.get("xUp").sx/2);
  text( Img.w, xc, yc);
  xc = (UI_Explore.get("yUp").x + UI_Explore.get("yUp").sx/2);
  text( Img.h, xc, yc);
  xc = (UI_Explore.get("cUp").x + UI_Explore.get("cUp").sx/2);
  text( Img.cDepth, xc, yc);
  
  xc = UI_Explore.get("auto").x;
  yc = height/2 + 20;
  textSize(14);
  textAlign(LEFT, BOTTOM);
  text( ("Set : "+ compactBig(Img.idLimit)), xc, yc);
  
  
  text( "From A  : "+ duration(Img.id), xc, yc+20);
  text( "To       B  : "+ duration(Img.idLimit.minus(Img.id)), xc, yc+40);
  
  
  
  
  ////////////////////////////////////////////////////
  // Button actions
  
  if( UI_Explore.get("prev").click )
  {
    Img.offset(-Step);
    update_UI();
    resetSamples(-1);
  }
  if( UI_Explore.get("next").click )
  {
    Img.offset(Step);
    update_UI();
    resetSamples(-1);
  }
  
  
  if( UI_Explore.get("incUp").click )
  {
    Step = Step.multiply(2);
  }
  if( UI_Explore.get("incDown").click )
  {
    Step = Step.divide(2);
    if( Step.lesser(1) )
      Step = bigInt(1);
  }
  
  
  
  if( UI_Explore.get("xUp").click )
  {
    Img.setCanvas(Img.w+1, Img.h, Img.cDepth);
    applySample(Sample);
  }
  if( UI_Explore.get("xDown").click )
  {
    Img.setCanvas(Img.w-1, Img.h, Img.cDepth);
    applySample(Sample);
  }
    
  if( UI_Explore.get("yUp").click )
  {
    Img.setCanvas(Img.w, Img.h+1, Img.cDepth);
    applySample(Sample);
  }
  if( UI_Explore.get("yDown").click )
  {
    Img.setCanvas(Img.w, Img.h-1, Img.cDepth);
    applySample(Sample);
  }
    
  if( UI_Explore.get("cUp").click )
  {
    Img.setCanvas(Img.w, Img.h, Img.cDepth+1);
    applySample(Sample);
  }
  if( UI_Explore.get("cDown").click )
  {
    Img.setCanvas(Img.w, Img.h, Img.cDepth-1);
    applySample(Sample);
  }
    

  if( UI_Explore.get("overlay").click )
  {
    Overlay = true;
    update_UI();
  }
  else
    Overlay = false;
  
  if( UI_Explore.get("random").click )
  {
    resetSamples(-1);
    Img.randomise();
    update_UI();
  }
  if( UI_Explore.get("clear").click )
  {
    resetSamples(-1);
    Img.clear();
    update_UI();
  }
  


  if( UI_Explore.get("slider").changed )
  {
    Img.setIdFromRange( UI_Explore.get("slider").v );
    update_UI();
    
    if(Sample > -1)
      resetSamples(-1);
  }  
  
  
  
  
  // Deal with the multiple samples - ma ti poutsa!!!
  boolean pressed = false;
  for(int s=0; s<ImgFile.length(); s++)  
  {
    if( UI_Explore.get("sample"+str(s)).click )
    {
      pressed = true;
      // skip currently pressed button
      if( s==Sample )
        continue;

      resetSamples(s);
      applySample(s);
      text("recalc", 700, 300);
    }
  }
  // reset global if non is pressed
  if(!pressed)
    Sample = -1;
  ////////////////////
  
  
  
  
  // Sto telos to auto gia na to kanoun over-ride oi ypolipes leitourgies (samples, random, slider)
  if( UI_Explore.get("auto").click )
  {
    Img.offset(Step);
    update_UI();
    
    resetSamples(-1);
  }
}



void applySample(int sample)
{
  if( sample>-1 )
  {
    ImgUser.setIdFromImg(ImgFile[sample]);
    update_UI();
  }
}

void resetSamples(int exclude)
{
  for(int i=0; i<ImgFile.length(); i++)
  {
    if( i == exclude )
      continue;
    else
      UI_Explore.get("sample"+str(i)).click = false;
  }
  
  Sample = exclude;
}







String commas( String numberIn )
{
  String out = "";
  for( int c=0; c<numberIn.length(); c++ )
  {
    int d = numberIn.length()-1 - c;
    
    out += numberIn[c];
    
    if( d!=0 && d%3==0 )
      out += ",";
  }
  return out;
}





String compact( var n )
{
  if( n < 1000000000 )
    return str(n);
  else
  {
    var out = n.toExponential(0);
    return out.replace("e+", "x10^");
  }
  // limit : 9*10^307
  
}

String compactBig( bigInt n )
{
  String nStr = n.toString();
  
  if( nStr.length() > 9 )
  {
    String out = nStr.charAt(0);
    out += " * 10 ^ ";
    out += commas(str(nStr.length()-1));
    return out;
  }
  else
    return commas(nStr);
    
  
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
  // Years is the limit
  //if( t.lesser(10) )
  {
    if( t.lesser(2) )
      return (t.toString() + " year");
    else
      return (compactBig(t) + " years");
  }
  /*
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
  */
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






class Slider
{
  int x, y, sx, sy;
  float v, vLast;
  Button b;
  boolean changed = false;
  
  int bs = 10;
  
  Slider( int ix, int iy, int isx, int isy )
  {
    x = ix;
    y = iy;
    sx = isx;
    sy = isy;
    
    v = 0;
    vLast = 0;
    
    b = new Button("", false, x, y, bs*2, sy, color(0.1), color(0.2), color(0.3));
  }
  
  

  
  
  void update() 
  {
    b.update();
    changed = false;
    if(b.down)
    {
      v = ( map( mouseX, x+bs, x+sx-bs, 0, 1) );
      if(v<0) v=0;
      if(v>1) v=1;
      
      if( v != vLast )
      {
        changed = true;
        vLast = v;
      }
      else
        changed = false;
      
    }
    // move slider
    b.x = map( v, 0,1, x, x+sx-2*bs );
  }
  
  
  void draw() 
  {
    color c = color(0.5,0.5,0.5);

 
    
    noFill();
    stroke(0.2);
    strokeWeight(0.5);
    rect(x, y, sx, sy);
    
    strokeWeight(3);
    stroke(0.1);
    line(x+bs, y+sy/2.0, x+sx-bs, y+sy/2.0);
    b.draw();
    
    
    // DEBUG
    /*
    fill(0.8);
    textAlign(LEFT, TOP);
    textSize(14);
    text(v, x, y);
    textAlign(LEFT, BOTTOM);
    text(changed, x, y+sy);
    */
  }
  
}
class VImage
{
  int cDepth;
  int w;
  int h;
  int size;
  float[] pix;
  String msg;
  
  PImage bitmap;
  
  var id = bigInt();
  var idLimit = bigInt();

  
  VImage(int wIn, int hIn, int cIn)
  {
    cDepth = cIn;
    w = wIn;
    h = hIn;
    size = w * h;
    idLimit = bigInt(cDepth).pow(w*h).subtract(1);
    msg = "w: " + w + " h: "+h +"cDepth: " + cDepth;
    pix = new int[size];
    
    
    bitmap = new PImage(w,h,RGB);
  }
  
  // OVERLOAD constructor
  VImage(int wIn, int hIn, int cIn, var idIn)
  {
    cDepth = cIn;
    w = wIn;
    h = hIn;
    size = w * h;
    idLimit = bigInt(cDepth).pow(w*h).subtract(1);
    msg = "w: " + w + " h: "+h +"cDepth: " + cDepth;
    pix = new int[size];
    
    
    bitmap = new PImage(w,h,RGB);
    
    setId( idIn, cDepth );
  }
  



 
  void clear()
  {
    for( int p = 0; p<size; ++p )
      pix[p] = 0;
    
    //canvasToId();    // oxi etsi, giati to size to canvas einai mikrotero??
    id = bigInt(0);
    //update_UI();
    
  }
  
  
  
  void randomise()
  {
    for( int p = 0; p<size; ++p )
      pix[p] = floor(random(cDepth));
    
    canvasToId();
    
  }
  
  
  
  
  
  // Canvas driven increment
  void shift()
  {
    id = id.add(1);
    
    pix[0] ++;
    propagate(0);
    //update_UI();
    
  }
  
  void propagate(int p)
  {
 
    if( pix[p] >= cDepth )
    {
      pix[p] = 0;
      if( p+1<size )
      {
        pix[++p] ++;
        propagate( p );
      }
      else
        clear();
    }
    
  }
  
  
  
  // Id driven increment
  void offset(int o)
  {
    id = id.add(o);
    
    // reset id if outside limit
    if( id.lesser( bigInt(0) ) )
      id = idLimit.minus( id.minus(o) );
    else if( id.greater( idLimit ) )
      id = bigInt(0).add( id.minus(idLimit) ).minus(1);
    
    setId(id, cDepth);
    //update_UI();
    
  }
  
  
  
  
  
  void draw(boolean overlay)
  {
    noStroke();
    int p=0;
    for (int y=0; y<h; y++)
      for (int x=0; x<w; x++)
      {
        color c = color(pix[p]/float(cDepth-1));
        fill(c);
        rect(x,y,1,1);
        
        if( overlay )
        {
          fill(color(0.9,0.5,0.4));
          textSize(0.5);
          text(pix[p], x, y+1);
        }
        
        p++;
      }
  }
  
  
  
  void drawBitmap()
  {
    for( int p = 0; p<size; ++p )
    {
      bitmap.pixels[p] = color(pix[p]/float(cDepth-1));
      //bitmap.pixels[p] = color(0.5,0.5,1);
    }
    
    image(bitmap,0,0);
  }
  
  










  String getId()
  {
    return id.toString();
  } 
  
  





  
  
  
  
  
  


  void setId(String idIn, int depth)
  {
    clear();
    
    String idBaseConvert = bigInt(idIn).toString(depth);
    
    
    for(int d=0; d<idBaseConvert.length(); d++)
    {
      int dInv = idBaseConvert.length()-d-1;
      
      // the new color of the itterated digit
      dColor = bigInt(idBaseConvert[d]);
      String newColor = dColor.toString();
      
      pix[dInv] = int(newColor);
    }
    
    id = bigInt(idBaseConvert, depth);
    
    //update_UI();
    
    
    // FIX : extra conversion to support 10+ depth
    // Warning ean kseperaseis to size
  }
  
  
  
  
  
  void setIdFromDate( Date dateIn)
  {
    double now = new Date();
    // Calculate how many milliseconds since the input date
    double frame = now.getTime() - dateIn.getTime();
    
    frame *= 0.06;  // milliseconds * frames/milli
     
    setId(frame, cDepth);
    
  }
  
  
  
  void setIdFromRange( float v )
  {
    var newId = idLimit;
    newId = newId.multiply(v);
    setId(newId, cDepth);
    //setId(1000, cDepth);
    
  }
  
  
  
  void setIdFromImg(PImage imgIn)
  {
    // make a copy of the input image, to resize without loss of information
    int nW = imgIn.width;
    int nH = imgIn.height;
    PImage imgR = new PImage(nW,nH);
    
    for(int p=0; p<nW*nH; ++p)
      imgR.pixels[p] = imgIn.pixels[p]; 

    // calc and set canvas to new size based on the width of the current image    
    float ratio = float(nW)/float(nH);
    nW = w;
    nH = int( float(nW)/ratio );
    setCanvas(nW,nH,cDepth);
    clear();
    
    // resize image to canvas' size and copy values
    imgR.resize(nW,nH);
    imgR.loadPixels();
    
    for(int p=0; p<size; ++p)
      pix[p] = floor(brightness(imgR.pixels[p])*0.99999 * (cDepth));
    
    
    
    canvasToId();
    
    
    msg = "w: " + w + " h: "+h +"cDepth: " + cDepth;
  }
  
  
  
  void canvasToId()
  {
    id = bigInt(0);
    
    
    for( int p = 0; p<size; ++p )
    {
      dDigit = bigInt(cDepth).pow(p).multiply(pix[p]);
      id = id.add( dDigit );
    }
    
    //update_UI();
    
  }
  
  


  
  

  
  
  
  
  
  void setCanvas( int wIn, int hIn, int cDepthIn )
  {
    w = wIn;
    if( w < 1 )
      w = 1;
    
    h = hIn;
    if( h < 1 )
      h = 1;
    
    size = w * h;
    
    // If pix array gets bigger, fill the tail with zeros 000
    if( size > pix.length )
    {
      for(int e=pix.length; e<size; e++)
        pix.push(0);
    }
    
    if( cDepthIn != cDepth && cDepthIn > 1)
    {
      // fit color from one depth to another
      for( int p = 0; p<size; ++p )
      {
        if( isNaN(pix[p]) )
          pix[p] = 0;
        
        //pix[p] = map( pix[p], 0, cDepth, 0, cDepthIn );
        pix[p] = floor((pix[p]/cDepth) * cDepthIn + 0.5) ;
      }
      
      cDepth = cDepthIn;
    }
    
    idLimit = bigInt(cDepth).pow(w*h).subtract(1);
    
    bitmap = new PImage(w,h,RGB);
    
    
    msg = "w: " + w + " h: "+h +"cDepth: " + cDepth;
  }
  
  
  

  
  
  String estimateComputeTime()
  {
    time = bigInt(id);
    //time = time.divide(60).divide(60).divide(60).divide(24).divide(356);
    float div = 60*60*60*24*356;
    //time = time.divide(60).divide(60).divide(60).divide(24).divide(356);
    time=time.divide(div);
    return time;
    
  }
  
  
}

