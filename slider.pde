class Slider
{
  int x, y, sx, sy;
  float v, vLast;
  Button b;
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
    
    b = new Button("", false, x, y, bs*2, sy, color(0.1), color(0.2), color(0.3));
  }
  
  

  
  
  void update() 
  {
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
    text(v, x, y);
    textAlign(LEFT, BOTTOM);
    text(changed, x, y+sy);
    */
  }
  
}
