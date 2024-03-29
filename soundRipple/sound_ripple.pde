import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import TUIO.*;
import java.util.*;

TuioProcessing tuioClient;

// these are some helper variables which are used
// to create scalable graphical feedback
float cursor_size = 15;
float object_size = 30;
float table_size = 760;
float scale_factor = 1;
//Minim minim;
AudioPlayer audio1;
AudioPlayer audio2;
//FFT fft;
Maxim maxim;
PVector pos, center;
Ripple ripple1, ripple2;

int start, begin;
void setup()
{
  size(640,480);
  background(255);
  frameRate(30);
  maxim = new Maxim(this);
  
  start = begin = 0;
  
  pos = new PVector(0,0);
  center = new PVector(width/2, height/2);
  
  audio1 = maxim.loadFile("beat1.wav");
  audio2 = maxim.loadFile("laser.wav");
  audio2.setAnalysing(true);
  audio1.setLooping(true);
  audio1.setAnalysing(true);
  
  ripple1 = new Ripple(center, audio1, true);
  ripple2 = new Ripple(pos, audio2, true);
  
  tuioClient  = new TuioProcessing(this);
  colorMode(HSB,100);
  //fft = new FFT(audio1.bufferSize(), audio1.sampleRate());
}

void draw()
{
  background(100);  
  strokeWeight(10);
  stroke(23,20,50,60);
  noFill();
  
  //textFont(font,18*scale_factor);
  float obj_size = object_size*scale_factor; 
  float cur_size = cursor_size*scale_factor; 
   
  Vector tuioObjectList = tuioClient.getTuioObjects();
  for (int i=0;i<tuioObjectList.size();i++) 
  {
    TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);
    stroke(0); 
    fill(0);
    pushMatrix();
    translate(tobj.getScreenX(width),tobj.getScreenY(height));
    rotate(tobj.getAngle());
    rect(-obj_size/2,-obj_size/2,obj_size,obj_size);
    popMatrix();
    fill(0);
    //pos = new PVector(tobj.getScreenX(width), tobj.getScreenY(height));
    switch(tobj.getSymbolID())
    {
      case 1:
      {
        pos = new PVector(tobj.getScreenX(width), tobj.getScreenY(height));
        ripple1.setCenter(pos);
        ripple1.setState(true);
        ripple1.Draw();
        audio1.play();
      }
    }
    text(""+tobj.getSymbolID(), tobj.getScreenX(width), tobj.getScreenY(height));
  }
   
   /*Vector tuioCursorList = tuioClient.getTuioCursors();
   for (int i=0;i<tuioCursorList.size();i++)
   {
     TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
     Vector pointList = tcur.getPath();
     
     if (pointList.size()>0)
     {
       stroke(0,0,255);
       TuioPoint start_point = (TuioPoint)pointList.firstElement();;
       for (int j=0;j<pointList.size();j++) 
       {
         TuioPoint end_point = (TuioPoint)pointList.elementAt(j);
         line(start_point.getScreenX(width),start_point.getScreenY(height),end_point.getScreenX(width),end_point.getScreenY(height));
         start_point = end_point;
       }
        
       stroke(192,192,192);
       fill(192,192,192);
       ellipse( tcur.getScreenX(width), tcur.getScreenY(height),cur_size,cur_size);
       fill(0);
       //text(""+ tcur.getCursorID(),  tcur.getScreenX(width)-5,  tcur.getScreenY(height)+5);
    }*/
}

void mousePressed()
{}

// these callback methods are called whenever a TUIO event occurs

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
}
