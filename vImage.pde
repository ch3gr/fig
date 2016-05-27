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
