// http://processingjs.org/learning/topic/buttons/
// by Casey Reas and Ben Fry

class Button
{
  int x, y, sx, sy;
  color baseC, overC, downC;
  
  boolean over = false;
  boolean down = false;
  boolean click = false;
  int timer;
  
  String label;

  Button(String ilabel, int ix, int iy, int isx, int isy, color ibaseC, color ioverC, color idownC)
  {
    label = ilabel;
    x = ix;
    y = iy;
    sx = isx;
    sy = isy;
    baseC = ibaseC;
    overC = ioverC;
    downC = idownC;
    timer = -1;
  }


  boolean isOver() 
  {
    if (mouseX >= x && mouseX <= x+sx && mouseY >= y && mouseY <= y+sy)
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
    if( mousePressed && over )
    {
      down = true;
      return true;
    }
    else
    {
      down = false;
      return false;
    }
  }
  
  
  
  
  void update() 
  {
    boolean pDown = down;
    
    isOver();
    isDown();
    
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
  
  
  void draw() 
  {
    color c; 
    if( down )
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
    
  }

}


