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
    
    
    javascript.HUI_updateId(id);
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
  
  boolean lastExplore = Explore;
  boolean lastAbout = About;
  
  Explore = UI_Common.get("explore").click;
  About = UI_Common.get("about").click;
  
  if( lastExplore != Explore || lastAbout != About )
    HUI_updateDivs( Explore, About );
  
    
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
  text( compact2Big(Step), xc, yc);
  
  yc = ((UI_Explore.get("xUp").y + UI_Explore.get("xUp").sy/2) + (UI_Explore.get("xDown").y + UI_Explore.get("xDown").sy/2))/2;
  xc = (UI_Explore.get("xUp").x + UI_Explore.get("xUp").sx/2);
  text( Img.w, xc, yc);
  xc = (UI_Explore.get("yUp").x + UI_Explore.get("yUp").sx/2);
  text( Img.h, xc, yc);
  xc = (UI_Explore.get("cUp").x + UI_Explore.get("cUp").sx/2);
  text( Img.cDepth, xc, yc);
  
  
  
  textSize(18);
  textAlign(LEFT, BOTTOM);
  text( compact2Big(Img.idLimit.add(1)), 735, 325);
  textAlign(RIGHT, BOTTOM);
  text( "combinations", 965, 325);
  
  
  // Slider range
  textSize(14);
  textAlign(LEFT, BOTTOM);
  text( duration(Img.id), 5, height-25);
  
  textAlign(RIGHT, BOTTOM);
  text( duration(Img.idLimit.minus(Img.id)), width-5, height-25);
  
  
  
  
  
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
  
  
  
  if( UI_Explore.get("rUp").click )
  {
    Img.setCanvas(Img.w+1, Img.h+1, Img.cDepth);
    applySample(Sample);
  }
  if( UI_Explore.get("rDown").click )
  {
    Img.setCanvas(Img.w-1, Img.h-1, Img.cDepth);
    applySample(Sample);
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
    
    if( Sample > -1 )
    {
      Img.setCanvas(Img.w+1, Img.h+1, Img.cDepth);
      applySample(Sample);
    }
    else
      Img.setCanvas(Img.w, Img.h+1, Img.cDepth);
  }
  if( UI_Explore.get("yDown").click )
  {
    if( Sample > -1 )
    {
      Img.setCanvas(Img.w-1, Img.h-1, Img.cDepth);
      applySample(Sample);
    }
    else
      Img.setCanvas(Img.w, Img.h-1, Img.cDepth);
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
    

  if( UI_Explore.get("values").click )
    Values = true;
  else
    Values = false;
  
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



String compact2Big( bigInt n )
{
  String nStr = n.toString();
  int strl = nStr.length();
  if( strl > 12 )
  {
    String out = "";
    for(int i=0; i<3; i++)
      out += nStr.charAt(i);
    
    out += "...";
    out += str(strl);
    out += "digits";
    out += "...";
    
    for(int i=strl-3; i<strl; i++)
      out += nStr.charAt(i);
    
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
      return (compact2Big(t) + " years");
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






