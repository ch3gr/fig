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
    javascript.HUI_updateId(Img.id.toString(), portion);

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
  
  //if( UI_Common.get("explore").click )
  //  Explore = !Explore;
  
  if( UI_Common.get("about").click )
    Img.offset(Step);

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
    Img.offset(Step);
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
  text( Step, xc, yc);
  
  yc = ((UI_Explore.get("xUp").y + UI_Explore.get("xUp").sy/2) + (UI_Explore.get("xDown").y + UI_Explore.get("xDown").sy/2))/2;
  xc = (UI_Explore.get("xUp").x + UI_Explore.get("xUp").sx/2);
  text( Img.w, xc, yc);
  xc = (UI_Explore.get("yUp").x + UI_Explore.get("yUp").sx/2);
  text( Img.h, xc, yc);
  xc = (UI_Explore.get("cUp").x + UI_Explore.get("cUp").sx/2);
  text( Img.cDepth, xc, yc);
  
  xc = UI_Explore.get("auto").x;
  yc = height/2;
  textSize(14);
  textAlign(LEFT, BOTTOM);
  text( ("limit: "+ Img.idLimit), xc, yc);
  
  
  text( "Start: "+ duration(Img.id), xc, yc+20);
  text( "End  : "+ duration(Img.idLimit.minus(Img.id)), xc, yc+40);
  
  
  
  
  ////////////////////////////////////////////////////
  // Button actions
  
  if( UI_Explore.get("prev").click )
    Img.offset(-Step);
  if( UI_Explore.get("next").click )
    Img.offset(Step);
  if( UI_Explore.get("incUp").click )
  {
    Step *= 2;
  }
  if( UI_Explore.get("incDown").click )
  {
    Step /= 2;
    if( Step<1 )
      Step = 1;
  }
  
  if( UI_Explore.get("xUp").click )
    Img.setCanvas(Img.w+1, Img.h, Img.cDepth);
  if( UI_Explore.get("xDown").click )
    Img.setCanvas(Img.w-1, Img.h, Img.cDepth);
    
  if( UI_Explore.get("yUp").click )
    Img.setCanvas(Img.w, Img.h+1, Img.cDepth);
  if( UI_Explore.get("yDown").click )
    Img.setCanvas(Img.w, Img.h-1, Img.cDepth);
    
  if( UI_Explore.get("cUp").click )
    Img.setCanvas(Img.w, Img.h, Img.cDepth+1);
  if( UI_Explore.get("cDown").click )
    Img.setCanvas(Img.w, Img.h, Img.cDepth-1);
    
  if( UI_Explore.get("auto").click )
    Img.offset(Step);
  
  if( UI_Explore.get("random").click )
    Img.randomise();
  if( UI_Explore.get("clear").click )
    Img.clear();
    
  if( UI_Explore.get("samples").click )  
    ImgUser.setIdFromImg(ImgInput);

  if( UI_Explore.get("slider").changed )
    Img.setIdFromRange( UI_Explore.get("slider").v );
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
  if( t.lesser(10) )
  {
    if( t.lesser(2) )
      return (t.toString() + " year");
    else
      return (t.toString() + " years");
  }
  
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






