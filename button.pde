// Global that holds whether and which sample image is clicked 
int Sample = -1;

// Global to track if one button is pressed, to prevent more at any one time
boolean OneButtonClicked = false;

// Need this global to check if mouse is over the sketch
boolean MouseOver = true;
void mouseOver()
{
  MouseOver = true;
}
void mouseOut()
{
  MouseOver = false;
  mousePressed = false;
}



// http://processingjs.org/learning/topic/buttons/
// by Casey Reas and Ben Fry

class Button
{
  int x, y, sx, sy;
  color baseC, overC, downC;
  
  boolean over = false;
  boolean down = false;
  boolean click = false;
  boolean toggle;
  int downTime;
  int overTime;
  
  String label;
  String msg;

  Button(String ilabel, boolean itoggle, int ix, int iy, int isx, int isy)
  {
    label = ilabel;
    msg = "nothing to see here";
    x = ix;
    y = iy;
    sx = isx;
    sy = isy;
    baseC = color(0.1,0.1,0.1);
    overC = color(0.15,0.15,0.15);
    downC = color(0.8,0.8,0.8);
    toggle = itoggle;
    downTime = -1;
    overTime = -1;
  }
  
  Button(String ilabel, boolean itoggle, int ix, int iy, int isx, int isy, String imsg)
  {
    label = ilabel;
    msg = imsg;
    x = ix;
    y = iy;
    sx = isx;
    sy = isy;
    baseC = color(0.1,0.1,0.1);
    overC = color(0.15,0.15,0.15);
    downC = color(0.8,0.8,0.8);
    toggle = itoggle;
    downTime = -1;
    overTime = -1;
  }


  boolean isOver() 
  {
    if ( !OneButtonClicked && MouseOver && mouseX >= x && mouseX <= x+sx && mouseY >= y && mouseY <= y+sy)
    {
      over = true;
      return true;
    }
    else
    {
      over = false;
      return false;
    }
  }
  
  boolean isDown()
  {
    if( !down && mousePressed && over )
    {
      down = true;
      OneButtonClicked = true;
      return true;
    }
    // Keep it down even not over
    if( down && !mousePressed )
    {
      down = false;
      OneButtonClicked = false;
      return false;
    }
    
    // Auto release when not over
    /*
    else
    {
      down = false;
      return false;
    }
    */
  }
  
  
  
  
  void update() 
  {
    boolean pDown = down;
    boolean pOver = over;
    
    isOver();
    isDown();
    
    
    
    // first frame over
    if( !pOver && over )
      overTime = millis();
    
    // last frame over
    if( pOver && !over )
      overTime = -1;


    if( !toggle )
    {
      click = false;

      // first frame down
      if( !pDown && down )
      {
        click = true;
        downTime = millis();
      }
      
      // continious press
      if( downTime>-1 && millis()-downTime > 500 )
        click = true;
      
      // last frame down
      if( pDown && !down )
      {
        click = false;
        downTime = -1;
      }
      
    }
    else
    {
     if( !pDown && down )
       click = !click;
    }
    
  }
  
  
  void draw() 
  {
    color c; 
    if( down || click )
      c = downC;
    else if ( over )
      c = overC;
    else
      c = baseC;
 
    stroke(0.2,0.2,0.2);
    strokeWeight(2);
    fill(c);
    rect(x, y, sx, sy);
    
    fill(0.2,0.2,0.2);
    textSize(sy* 0.75);
    textAlign(CENTER, CENTER);
    text(label, x+sx/2, y+sy/2);
    
    // Pop up message
    if( over && millis() - overTime > 500 )
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
       
      Overlay.beginDraw();
      Overlay.textAlign(hor, ver);
      Overlay.textSize(16);
      Overlay.fill(0);
      Overlay.text( msg, mouseX+1, mouseY+1 );
      Overlay.fill(1);
      Overlay.text( msg, mouseX, mouseY );
      Overlay.endDraw();
      
    }
    
    
    // Debug info
    /*
    fill(0.8,0,0);
    textSize(10);
    textAlign(LEFT, TOP);
    text(x, x, y);
    text(down, x, y+sy/2);
    text(click, x, y+sy-10);
    text(overTime, x, y+sy/4);
    text(downTime, x+sx*0.75, y+sy/4);
    */
    
  }

}


