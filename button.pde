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
  int timer;
  
  String label;

  Button(String ilabel, boolean itoggle, int ix, int iy, int isx, int isy, color ibaseC, color ioverC, color idownC)
  {
    label = ilabel;
    x = ix;
    y = iy;
    sx = isx;
    sy = isy;
    baseC = ibaseC;
    overC = ioverC;
    downC = idownC;
    toggle = itoggle;
    timer = -1;
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
    
    isOver();
    isDown();
    
    if( !toggle )
    {
      click = false;
      // first frame down
      if( !pDown && down )
      {
        click = true;
        timer = millis();
      }
      
      // continious press
      if( timer>-1 && millis()-timer > 500 )
        click = true;
      
      // last frame down
      if( pDown && !down )
      {
        click = false;
        timer = -1;
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
    
    
    
    // Debug info
    /*
    fill(0.8,0,0);
    textSize(10);
    textAlign(LEFT, TOP);
    text(over, x, y);
    text(down, x, y+sy/2);
    text(click, x, y+sy-10);
    */
  }

}


