class Slider
{
  int x, y, sx, sy;
  float v, vLast;
  Button b;
  
  boolean over = false;
  boolean down = false;
  boolean click = false;
  int timer;
  
  boolean changed = false;
  
  int bs = 10;
  
  Slider( int ix, int iy, int isx, int isy )
  {
    x = ix;
    y = iy;
    sx = isx;
    sy = isy;
    
    v = 0;
    vLast = 0;
    timer = -1;
    
    
    b = new Button("", false, x, y, bs*2, sy, color(0.1), color(0.2), color(0.3));
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
  }
  
  
  
  void update() 
  {
    // Check button
    b.update();
    changed = false;
    if(b.down)
    {
      v = ( map( mouseX, x+bs, x+sx-bs, 0, 1) );
      if(v<0) v=0;
      if(v>1) v=1;
      
      if( v != vLast )
      {
        changed = true;
        vLast = v;
      }
      else
        changed = false;
      
    }
    
    
    
    // press on the side
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

    if( click )
    {
      if( mouseX < b.x )
      {
        v -= 1.0/(sx-2*bs) ;
        changed = true;
      }
      else if( mouseX > b.x+b.sx )
      {
        v += 1.0/(sx-2*bs) ;
        changed = true;
      }
    }
    
    
    
    
    
    
    
    // move slider
    b.x = map( v, 0,1, x, x+sx-2*bs );
  }
  
  
  void draw() 
  {
    color c = color(0.5,0.5,0.5);

 
    
    noFill();
    stroke(0.2);
    strokeWeight(0.5);
    rect(x, y, sx, sy);
    
    strokeWeight(3);
    stroke(0.1);
    line(x+bs, y+sy/2.0, x+sx-bs, y+sy/2.0);
    b.draw();
    
    
    // DEBUG
    /*
    fill(0.8);
    textAlign(LEFT, TOP);
    textSize(14);
    text(v, b.x, y);
    textAlign(LEFT, BOTTOM);
    text(changed, x, y+sy);
    
    text(over, x+100, y+20);
    text(down, x+150, y+20);
    text(click, x+200, y+20);
    */
  }
  
}
