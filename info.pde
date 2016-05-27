class Info
{
  int x, y, sx, sy;
  
  boolean over = false;
  boolean popUp = false;
  int overTime;
  
  String label;
  String info;
  String align;

  Info(String ilabel, int ix, int iy, int isx, int isy, String iinfo, String ialign)
  {
    label = ilabel;
    info = iinfo;
    align = ialign;
    x = ix;
    y = iy;
    sx = isx;
    sy = isy;
    overTime = -1;
  }


  boolean isOver() 
  {
    if ( MouseOver && mouseX >= x && mouseX <= x+sx && mouseY >= y && mouseY <= y+sy)
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
  
  
  
  void update()
  {
    boolean pOver = over;
    isOver();
    
    // first frame over
    if( !pOver && over )
      overTime = millis();
    
    // last frame over
    if( pOver && !over )
      overTime = -1;
      
    if( over && millis() - overTime > 500 )
      popUp = true;
    else
      popUp = false;
  }
  
  
  
  void draw()
  {
    // Draw label
    textSize(14);
    textAlign(align);
    text( label, 5, height-25);
  }
  
  
}


