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
  
  
  
  
  

  
  
  
  // Id driven increment
  void offset(bigInt o)
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
  
  
  void overlay()
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
    msg = idBaseConvert;
    
    
    id = bigInt(idBaseConvert, depth);
    /*
    for(int i=0; i<idBaseConvert.length(); i++)
    {
      int dInv = idBaseConvert.length()-i-1;
      
      if( idBaseConvert[i] != "<" )
      {
        pix[dInv] = bigInt(idBaseConvert[i], depth);
      }
      else
      {
        i++;
        String tmp = "";
        while( idBaseConvert[i] != ">" )
         tmp += aa[i++];
        
        pix[dInv] = tmp;
      }
    }
    */
    
    
    id = bigInt(idBaseConvert, depth);
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
    
    
    //msg = "w: " + w + " h: "+h +"cDepth: " + cDepth;
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
    
    
    //msg = "w: " + w + " h: "+h +"cDepth: " + cDepth;
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
