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
  HUI_Update = true;
}

void showValues()
{
  Values = !Values;
  HUI_Update = true;
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






