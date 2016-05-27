
VImage Img = new VImage(25,25,3); //(100,100,2) tooooo much

PImage[] ImgFile = new PImage[4];

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














/*
TO DO


Finish layout/graphics/fonts!?!
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
hardcode text coord?
*/
// UI button related functions

void prev()
{
  Img.offset(-Step);
  Sample = -1;
  HUI_Update = true;
}
void next()
{
  Img.offset(Step);
  Sample = -1;
  HUI_Update = true;
}




void incUp()
{
  Step = Step.multiply(2);
  HUI_Update = true;
}
void incDown()
{
  Step = Step.divide(2);
  if( Step.lesser(1) )
    Step = bigInt(1);
  HUI_Update = true;
}



void rUp()
{
  Img.setCanvas(Img.w+1, Img.h+1, Img.cDepth);
  applySample(Sample);
  HUI_Update = true;
}
void rDown()
{
  Img.setCanvas(Img.w-1, Img.h-1, Img.cDepth);
  applySample(Sample);
  HUI_Update = true;
}


void xUp()
{
  Img.setCanvas(Img.w+1, Img.h, Img.cDepth);
  applySample(Sample);
  HUI_Update = true;
}
void xDown()
{
  Img.setCanvas(Img.w-1, Img.h, Img.cDepth);
  applySample(Sample);
  HUI_Update = true;
}
  
void yUp()
{
  if( Sample > -1 )
  {
    Img.setCanvas(Img.w+1, Img.h+1, Img.cDepth);
    applySample(Sample);
  }
  else
    Img.setCanvas(Img.w, Img.h+1, Img.cDepth);
  
  HUI_Update = true;
}
void yDown()
{
  if( Sample > -1 )
  {
    Img.setCanvas(Img.w-1, Img.h-1, Img.cDepth);
    applySample(Sample);
  }
  else
    Img.setCanvas(Img.w, Img.h-1, Img.cDepth);
  
  HUI_Update = true;
}
  
void cUp()
{
  Img.setCanvas(Img.w, Img.h, Img.cDepth+1);
  applySample(Sample);
  HUI_Update = true;
}
void cDown()
{
  Img.setCanvas(Img.w, Img.h, Img.cDepth-1);
  applySample(Sample);
  HUI_Update = true;
}
  


void autoMode()
{
  AutoMode = !AutoMode;
  Sample = -1;
}

void showValues()
{
  Values = !Values;
}

void randomImg()
{
  Img.randomise();
  Sample = -1;
  HUI_Update = true;
}

void clearCanvas()
{
  Img.clear();
  Sample = -1;
  HUI_Update = true;
}

void sample(int inSample)
{
  if( Sample == inSample )
    Sample = -1;
  else
    Sample = inSample;
  
  applySample(Sample);
  HUI_Update = true;
  
}


void slider( float value)
{
  Img.setIdFromRange( value );
  HUI_Update = true;
  
  if(Sample > -1)
    Sample = -1;
}  


void setIdFromTextField( String inId )
{
  Img.setId(inId);
  Img.setPixFromId();
  HUI_Update = true;
}
  












void applySample(int sample)
{
  if( sample != -1 )
    Img.setIdFromImg(ImgFile[sample-1]);
}






