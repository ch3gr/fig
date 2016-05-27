//  https://github.com/peterolson/BigInteger.js


// Date( year, month(0-11), date(1-31))
var RefTime = new Date(1981, 2, 18);


vImage Img ;
VImage ImgUser = new VImage(2,2,2); //(100,100,2) tooooo much
VImage ImgDate = new VImage(25,25,3);




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
  if( SinceMode )
    Img = ImgDate;
  else
    Img = ImgUser;
  
  
  text("Hello World!", 50, 50);
  
}



void draw()
{
  background(0.18);
  smooth();
  
  if( SinceMode )
    Img.shift();

  pushMatrix();
  translate(50,50);
  scale(600.0/Img.h);  //fit height in 500 pixels
  
  Img.drawBitmap();
  //Img.draw(Overlay);
  
  popMatrix();
  
  
  
  
  
  
  
  // Temp text
  
  fill(color(0.7));
  textSize(14);
  
  textSize(11);
  string t = Img.getId();
  text("id              : " +t, 10, 10);
  text("id length  : " + t.length(), 10, 20);
  text("framerate : " +floor(frameRate), 10, 30);
  text("rate : " +floor(1000.0/(millis()-Mill)), 100, 30);
  Mill = millis();
  text("input      : " +uivars.theId, 10, 40);
  
  
  text(Img.msg, 10, 665);
  text(Img.msg, 10, 675);
  text("Since :" + RefTime, 200, 40);
  
  if( LastSize != uivars.theId.length() )
  {
    LastSize = uivars.theId.length();
    Img.setId(uivars.theId, Img.cDepth);
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
    {
      Img = ImgDate;
      Img.setIdFromDate();
    }
    else
      Img = ImgUser;
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
  
  // DELETE - test class copy /////////////////////
  if(key=='t')
  {
    Img = ImgDate;
    Img.setCanvas(10, 10, 4);
  }
  if(key=='T')
  {
    Img = ImgUser;
    Img.setCanvas(40, 40, 2);
  }
  /////////////////////////////////////////////////
  
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




class VImage
{
  int cDepth;
  int w;
  int h;
  int size;
  float[] pix;
  String msg;
  
  PImage bitmap;

  
  VImage(int wIn, int hIn, int cIn)
  {
    cDepth = cIn;
    w = wIn;
    h = hIn;
    size = w * h;
    msg = "_";

    bitmap = createImage(w,h,RGB);
    
    pix = new int[size];
    
    
    
    id = bigInt(0);
    
    //randomise();
  }
 
  void clear()
  {
    for( int p = 0; p<size; ++p )
      pix[p] = 0;
    
    updateId();
  }
  
  void randomise()
  {
    for( int p = 0; p<size; ++p )
      pix[p] = floor(random(cDepth));
    
    updateId();
  }
  
  
  void shift()
  {
    id = id.add(1);
    
    pix[0] ++;
    propagate(0);
    
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
  
  
  
  
  

  void updateId()
  {
    id = bigInt(0);
    
    
    for( int p = 0; p<size; ++p )
    {
      dDigit = bigInt(cDepth).pow(p).multiply(pix[p]);
      id = id.add( dDigit );
    }
  }

  
  
  
  
  String getId()
  {
    return id.toString();
  }
  
  


  void setId(String idIn, int depth)
  {
    String idBaseConvert = bigInt(idIn).toString(depth);
    msg = idBaseConvert;
    //for(int d=idBaseConvert.length()-1; d>=0; d--)
    for(int d=0; d<idBaseConvert.length(); d++)
    {
      int dInv = idBaseConvert.length()-d-1;
      
      // the new color of the itterated digit
      dColor = bigInt(idBaseConvert[d]);
      String newColor = dColor.toString();
      
      pix[dInv] = int(newColor);
      
    }
    
    //updateId();
    id = bigInt(idBaseConvert, depth);
    
    // FIX : extra conversion to support 10+ depth
    // Warning ean kseperaseis to size
  }
  
  
  
  
  
  void setIdFromDate()
  {
    var now = new Date();
    var timeCode = now.getTime()-RefTime.getTime();
    timeCode *= 1/60.0;
    timeCode = int(timeCode);
    
    //msg = timeCode; 
    setId(timeCode, cDepth);
    
    
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
        
        pix[p] = map( pix[p], 0, cDepth, 0, cDepthIn );
      }
      
      cDepth = cDepthIn;
    }
    
    bitmap = new PImage(w,h,RGB);
    
    msg = "w: " + w + " h: "+h +"cDepth: " + cDepth;
  }
}

