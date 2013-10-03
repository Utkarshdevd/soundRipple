class Ripple
{
  PVector center;
  AudioPlayer audio;
  float spec[];
  boolean alive;
  float radius, threshold;
  
  Ripple(PVector pos, AudioPlayer aud, boolean state)
  {
    center = pos;
    audio = aud;
    alive = state;
    audio.setAnalysing(true);
    audio.setLooping(true);
    threshold = 1/100;
    colorMode(HSB, 100);
  }
  
  void setState(boolean state)
  {
    alive = state;
  }
  
  void setCenter(PVector pos)
  {
    center = pos;
  }
  
  void setSpeed(float sp)
  {
    audio.speed(sp);
  }
  
  void setVolume(float vol)
  {
    audio.volume(vol);
  }
  
  AudioPlayer getAudio()
  {
    return audio;
  }
  
  PVector getPos()
  {
    return center;
  }
  
  float getRadius()
  {
    return radius;
  }
  
  void audioPlay()
  {
    //audio.setLooping(false);
    audio.play();
  }
  
  
  void Draw()
  {
    int x = 0;
    if(alive == true)
    {
      noStroke();
      radius = 500*audio.getAveragePower();
      spec = audio.getPowerSpectrum();
      for(int i=0; i<spec.length; i++)
      {
        pushMatrix();
        translate(center.x, center.y);
        rotate(2*PI*i/spec.length);
        fill(100*i/spec.length, 100, 100);
        //fill(0);
        if(spec[i]>threshold)
        {
          rect(0,30,1, 100*spec[i]);
        }
        popMatrix();
        x++;
      }
      noFill();
      ellipse(center.x, center.y, radius, radius); 
    }
  }
  
  
}