/*

void popUp(String info)
{
  String hor, ver;
  if( mouseX > width/2 )
    hor = RIGHT;
  else
    hor = LEFT;
  
  if( mouseY < 20 )
    ver = TOP;
  else
    hour = BOTTOM;


  
  textAlign(hor, ver);
  textSize(16);
  fill(0);
  text( info, mouseX+1, mouseY+1 );
  fill(1);
  text( info, mouseX, mouseY );
  
}
     
*/








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
  if( f.lesser(1) )
    return( "0" );
  // f in frames
  if( f.lesser(60) )
    return( "Less than a second");
  
  
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
  



 
  void clear()
  {
    pix = new int[size];
    id = bigInt(0);
  }
  
  
  
  void randomise()
  {
    for( int p = 0; p<size; ++p )
      pix[p] = floor(random(cDepth));
    
    canvasToId();
  }
  
  
  
  
  
  // Id driven increment
  void offset(bigInt o)
  {
    id = id.add(o);
    
    // reset id if outside limit
    if( id.lesser( bigInt(0) ) )
      id = idLimit.minus( id.minus(o) );
    else if( id.greater( idLimit ) )
      id = bigInt(0).add( id.minus(idLimit) ).minus(1);
    
    setPixFromId();
  }
  
  
  
  
  
  void draw()
  {
    noStroke();
    int p=0;
    for (int y=0; y<h; y++)
      for (int x=0; x<w; x++)
      {
        color c = color(pix[p]/float(cDepth-1));
        fill(c);
        rect(x,y,1,1);
        p++;
      }
  }
  
  
  void values()
  {
    float pixelSize = 1;
    if( w>h )
      pixelSize = float(FrameSize)/float(w);
    else
      pixelSize = float(FrameSize)/float(h);
     
     
    textSize(pixelSize * 0.5);
    textAlign(RIGHT, BOTTOM);
    fill(color(0.9,0.5,0.4));
    
    
    int p=0;
    for (int y=0; y<h; y++)
      for (int x=0; x<w; x++)
      {
        text(pix[p], x*pixelSize+pixelSize-pixelSize*0.1, y*pixelSize+pixelSize);
        
        p++;
      }
    
  }
  
  
  void drawBitmap()
  {
    for( int p = 0; p<size; ++p )
      bitmap.pixels[p] = color(pix[p]/float(cDepth-1));
    
    image(bitmap,0,0);
  }
  
  





  String getId()
  {
    return id.toString();
  } 
  
  
  float getFraction()
  {
    bigInt mil = bigInt(id.multiply(1000000)).divide(idLimit.multiply(1));
    float fraction = mil.toString();
    fraction /= 1000000.0;
    return fraction;
  }
  
  
  void setId(String idIn)
  {
    clear();
    id = bigInt(idIn);
  }
  
  
  
  
  
  void setPixFromId()
  {
    // Reset pixels
    pix = new int[size];
    
    // generate a string with the pixel values by converting to a base of cDepth
    // numbers 10 to 35 are letters
    // numbers higher than 35 are like <65>
    String idBaseConvert = bigInt(id).toString(cDepth);
    
    
    // temp array to hold the pixel values in reverse order.
    float[] pix2 = {};
    
    // iterator
    int p = 0;
    
    // Go through the characters of the string
    for(int i=0; i<idBaseConvert.length(); i++)
    {
      // if the number is smaller than 36
      if( idBaseConvert[i] != "<" )
      {
        pix2[p++] = float( bigInt(idBaseConvert[i], cDepth).toString() );
      }
      else
      {
        // skip the bracket
        i++;
        String tmp = "";
        // keep collecting numbers until you hit the end bracket
        while( idBaseConvert[i] != ">" )
         tmp += idBaseConvert[i++];
        
        // add the value to the reveresed array
        pix2[p++] = float(tmp);
        
      }
    }
    
    
    // copy to the pixel array, in reverse order
    p = 0;
    for( i = pix2.length-1; i>=0; i-- )
      pix[p++] = pix2[i];
    
    
    //// 4 hours to fix this function FOR FUCK SHAKE IT HELL!!!!!
  }
  
  
  
  
  
  
  
  
  void setIdFromRange( float v )
  {
    bigInt newId = idLimit;
    // multiple/divide with a million for int
    v *= 1000000;
    newId = newId.multiply(int(v));
    newId = newId.divide(1000000);
    id = newId;
    setPixFromId();
  }
  
  
  
  void setIdFromImg(PImage imgIn)
  {
    // make a copy of the input image, to resize without loss of information
    int nW = imgIn.width;
    int nH = imgIn.height;
    PImage imgR = new PImage(nW,nH);
    
    for(int p=0; p<nW*nH; ++p)
      imgR.pixels[p] = imgIn.pixels[p]; 

    // calc and set canvas to new size based on width of the current image
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
  }
  
  
  
  void canvasToId()
  {
    id = bigInt(0);
    
    for( int p = 0; p<size; ++p )
    {
      dDigit = bigInt(cDepth).pow(p).multiply(pix[p]);
      id = id.add( dDigit );
    }
  }
  
  


  
  
  
  
  
  void setCanvas( int wIn, int hIn, int cDepthIn )
  {
    // Set and limit new inputs
    w = wIn;
    if( w < 1 )
      w = 1;
    h = hIn;
    if( h < 1 )
      h = 1;
    cDepth = cDepthIn;
    if( cDepth < 2 )
      cDepth = 2;
    
    // Set Img attributes
    size = w * h;
    idLimit = bigInt(cDepth).pow(w*h).subtract(1);
    
    // Reset pixel array, first set pixels from id, then back to id to clamp values and pixels. Then update UI
    pix = new int[size];
    setPixFromId();
    canvasToId();
    HUI_updateId(id);
    
    // Reset bitmat as well
    bitmap = new PImage(w,h,RGB);
  }
  
  
  
  
}

