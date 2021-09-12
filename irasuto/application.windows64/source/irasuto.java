import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class irasuto extends PApplet {



Timecount timecount;

PImage background;
PImage tomato2;
PImage logo;
PImage mode;
PImage return_title;
PImage kanban;
PImage revel;
PImage revel2;
PImage karuta;
PImage [] img = new PImage[19];
String [] odai = new String[19];
PImage backButton;

int timemode = 1, tmode;
int state, a, b, c, d;
int rectX = 200;
int rectY = 100;
int x, iy = 0;
boolean gameclick3 = false;
boolean gameclick4 = false;


//カルタの変数

PImage img1;
String path[] = {"ゴーヤ.png","imo.png","kabu.png","melo.png","nas.png",
                 "onion.png","papu.png","take.png","tomato1.png","pi.png"};
String savefile = "data/score.txt";
Minim minim;
AudioSnippet correctSnd;
AudioSnippet wrongSnd;
int correctNum = 0;
int wrongNum = 0;
float endTime;
int cur = 0;
boolean ready = false;
int baseTime = 0;
final int SCORE_NUMBER = 5;
final int CARD_NUMBER = 10;
boolean gamemode1 = false;
Card card[] = new Card [CARD_NUMBER];
Vegetable vegetable[] = new Vegetable[18];

public void setup() {

  
  shuffle(path);
  minim = new Minim(this);
  correctSnd = minim.loadSnippet("sound/Quiz-Correct_Answer02-1.mp3");
  wrongSnd = minim.loadSnippet("sound/Quiz-Wrong_Buzzer02-3.mp3");
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  
  
  shuffle(path);
  

  timecount = new Timecount();
  state = 0;
  textSize(32);
  textAlign(CENTER);
  rectMode(CENTER);

  fill(255);

  background = loadImage("sogen.jpeg");
  tomato2 = loadImage("vegetable/tomato2.png");
  logo = loadImage("logo.PNG");
  mode = loadImage("mode.PNG");
  return_title = loadImage("return.PNG");
  kanban = loadImage("kanban.png");
  revel = loadImage("revel.PNG");
  revel2 = loadImage("vege_mode.PNG");
  karuta = loadImage("karuta.png");
  backButton = loadImage("back.png");
  backButton.resize(backButton.width/3, backButton.height/3);

  img[0] = loadImage("vegetable/cabbage.png");
  img[1] = loadImage("vegetable/carrot.png");
  img[2] = loadImage("vegetable/corn.png");
  img[3] = loadImage("vegetable/daikon.png");
  img[4] = loadImage("vegetable/gobou.png");
  img[5] = loadImage("vegetable/kabocha.png");
  img[6] = loadImage("vegetable/lettuce.png");
  img[7] = loadImage("vegetable/nasu.png");
  img[8] = loadImage("vegetable/negi.png");
  img[9] = loadImage("vegetable/paprika.png");
  img[10] = loadImage("vegetable/piman.png");
  img[11] = loadImage("vegetable/potato.png");
  img[12] = loadImage("vegetable/renkon.png");
  img[13] = loadImage("vegetable/satsumaimo.png");
  img[14] = loadImage("vegetable/shiitake.png");
  img[15] = loadImage("vegetable/shimeji.png");
  img[16] = loadImage("vegetable/tamanegi.png");
  img[17] = loadImage("vegetable/tomato.png");
  img[18] = loadImage("vegetable/kyuuri.png");

  odai[0] = "キャベツ";
  odai[1] = "にんじん";
  odai[2] = "とうもろこし";
  odai[3] = "だいこん";
  odai[4] = "ごぼう";
  odai[5] = "かぼちゃ";
  odai[6] = "レタス";
  odai[7] = "なす";
  odai[8] = "ねぎ";
  odai[9] = "パプリカ";
  odai[10] = "ピーマン";
  odai[11] = "じゃがいも";
  odai[12] = "れんこん";
  odai[13] = "さつまいも";
  odai[14] = "しいたけ";
  odai[15] = "しめじ";
  odai[16] = "たまねぎ";
  odai[17] = "トマト";
  odai[18] = "きゅうり";
  
  for(int i = 0; i < 18; i++) {
    vegetable[i] = new Vegetable(odai[i], img[i]);
  }
  
  shuffleVegetable(vegetable);
  
  int idx = 0;
  for(int i = 0; i < 2; i++) {
    for(int j = 0; j < 5; j++) {
      if(idx == 0) {
        card[0] = new Card(25, 20, vegetable[idx]);
      } else {
        card[idx] = new Card(j*(card[idx-1].karuta.width + 35) + 25, i*(card[idx-1].karuta.height + 10) + 20,vegetable[idx]);
      }
      idx ++;
    }
  }
  
  shuffleCard(card);

}

public void draw() {
  PFont font = createFont("HiraMaruProN-W4", 64, true);
  textFont(font);

  int nextState = 0;
  if (state == 0) {
    nextState = gameTitle();
  } else if (state == 1) {
    nextState = gameMode();
  } else if (state == 3) {
    nextState = gameSelect();
  } else if(state == 4){
    nextState = gameKaruta();
  } else if (state == 10) {
    nextState = gamePile0();
  } else if (state == 11) {
    nextState = gamePile0_answer();
  } else if (state == 20) {
    nextState = gamePile1();
  } else if (state == 21) {
    nextState = gamePile1_answer();
  } else if (state == 2) {
    nextState = ending();
  } else if(state == 33) {
    nextState = karutaMode();
  }
  state = nextState;
}



public int gameTitle() {
  tint(255, 255);
  background.resize(width, height);
  background(background);
  tomato2.resize(width/3, 0);
  img[0].resize(width/3, 0);
  img[2].resize(0, width/3);
  logo.resize(width/2, 0);
  image(tomato2, width*0.04f, height*0.2f);
  image(img[0], width*0.65f, height*0.05f);
  image(img[2], width*0.7f, height*0.2f);
  image(logo, width/4, height*0.2f);


  noStroke();
  fill(0, 82);
  rect(width/2, height*0.7f, width, height*0.2f);

  stroke(0xffcd853f);
  strokeWeight(6);
  fill(0xffffa500);
  rect(width/2, height*0.7f, rectX, height*0.16f, 30);

  fill(0xff800000);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("スタート", width/2, height*0.7f, width/3, height*0.16f);
  fill(255);
  textSize(49);
  text("スタート", width/2, height*0.7f, width/3, height*0.16f);

  if (mousePressed == true) {
    if (width/2-rectX/2  < mouseX && mouseX < width/2+rectX/2 && height*0.7f-height*0.08f < mouseY && mouseY < height*0.7f+height*0.08f) {
      
      return 1;
    }
  }

  return 0;
}

public int karutaResult() {
  background(0xff33ff99);

  fill(0, 126);
  noStroke();
  rect(width*7/8+10, height*0.9f+10, rectX*0.8f, rectY*0.8f, 20);
  fill(0xffF5A1EF);
  stroke(0);
  rect(width*7/8, height*0.9f, rectX*0.8f, rectY*0.8f, 20);
  textSize(50);
  fill(0);
  text("次へ", width*7/8, height*0.9f);

  noStroke();
  fill(0);

  tint(255, 255);
  kanban.resize(width*6/7, 0);
  println(kanban.height, kanban.width);
  image(kanban, width*4/45, rectY/10);

  /*fill(0);
  textSize(50);
  text("答え．", width/2, height*0.3);
  textSize(30);
  text(odai[a], width*0.2, height/2);
  text(odai[b], width*0.4, height/2);
  text(odai[c], width*0.6, height/2);
  text(odai[d], width*0.8, height/2);

  img[a].resize(width/7, 0);
  img[b].resize(width/7, 0);
  img[c].resize(width/7, 0);
  img[d].resize(width/7, 0);
  image(img[a], width*0.15, height/2+30);
  image(img[b], width*0.35, height/2+30);
  image(img[c], width*0.55, height/2+30);
  image(img[d], width*0.75, height/2+30);*/

  if (mousePressed == true) {
    if (width*7/8-rectX*0.4f < mouseX && mouseX < width*7/8+rectX*0.4f && height*0.9f-rectY*0.4f < mouseY && mouseY < height*0.9f+rectY*0.4f) {
      return 2;
    }
  }

  return 21;
}

public int karutaMode() {
  
  background(0xffF5A1B4);
  tint(255, 255);
  revel2.resize(width*14/15, 0);
  image(revel2, width/30, height/6);
  
  //戻るボタン
  image(backButton, 10, 10);
  if(mouseX >= 10 && mouseX <= 10 + backButton.width &&
  mouseY >= 10 && mouseY <= 10 + backButton.height && mousePressed) {
    return 1;
  }
  
  
  strokeWeight(2);
  stroke(0xff666666);
  fill(255);
  ellipse(width*2/9, height*3/4, rectX, rectX);
  ellipse(width*7/9, height*3/4, rectX, rectX);
  
  
  if (dist(width*2/9, height*3/4, mouseX, mouseY) <= rectX/2) {
    noStroke();
    fill(0, 126);
    ellipse(width*2/9+10, height*3/4+10, rectX, rectX);
    fill(255);
    strokeWeight(8);
    stroke(0xffec6d71);
    ellipse(width*2/9, height*3/4, rectX, rectX);
  } else if (dist(width*7/9, height*3/4, mouseX, mouseY) <= rectX/2) {
    noStroke();
    fill(0, 126);
    ellipse(width*7/9+10, height*3/4+10, rectX, rectX);
    fill(255);
    strokeWeight(8);
    stroke(0xffec6d71);
    ellipse(width*7/9, height*3/4, rectX, rectX);
  }

  fill(0);
  textSize(40);
  text("やさいの\nなまえ", width*2/9, height*3/4);
  text("やさいの\nせつめい", width*7/9, height*3/4);

  
  if(mousePressed == true && dist(width*2/9, height*3/4, mouseX, mouseY) <= rectX/2){
    
    return 4;
  }
  
  if(mousePressed == true && dist(width*7/9, height*3/4, mouseX, mouseY) <= rectX/2){
    
    return 4;
  }

  return 33;
}

public int gameMode() {

  background(0xff9BF0B2);
  mode.resize(0, height/4);
  image(mode, width/6, height/5);

  fill(0, 126);
  noStroke();
  rect(width*5/18+10, height*0.6f+10, rectX, rectY, 20);
  rect(width/2-rectX+10, height*0.8f+10, rectX, rectY, 20);

  fill(0xffFFA59D);
  stroke(0xffdda0dd);
  rect(width*5/18, height*0.6f, rectX, rectY, 20);
  rect(width/2-rectX, height*0.8f, rectX, rectY, 20);

  fill(0);
  textSize(48);
  text("かるた", width*5/18, height*0.6f);
  text("かさねえ", width/2-rectX, height*0.8f);
  
  if (width/2-rectX*3/2< mouseX && mouseX < width/2+rectX*3/2 && height*0.6f-rectY/2 < mouseY && mouseY < height*0.6f+rectY/2) {
    fill(0xffFFA59D);
    triangle(width/2-rectX*2/5,height*0.6f,width/2-rectX/4+10,height*0.53f,width/2-rectX/4+10,height*0.67f);
    
  }
  
  if(width/2-rectX*3/2< mouseX && mouseX < width/2-rectX/2 && height*0.8f-rectY/2 < mouseY && mouseY < height*0.8f+rectY/2){
    fill(0xffFFA59D);
    triangle(width/2-rectX*2/5,height*0.8f,width/2-rectX/4+10,height*0.73f,width/2-rectX/4+10,height*0.87f);
  }


    if (gameclick4) {
      gameclick4 = false;
      gamemode1 = true;
      return 33;
    }
    
    
    
    if(gameclick3) {
      gameclick3  = false;
      return 3;
    }


  
  return 1;
}

public int gameKaruta(){
  background(255);
 

  int time = millis() - baseTime;
  println(card.length);
  if(cur < CARD_NUMBER) { 
    for(int i = 0; i < CARD_NUMBER; i++) {
      
      if(mouseX >= card[i].x && mouseX <= card[i].x + card[i].karuta.width
    && mouseY >= card[i].y && mouseY <= card[i].y + card[i].karuta.height && card[i].isShow == true && gamemode1) {
      
      noStroke();
      fill(0, 126);
      rect(PApplet.parseFloat(card[i].x)+10, PApplet.parseFloat(card[i].y)+10, PApplet.parseFloat(karuta.width), PApplet.parseFloat(karuta.height));
      fill(255);
      strokeWeight(9);
      stroke(0xffec6d71);
      rect(PApplet.parseFloat(card[i].x), PApplet.parseFloat(card[i].y), PApplet.parseFloat(karuta.width), PApplet.parseFloat(karuta.height));
      
      }
      println(CARD_NUMBER);
      card[i].display();
  }
  

  rectMode(CORNER);
  fill(255);
  strokeWeight(5);
  rect(25, 450, 850, 140);
  
  fill(0);
  textAlign(CORNER);
  textSize(32);
  text(card[cur].vegetable.name,30, 500, 200, 200); 
  text(str(time/1000), 250, 500, 200, 200);
  } else {
    
    //終了とリザルト画面
    fill(0);
    textSize(32);
    text("FINISH",30, 500, 200, 200);
    text(str(endTime), 150, 500, 200, 200);
    
    //スコア画面
    displayScore();
    
  }
  
  
  return 4;
}

public int gameSelect() {
  background(0xffF5A1B4);
  tint(255, 255);
  revel.resize(width*14/15, 0);
  image(revel, width/30, height/6);
  
    //戻るボタン
  image(backButton, 10, 10);
  if(mouseX >= 10 && mouseX <= 10 + backButton.width &&
  mouseY >= 10 && mouseY <= 10 + backButton.height && mousePressed) {
    return 1;
  }

  strokeWeight(2);
  stroke(0xff666666);
  fill(255);
  ellipse(width*2/9, height*3/4, rectX, rectX);
  ellipse(width*7/9, height*3/4, rectX, rectX);

  if (dist(width*2/9, height*3/4, mouseX, mouseY) <= rectX/2) {
    noStroke();
    fill(0, 126);
    ellipse(width*2/9+10, height*3/4+10, rectX, rectX);
    fill(255);
    strokeWeight(8);
    stroke(0xffec6d71);
    ellipse(width*2/9, height*3/4, rectX, rectX);
  } else if (dist(width*7/9, height*3/4, mouseX, mouseY) <= rectX/2) {
    noStroke();
    fill(0, 126);
    ellipse(width*7/9+10, height*3/4+10, rectX, rectX);
    fill(255);
    strokeWeight(8);
    stroke(0xffec6d71);
    ellipse(width*7/9, height*3/4, rectX, rectX);
  }

  fill(0);
  textSize(40);
  text("やさしい", width*2/9, height*3/4);
  text("むずかしい", width*7/9, height*3/4);

  noStroke();
  fill(0xffedde7b);
  int b;
  int a[] = {1, 4, 2, 5, 3};

  beginShape();
  for (int i = 0; i < 5; i++) {
    b = a[i] - 1;
    float x = 30 * cos(2 * PI * b / 5 + PI / 2) + 30;
    float y = 30 * sin(2 * PI * b / 5 - PI / 2) + 30;
    vertex(x+170, y+480);
  }
  endShape();
  beginShape();
  for (int i = 0; i < 5; i++) {
    b = a[i] - 1;
    float x = 25 * cos(2 * PI * b / 5 + PI / 2) + 30;
    float y = 25 * sin(2 * PI * b / 5 - PI / 2) + 30;
    vertex(x+630, y+480);
  }
  endShape();
  beginShape();
  for (int i = 0; i < 5; i++) {
    b = a[i] - 1;
    float x = 25 * cos(2 * PI * b / 5 + PI / 2) + 30;
    float y = 25 * sin(2 * PI * b / 5 - PI / 2) + 30;
    vertex(x+670, y+465);
  }
  endShape();
  beginShape();
  for (int i = 0; i < 5; i++) {
    b = a[i] - 1;
    float x = 25 * cos(2 * PI * b / 5 + PI / 2) + 30;
    float y = 25 * sin(2 * PI * b / 5 - PI / 2) + 30;
    vertex(x+710, y+480);
  }
  endShape();
  
  if(mousePressed == true && dist(width*2/9, height*3/4, mouseX, mouseY) <= rectX/2){
    timecount.limitTime = 10;
    return 10;
  }
  
  if(mousePressed == true && dist(width*7/9, height*3/4, mouseX, mouseY) <= rectX/2){
    timecount.limitTime = 5;
    return 20;
  }

  return 3;
}


public int gamePile0() {
  int flag = 0;
  while (flag != 1) {
    if (a != b && b != c && c != d && a != c && b != d && a != d) {
      background(255);

      tint(255, 50);
      image(img[a], width*0.3f, height*0.2f);
      image(img[b], width*0.3f+70, height*0.2f);
      image(img[c], width*0.3f, height*0.3f);
      image(img[d], width*0.3f, height*0.2f);

      flag = 1;
    } else {
      a = PApplet.parseInt(random(19));
      b = PApplet.parseInt(random(19));
      c = PApplet.parseInt(random(19));
      d = PApplet.parseInt(random(19));
    }
  }

  if (timemode==1) {
    fill(255);
    timecount.timeCountDisp();
    if (timecount.limitTime < 1) {
      return 11;
    }
  }

  noStroke();
  fill(0, 126);
  rect(width*7/8+10, height*0.1f+10, rectX*0.6f, rectY*0.6f, 20);
  fill(0xffEBCFFC);
  rect(width*7/8, height*0.1f, rectX*0.6f, rectY*0.6f, 20);
  fill(0);
  textSize(25);
  text("わかった", width*7/8, height*0.1f);
  if (mousePressed==true && width*7/8-rectX*0.3f <mouseX & mouseX<width*7/8+rectX*0.3f && height*0.1f-rectY*0.3f<mouseY && mouseY<height*0.1f+rectY*0.3f) {
    return 21;
  }
  return 10;
}

public int gamePile0_answer() {
  background(0xff33ff99);

  fill(0, 126);
  noStroke();
  rect(width*7/8+10, height*0.9f+10, rectX*0.8f, rectY*0.8f, 20);
  fill(0xffF5A1EF);
  stroke(0);
  rect(width*7/8, height*0.9f, rectX*0.8f, rectY*0.8f, 20);
  textSize(50);
  fill(0);
  text("次へ", width*7/8, height*0.9f);

  noStroke();
  fill(0);

  tint(255, 255);
  kanban.resize(width*6/7, 0);
  println(kanban.height, kanban.width);
  image(kanban, width*4/45, rectY/10);

  fill(0);
  textSize(50);
  text("答え．", width/2, height*0.3f);
  textSize(30);
  text(odai[a], width*0.2f, height/2);
  text(odai[b], width*0.4f, height/2);
  text(odai[c], width*0.6f, height/2);
  text(odai[d], width*0.8f, height/2);

  img[a].resize(width/7, 0);
  img[b].resize(width/7, 0);
  img[c].resize(width/7, 0);
  img[d].resize(width/7, 0);
  image(img[a], width*0.15f, height/2+30);
  image(img[b], width*0.35f, height/2+30);
  image(img[c], width*0.55f, height/2+30);
  image(img[d], width*0.75f, height/2+30);

  if (mousePressed == true) {
    if (width*7/8-rectX*0.4f < mouseX && mouseX < width*7/8+rectX*0.4f && height*0.9f-rectY*0.4f < mouseY && mouseY < height*0.9f+rectY*0.4f) {
      return 2;
    }
  }

  return 11;
}

public int gamePile1() {
  int flag = 0;
  while (flag != 1) {
    if (a != b && b != c && c != d && a != c && b != d && a != d) {
      background(255);

      tint(255, 50);
      image(img[a], width*0.3f, height*0.2f);
      image(img[b], width*0.3f+70, height*0.2f);
      image(img[c], width*0.3f, height*0.3f);
      image(img[d], width*0.3f, height*0.2f);

      flag = 1;
    } else {
      a = PApplet.parseInt(random(19));
      b = PApplet.parseInt(random(19));
      c = PApplet.parseInt(random(19));
      d = PApplet.parseInt(random(19));
    }
  }


  if (timemode==1) {
    fill(255);
    timecount.timeCountDisp();
    if (timecount.limitTime < 1) {
      return 21;
    }
  }
  
  noStroke();
  fill(0, 126);
  rect(width*7/8+10, height*0.1f+10, rectX*0.6f, rectY*0.6f, 20);
  //stroke(0);
  fill(0xffEBCFFC);
  rect(width*7/8, height*0.1f, rectX*0.6f, rectY*0.6f, 20);
  fill(0);
  textSize(25);
  text("わかった", width*7/8, height*0.1f);
  if (mousePressed==true && width*7/8-rectX*0.3f <mouseX & mouseX<width*7/8+rectX*0.3f && height*0.1f-rectY*0.3f<mouseY && mouseY<height*0.1f+rectY*0.3f) {
    return 21;
  }
  
  return 20;
}


public int gamePile1_answer() {

  background(0xff33ff99);

  fill(0, 126);
  noStroke();
  rect(width*7/8+10, height*0.9f+10, rectX*0.8f, rectY*0.8f, 20);
  fill(0xffF5A1EF);
  stroke(0);
  rect(width*7/8, height*0.9f, rectX*0.8f, rectY*0.8f, 20);
  textSize(50);
  fill(0);
  text("次へ", width*7/8, height*0.9f);

  noStroke();
  fill(0);

  tint(255, 255);
  kanban.resize(width*6/7, 0);
  println(kanban.height, kanban.width);
  image(kanban, width*4/45, rectY/10);

  fill(0);
  textSize(50);
  text("答え．", width/2, height*0.3f);
  textSize(30);
  text(odai[a], width*0.2f, height/2);
  text(odai[b], width*0.4f, height/2);
  text(odai[c], width*0.6f, height/2);
  text(odai[d], width*0.8f, height/2);

  img[a].resize(width/7, 0);
  img[b].resize(width/7, 0);
  img[c].resize(width/7, 0);
  img[d].resize(width/7, 0);
  image(img[a], width*0.15f, height/2+30);
  image(img[b], width*0.35f, height/2+30);
  image(img[c], width*0.55f, height/2+30);
  image(img[d], width*0.75f, height/2+30);

  if (mousePressed == true) {
    if (width*7/8-rectX*0.4f < mouseX && mouseX < width*7/8+rectX*0.4f && height*0.9f-rectY*0.4f < mouseY && mouseY < height*0.9f+rectY*0.4f) {
      return 2;
    }
  }

  return 21;
}

public int ending() {
  background(0xffAEEA6B);
  fill(0xffF29584);
  stroke(0);
  rect(width/2, height/2, rectX*3.2f, rectY*3/2, 20);

  tint(255, 255);
  return_title.resize(width*2/3, 0);
  image(return_title, width/6, height/3+rectY/4);

  timecount.limitTime = 60;
  timemode = tmode;

  if (mousePressed == true) {
    if (width/2-rectX*1.6f < mouseX && mouseX < width/2+rectX*1.6f && height/2-rectY*3/4 < mouseY && mouseY < height/2+rectY*3/4) {
      return 0;
    }
  }
  return 2;
}
class Vegetable {
  String name;
  String detail;
  PImage img;
  
 Vegetable(String name, PImage img) {
    this.name = name;
    this.img = img;
  }
  
 Vegetable(String name, String detail, PImage img) {
   this.name = name;
   this.img = img;
   this.detail = detail;
 }
}

//カルタのクラス
class Card {
  int x;
  int y;
  boolean isShow = true;
  PImage karuta = loadImage("karuta.png");
  private Vegetable vegetable;
  
  Card(int x, int y, Vegetable vegetable) {
    this.x = x;
    this.y = y;
    this.vegetable = vegetable;
    vegetable.img.resize(vegetable.img.width/3-20, vegetable.img.height/3-20);
  }
  
  public void display() {
    if(isShow) {
      image(karuta, x, y);
      image(vegetable.img, x+15, y+50); 
    }
  }
}


class Timecount{
  int timecnt=1;
  int timeCounter = 0;
  int limitTime = 60;
  
  public void timeCountDisp(){
    timeCounter += 1;
    if(timeCounter%50==0){ 
      limitTime -= timecnt;
    }
    fill(255);
    stroke(255);
    rect(5,3,40,30);
    textSize(40);
    fill(0);
    text(nf(limitTime, 2), 25, 35);
  }
}
public void mouseClicked() {
  println("111111");
  if(state == 1) {
      if (width/2-rectX*3/2< mouseX && mouseX < width/2-rectX/2 && height*0.8f-rectY/2 < mouseY && mouseY < height*0.8f+rectY/2) {
      tmode = timemode;
      a = PApplet.parseInt(random(19));
      b = PApplet.parseInt(random(19));
      c = PApplet.parseInt(random(19));
      d = PApplet.parseInt(random(19));
      println(a, b, c, d);
      gameclick3 = true;
   
    }
    
    
    if (width/2-rectX*1.6f < mouseX && mouseX < width/2+rectX*1.6f && height/2-rectY*3/4 < mouseY && mouseY < height/2+rectY*3/4) {
      gameclick4 = true;
      println("22222");
    }
  }
  
  


  int time = millis() - baseTime;
  for(int i = 0; i < CARD_NUMBER; i++) {
    if(mouseX >= card[i].x && mouseX <= card[i].x + card[i].karuta.width
    && mouseY >= card[i].y && mouseY <= card[i].y + card[i].karuta.height && card[i].isShow == true && gamemode1) {
      println(card[i].vegetable.name);
      
      if(card[cur].vegetable.name == card[i].vegetable.name) {
        //カードを消失させる(見えなくさせる)
        card[i].isShow = false;
        cur ++;
        
        //終わりの処理
        if(cur == CARD_NUMBER) {
          saveScore(time);
        }
        
        correctNum ++;        
        cardClicked(correctSnd);
      } else {
        wrongNum ++;
        cardClicked(wrongSnd);
        
      }
    }
  }
}


public void stop() {
  correctSnd.close();
  wrongSnd.close();
  minim.stop();
  super.stop();  
}

                 
public void shuffle(String[] array) {
    // 配列が空か１要素ならシャッフルしようがないので、そのままreturn
    if (array.length <= 1) {
        return;
    }
    
    for(int i = 0; i < array.length; i++) {
      int rnd = (int)( Math.random() * (double)array.length );
      
      String tmp = array[i];
      array[i] = array[rnd];
      array[rnd] = tmp;
    }
} 


public void shuffleVegetable(Vegetable[] array) {
    // 配列が空か１要素ならシャッフルしようがないので、そのままreturn
    if (array.length <= 1) {
        return;
    }
    
    for(int i = 0; i < array.length; i++) {
      int rnd = (int)( Math.random() * (double)array.length );
      
      Vegetable tmp = array[i];
      array[i] = array[rnd];
      array[rnd] = tmp;
    }
}  

public void shuffleCard(Card[] array) {
    // 配列が空か１要素ならシャッフルしようがないので、そのままreturn
    if (array.length <= 1) {
        return;
    }
    
    for(int i = 0; i < array.length; i++) {
      int rnd = (int)( Math.random() * (double)array.length );
      
      Card tmp = array[i];
      array[i] = array[rnd];
      array[rnd] = tmp;
    }
}  


public void displayScore() {
  String [] score = loadStrings(savefile);
  
  int min_num = min(SCORE_NUMBER, score.length);
  
  for(int i = 0; i < min_num; i++) {
    fill(0);
    textSize(32);
    text(str(i+1) + ":", height/2, 100*i + 50);
    text(score[i],height/2 + 50, 100*i + 50);
  }
  
  if(min_num < SCORE_NUMBER) {
    for(int i = min_num-1; i < SCORE_NUMBER; i++) {
      text(str(i+1) + ":", height/2, 100*i + 50);
      text("",height/2 + 50, 100*i + 50);
    }
  }
}

public void cardClicked(AudioSnippet snd) {
  snd.rewind();
  snd.play();
}

public void saveScore(float time) {
    //上位を5を記録
    endTime = time / 1000.0f;
    String[] scores = loadStrings(savefile);
    float[] saveScores = new float[scores.length+1];
    saveScores[0]  = endTime;
    for(int j = 0; j < scores.length; j++) {
      saveScores[j+1] = PApplet.parseFloat(scores[j]);
    }
    
    saveScores = sort(saveScores);
    int min_num = min(SCORE_NUMBER, saveScores.length);
    String[] memoScores = new String[min_num];
    for(int j = 0; j < min_num; j++) {
      memoScores[j] = str(saveScores[j]);
    }    
    saveStrings(savefile, memoScores);    
}
  public void settings() {  size(900, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "irasuto" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
