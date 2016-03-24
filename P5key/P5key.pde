import promidi.*;
int a = 1;
int vol = 60;
int len = 1000;
int chan = 1;
int dev = 1;
int k = 0;
int mode = 0;
void setup() {
  MidiIO midiIO = MidiIO.getInstance();
  midiIO.printDevices();
  midiIO.closeOutput(1);
  MidiOut test = midiIO.getMidiOut(chan, dev);

  size(400, 200);
  background(0);
}

void draw() {
  if (mode==0) {
    for (int i=0; i<8;i++) {
      fill(255);
      rect(width/8*i, 0, width/8, height);
    }
    fill(0);
    rect(30, 0, 40, 120);
    rect(80, 0, 40, 120);
    rect(180, 0, 40, 120);
    rect(230, 0, 40, 120);
    rect(280, 0, 40, 120);
    textSize(20);
    text("C", 20, 180);
    text("D", 70, 180);
    text("E", 120, 180);
    text("F", 170, 180);
    text("G", 220, 180);
    text("A", 270, 180);
    text("B", 320, 180);
    text("C", 370, 180);

    fill(255);
    text("C#", 35, 80);
    text("Db", 35, 100);
    text("D#", 85, 80);
    text("Eb", 85, 100);
    text("F#", 185, 80);
    text("Gb", 185, 100);
    text("G#", 235, 80);
    text("Ab", 235, 100);
    text("A#", 285, 80);
    text("Bb", 285, 100);
  }

  if (mode == 1) {
    background(255);
    fill(0);

    text("Device: "+ dev, 50, 40);
    text("Channel: "+ chan, 50, 60);
    text("ProgramChange: "+ a, 50, 80);
    text("Volume: "+ vol, 50, 100);
    text("Length: "+ len, 50, 120);
    text("Pitch: "+k, 50, 140);
  }

  if (mode == 2) {
    background(255);
    text("Device:  error", 50, 40);
    text("Channel: "+ chan, 50, 60);
    text("ProgramChange: "+ a, 50, 80);
    text("Volume: "+ vol, 50, 100);
    text("Length: "+ len, 50, 120);
    text("Pitch: "+k, 50, 140);
  }
}
void mousePressed() {

  if (mode == 0) {
    MidiIO midiIO = MidiIO.getInstance();

    MidiOut test = midiIO.getMidiOut(chan, dev);
    ProgramChange s = new ProgramChange(a);
    test.sendProgramChange(s);

    color c = get(mouseX, mouseY);
    if (red(c)==255&&mouseX<=50) {
      test.sendNote(new Note(k+36, vol, len));
    }
    else if (red(c)==255&&mouseX<=100&&mouseX>=50) {
      test.sendNote(new Note(k+38, vol, len));
    }
    else if (red(c)==255&&mouseX<=150&&mouseX>=100) {
      test.sendNote(new Note(k+40, vol, len));
    }
    else if (red(c)==255&&mouseX<=200&&mouseX>=150) {
      test.sendNote(new Note(k+41, vol, len));
    }
    else if (red(c)==255&&mouseX<=250&&mouseX>=200) {
      test.sendNote(new Note(k+43, vol, len));
    }
    else if (red(c)==255&&mouseX<=300&&mouseX>=250) {
      test.sendNote(new Note(k+45, vol, len));
    }
    else if (red(c)==255&&mouseX<=350&&mouseX>=300) {
      test.sendNote(new Note(k+47, vol, len));
    }
    else if (red(c)==255&&mouseX<=400&&mouseX>=350) {
      test.sendNote(new Note(k+48, vol, len));
    }

    if (red(c)==0&&mouseX<=70&&mouseX>=30) {
      test.sendNote(new Note(k+37, vol, len));
    }
    else if (red(c)==0&&mouseX<=120&&mouseX>=80) {
      test.sendNote(new Note(k+39, vol, len));
    }
    else if (red(c)==0&&mouseX<=220&&mouseX>=180) {
      test.sendNote(new Note(k+42, vol, len));
    }
    else if (red(c)==0&&mouseX<=270&&mouseX>=230) {
      test.sendNote(new Note(k+44, vol, len));
    }
    else if (red(c)==0&&mouseX<=320&&mouseX>=280) {
      test.sendNote(new Note(k+46, vol, len));
    }
  }
}

void keyPressed() {
  if (keyCode==UP) {
    vol++;
  }
  if (keyCode==DOWN) {
    vol--;
  }
  if (vol<=0) {
    vol=1;
  }
  else if (vol>=127) {
    vol=127;
  }

  if (keyCode==RIGHT) {
    a++;
  }
  else if (keyCode==LEFT) {
    a--;
  }
  if (a<=0) {
    a=0;
  }

  if (key == 'x') {
    len++;
  }
  else if (key == 'z') {
    len--;
  }
  if (len<=0) {
    len=0;
  }

  if (key == 'w') {
    dev++;
  }
  else if (key == 'q') {
    dev--;
  }
  if (dev<=0) {
    dev=0;
  }
  else if (dev>=1) {
    dev=1;
  }

  if (key == 's') {
    chan++;
  }
  else if (key == 'a') {
    chan--;
  }

  if (chan<=0) {
    chan=0;
  }
  else if (chan>=15) {
    chan=15;
  }

  if (key == 'v') {
    k++;
  }
  else if (key == 'c') {
    k--;
  }

  try {    
    MidiIO midiIO = MidiIO.getInstance();
    MidiOut test = midiIO.getMidiOut(chan, dev);
  }
  catch(Exception e) {
    mode=2;
    return;
  }

  if (mode==2) {
    mode = 1;
  }

  if (keyCode==ENTER) { 
    if (mode==1) {
      mode=0;
      return;
    }  
    mode++;
  }
}