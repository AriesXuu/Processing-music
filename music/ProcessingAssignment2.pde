import controlP5.*;
ControlP5 cp5;

PImage backgroundpic, cover, sadsong, happy, dance;

boolean showDataButton1 = false;
boolean showDataButton2 = false;
boolean showDataButton3 = false;
boolean controlButton = false;

String text_danceability, text_happyval, text_sadval;
float float_danceability, float_happyval, float_sadval;
Valence[] valenceList;
Val [] valList;
Dance [] danceList;

FilterValence filter;

JSONArray values;
String [] danceArray = new String[60];
String [] songname;
float [] dancetempo;
String s1, s3, s4, s5;
String musicDataFile = "NOW-US-1-61.json";
String fromFile;

Val [] createVal(String fromFile){
  fill(255);
  noStroke();
  rect(330, 250, 235, 445);
  text_sadval = cp5.get(Textfield.class, "Sadvalence").getText();
  float_sadval = float(text_sadval);
  JSONArray values = loadJSONArray(fromFile);
  int controlPrint = 250;
  for (int i = 0; i < values.size(); i++){
    JSONObject album = values.getJSONObject(i);
    
    JSONArray tracks = album.getJSONArray("tracks");
    songname = tracks.getStringArray();
    
    JSONArray valence = album.getJSONArray("valence");
    float [] valenceNum = valence.getFloatArray();
    
    for (int j = 0; j <songname.length; j++){
      if( valenceNum[j] < float_sadval && valenceNum[j] > 0 ) {
        s5 = songname[j] +" "+valenceNum[j];
        fill(0);
        text(s5, 445, controlPrint += 20);
      }
    }
  }
  return valList;
}

Valence [] createValence(String fromFile){
  fill(255);
  noStroke();
  rect(585, 250, 235, 445);
  text_happyval = cp5.get(Textfield.class, "Happyvalence").getText();
  float_happyval = float(text_happyval);
  JSONArray values = loadJSONArray(fromFile);
  int controlPrint = 250;
  for (int i = 0; i < values.size(); i++){
    JSONObject album = values.getJSONObject(i);
    
    JSONArray tracks = album.getJSONArray("tracks");
    songname = tracks.getStringArray();
    
    JSONArray valence = album.getJSONArray("valence");
    float [] valenceNum = valence.getFloatArray();

    for (int j = 0; j < songname.length; j++) {
      if (valenceNum[j] > float_happyval) {
        s4 = songname[j] +" "+ valenceNum[j];
        fill(0);
        text(s4, 705, controlPrint += 20);
      }
    }
  }
  return valenceList;
}


Dance [] createDance(String fromFile){
  fill(255);
  noStroke();
  rect(840, 250, 235, 445);
  text_danceability = cp5.get(Textfield.class, "Danceability").getText();
  float_danceability = float(text_danceability);
  JSONArray values = loadJSONArray(fromFile);
    int controlPrint = 250;
    for (int i = 0; i < values.size(); i++) {
    JSONObject album = values.getJSONObject(i);
   
    JSONArray tracks = album.getJSONArray("tracks");
    songname = tracks.getStringArray();
   
    JSONArray danceability = album.getJSONArray("danceability");
    dancetempo = danceability.getFloatArray();
    
    for (int l = 0; l < songname.length; l++) {
      if (dancetempo[l] > float_danceability) {
        s3 = songname[l] +" "+ dancetempo[l];
        fill(0);
        text(s3, 955 ,  controlPrint+= 20);
      }
    }
  }
  return danceList;
}


