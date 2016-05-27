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
    fill(color(1, 0.1, 0.1));
    
    
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
