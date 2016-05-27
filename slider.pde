class Slider
{
  int x, y, sx, sy;
  float v;
  Button b;
  int bx;
  int bs = 5;
  
  Slider( int ix, int iy, int isx, int isy )
  {
    x = ix;
    y = iy;
    sx = isx;
    sy = isy;
    
    v = 0;
    
    bx = x+bs;
    b = new Button("", false, x, y, bs*2, sy, color(0.1), color(0.2), color(0.3));
  }
  
  
  void update() 
  {
    b.update();
    if(b.down)
    {
      bx = mouseX;
      
      
      v = map( bx, x+bs, x+sx-bs, 0, 1);
    }
    
    bx = map( v, 0,1, x+bs, x+sx-bs );
    b.x = bx - bs;
    
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
    line(x+5, y+sy/2.0, x+sx-5, y+sy/2.0);
    b.draw();
    
    fill(0.8);
    textAlign(LEFT, TOP);
    textSize(14);
    text(v, x, y);
    
  }
  
}
