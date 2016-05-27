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
    updateUI();
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
    updateUI();
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
  void step()
  {
    id = id.add(1);
    setId(id, cDepth);
    updateUI();
  }
  
  
  
  
  
  void draw(boolean overlay)
  {
    noStroke();
    int p=0;
    for (int y=0; y<h; y++)
      for (int x=0; x<w; x++)
      {
        color c = color(pix[p] / float(cDepth-1));
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
      bitmap.pixels[p] = color(pix[p]/cDepth);
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
    // clear pixels
    for(int p=0; p<size; p++)
      pix[p] = 0;
    
    
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
    
    updateUI();
    
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
    PImage imgR = new PImage(imgIn.width, imgIn.height);
    for(int p=0; p<imgR.width*imgR.height; ++p)
      imgR.pixels[p] = imgIn.pixels[p]; 
    
    imgR.resize(w,h);
    imgR.loadPixels();
    
    for(int p=0; p<size; ++p)
      pix[p] = floor(brightness(imgR.pixels[p]) * (cDepth));
    
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
    
    updateUI();
  }
  
  
  void updateUI()
  {
    // integer that holds id/idLimit * 1000000
    bigInt mil = bigInt(id.multiply(1000000)).divide(idLimit.multiply(1));
    
    //float portion = float(mil.toString());
    float portion = mil.toString();
    portion /= 1000000.0;
    
    msg = portion;
    if(javascript!=null)
      javascript.UI_updateId(id.toString(), portion);

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