void setup() {
  cp5 = new ControlP5(this);
  
  backgroundpic = loadImage("image3.jpg");
  cover = loadImage("cover.jpg");
  sadsong = loadImage("sadsong.jpg");
  happy = loadImage("happy.jpg");
  dance = loadImage("dance.jpg");

  filter = new FilterValence(110,600);
  
  size (1131, 707);
  PFont font = createFont("Verdana", 10);

  cp5.addButton("RandomRecommend")
    .setPosition(80, 210)         
    .setFont(font)
    .setSize(113, 20);

  cp5.addButton("SadSong")
    .setPosition(355, 210)         
    .setFont(font)
    .setSize(100, 20);

  cp5.addButton("HappySong")
    .setPosition(608, 210)         
    .setFont(font)
    .setSize(100, 20);

  cp5.addButton("DanceSong")
    .setPosition(866, 210)         
    .setFont(font)
    .setSize(100, 20);
  
  cp5.addTextfield("Danceability")
     .setPosition(960,210)
     .setSize(90,20)
     .setFont(font)
     .setFocus(true)
     .setColorBackground(color(255))
     .setColorActive(color(0)) 
     .setColorValueLabel(color(0))
     .setColorForeground(color(255)) 
     .setColorCaptionLabel(color(0))
     ;
  
  cp5.addTextfield("Happyvalence")
     .setPosition(708,210)
     .setSize(90,20)
     .setFont(font)
     .setFocus(true)
     .setColorBackground(color(255))
     .setColorActive(color(0)) 
     .setColorValueLabel(color(0))
     .setColorForeground(color(255)) 
     .setColorCaptionLabel(color(0))
     ;
     
  cp5.addTextfield("Sadvalence")
     .setPosition(455,210)
     .setSize(90,20)
     .setFont(font)
     .setFocus(true)
     .setColorBackground(color(255))
     .setColorActive(color(0)) 
     .setColorValueLabel(color(0))
     .setColorForeground(color(255)) 
     .setColorCaptionLabel(color(0))
     ;
  
}

void draw() {
  background(backgroundpic);
  fill(0);

  image(cover, 80, 30);
  image(sadsong, 350, 30);
  image(happy, 603, 30);
  image(dance, 856, 30);
  
  if (showDataButton1 == true){
    danceList = createDance(musicDataFile);
  }
  
  if (showDataButton2 == true){
    valenceList = createValence(musicDataFile);
  }
  
  if (showDataButton3 == true){
    valList = createVal(musicDataFile);
  }
  
  if (controlButton == true){
    drawInformation(60, 260);
  }
    
   filter.draw();
}

void RandomRecommend(){
  controlButton = true;
  
}

void mousePressed() {
  filter.modifyRange();
}
  
void SadSong() {
  showDataButton3 = true;
}

void HappySong() {
  showDataButton2 = true;
}

void DanceSong() {
  showDataButton1 = true;
}

void drawInformation(float x, float y) {
  values = loadJSONArray("NOW-US-1-61.json");
  
  for (int i = 0; i < 60; i++){
    float r = random(0, 59);
    int newr = int(r);
    JSONObject album = values.getJSONObject(newr);
    
    String [] tracks = album.getJSONArray("tracks").getStringArray();
    
    JSONArray artists = album.getJSONArray("artists");
    String [] artistsName = artists.getStringArray();
    
    JSONArray danceability = album.getJSONArray("danceability");
    dancetempo = danceability.getFloatArray();
    
    JSONArray valence = album.getJSONArray("valence");
    float [] valenceNum = valence.getFloatArray();
    
    JSONArray tempo = album.getJSONArray("tempo");
    float [] tempoNum = tempo.getFloatArray();
   
    for(int j =0; j < 60; j++){
    rectMode(CORNER);    
    textAlign(LEFT, TOP);
    float k = random(0,16);
    int newk = int(k);
    String s1 = " Song: " + tracks[newk];
    String s2 = " Singer: " + artistsName[newk];
    String s3 = " Tempo: " +tempoNum[newk];
    String s4 = " Valence: " +valenceNum[newk];
    String s5 = " Danceability: " +dancetempo[newk];
    fill(255);
    noStroke();
    rect(x, y + 20, 250, 200);
    fill(0);
    text(s1, x + 5, y + 25, 210, 60);
    text(s2, x + 5, y + 70, 210, 60);
    text(s3, x + 5, y + 115, 210, 60);
    text(s4, x + 5, y + 140, 210, 60);
    text(s5, x + 5, y + 165, 210, 60);
    }
  }
}  
    
  
  