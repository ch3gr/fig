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
    int nW = imgIn.width;
    int nH = imgIn.height;
    PImage imgR = new PImage(nW,nH);
    
    imgIn.loadPixels();
    msg ="";
    msg += str(imgIn.width) + "  " ;
    for(int p=0; p<3; ++p)
      msg += brightness(imgIn.pixels[p]) + "   ";
    
/*    
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
      pix[p] = floor(brightness(imgR.pixels[p]) * (cDepth));
    
    
    
    canvasToId();
*/    
    
//    msg = "w: " + w + " h: "+h +"cDepth: " + cDepth;

    //msg = str(imgIn.width);
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
