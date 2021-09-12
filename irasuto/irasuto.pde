import ddf.minim.*;

Timecount timecount;

PImage background;
PImage tomato2;
PImage logo;
PImage mode;
PImage return_title;
PImage kanban;
PImage revel;
PImage [] img = new PImage[19];
String [] odai = new String[19];

int timemode = 1, tmode;
int state, a, b, c, d;
int rectX = 200;
int rectY = 100;
int x, iy = 0;
boolean gameclick3 = false;
boolean gameclick4 = false;


//カルタの変数
Card card[] = new Card [10];
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
static int SCORE_NUMBER = 5;
static int CARD_NUMBER = 10;
boolean gamemode1 = false;

void setup() {

  size(900, 600);
  shuffle(path);
  minim = new Minim(this);
  correctSnd = minim.loadSnippet("sound/Quiz-Correct_Answer02-1.mp3");
  wrongSnd = minim.loadSnippet("sound/Quiz-Wrong_Buzzer02-3.mp3");
  PFont font = createFont("Meiryo", 50);
  textFont(font);
  
  
  card[0] = new Card(20, 20, path[0]);
  int j = 0;
  int i = 1;
  for(int idx = 1; idx < 10; idx++) {
    card[idx] = new Card(i*(card[idx-1].img.width + 20) + 20, j*(card[idx-1].img.height + 20) + 20, path[idx]);
    i ++ ;
    if(idx == 4) {
      j ++;
      i = 0;
    }
  }
  
  shuffle(path);
  

  timecount = new Timecount();
  state = 0;
  textSize(32);
  textAlign(CENTER);
  rectMode(CENTER);

  fill(255);

  background = loadImage("sogen.jpeg");
  tomato2 = loadImage("tomato2.png");
  logo = loadImage("logo.PNG");
  mode = loadImage("mode.PNG");
  return_title = loadImage("return.PNG");
  kanban = loadImage("kanban.png");
  revel = loadImage("revel.PNG");

  img[0] = loadImage("cabbage.png");
  img[1] = loadImage("carrot.png");
  img[2] = loadImage("corn.png");
  img[3] = loadImage("daikon.png");
  img[4] = loadImage("gobou.png");
  img[5] = loadImage("kabocha.png");
  img[6] = loadImage("lettuce.png");
  img[7] = loadImage("nasu.png");
  img[8] = loadImage("negi.png");
  img[9] = loadImage("paprika.png");
  img[10] = loadImage("piman.png");
  img[11] = loadImage("potato.png");
  img[12] = loadImage("renkon.png");
  img[13] = loadImage("satsumaimo.png");
  img[14] = loadImage("shiitake.png");
  img[15] = loadImage("shimeji.png");
  img[16] = loadImage("tamanegi.png");
  img[17] = loadImage("tomato.png");
  img[18] = loadImage("kyuuri.png");

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
  
  

}

void draw() {
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
  } else if(state == 5) {
    nextState = karutaMode();
  }
  state = nextState;
}



int gameTitle() {
  tint(255, 255);
  background.resize(width, height);
  background(background);
  tomato2.resize(width/3, 0);
  img[0].resize(width/3, 0);
  img[2].resize(0, width/3);
  logo.resize(width/2, 0);
  image(tomato2, width*0.04, height*0.2);
  image(img[0], width*0.65, height*0.05);
  image(img[2], width*0.7, height*0.2);
  image(logo, width/4, height*0.2);


  noStroke();
  fill(0, 82);
  rect(width/2, height*0.7, width, height*0.2);

  stroke(#cd853f);
  strokeWeight(6);
  fill(#ffa500);
  rect(width/2, height*0.7, rectX, height*0.16, 30);

  fill(#800000);
  textAlign(CENTER, CENTER);
  textSize(50);
  text("スタート", width/2, height*0.7, width/3, height*0.16);
  fill(255);
  textSize(49);
  text("スタート", width/2, height*0.7, width/3, height*0.16);

  if (mousePressed == true) {
    if (width/2-rectX/2  < mouseX && mouseX < width/2+rectX/2 && height*0.7-height*0.08 < mouseY && mouseY < height*0.7+height*0.08) {
      
      return 1;
    }
  }

  return 0;
}

int karutaMode() {
  background(#F5A1B4);
  tint(255, 255);
  revel.resize(width*14/15, 0);
  image(revel, width/30, height/6);

  strokeWeight(2);
  stroke(#666666);
  fill(255);
  ellipse(width*2/9, height*3/4, rectX, rectX);
  ellipse(width*7/9, height*3/4, rectX, rectX);
  return 33;
}
int gameMode() {

  background(#9BF0B2);
  mode.resize(0, height/4);
  image(mode, width/6, height/5);

  fill(0, 126);
  noStroke();
  rect(width*5/18+10, height*0.6+10, rectX, rectY, 20);
  rect(width/2-rectX+10, height*0.8+10, rectX, rectY, 20);

  fill(#FFA59D);
  stroke(#dda0dd);
  rect(width*5/18, height*0.6, rectX, rectY, 20);
  rect(width/2-rectX, height*0.8, rectX, rectY, 20);

  fill(0);
  textSize(48);
  text("かるた", width*5/18, height*0.6);
  text("かさねえ", width/2-rectX, height*0.8);
  
  if (width/2-rectX*3/2< mouseX && mouseX < width/2+rectX*3/2 && height*0.6-rectY/2 < mouseY && mouseY < height*0.6+rectY/2) {
    fill(#FFA59D);
    triangle(width/2-rectX*2/5,height*0.6,width/2-rectX/4+10,height*0.53,width/2-rectX/4+10,height*0.67);
    
  }
  
  if(width/2-rectX*3/2< mouseX && mouseX < width/2-rectX/2 && height*0.8-rectY/2 < mouseY && mouseY < height*0.8+rectY/2){
    fill(#FFA59D);
    triangle(width/2-rectX*2/5,height*0.8,width/2-rectX/4+10,height*0.73,width/2-rectX/4+10,height*0.87);
  }


    if (gameclick4) {
      gameclick4 = false;
      gamemode1 = true;
      return 5;
    }
    
    
    
    if(gameclick3) {
      gameclick3  = false;
      return 3;
    }


  
  return 1;
}

int gameKaruta(){
  background(255);
 

  int time = millis() - baseTime;
  
  if(cur < 10) { 
    for(int i = 0; i < 10; i++) {
      card[i].display();
  }
  
   
  rectMode(CORNER);
  fill(255);
  rect(20, 430, 750, 150);
  
  fill(0);
  textAlign(CORNER);
  textSize(32);
  text(path[cur],30, 500, 200, 200); 
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

int gameSelect() {
  background(#F5A1B4);
  tint(255, 255);
  revel.resize(width*14/15, 0);
  image(revel, width/30, height/6);

  strokeWeight(2);
  stroke(#666666);
  fill(255);
  ellipse(width*2/9, height*3/4, rectX, rectX);
  ellipse(width*7/9, height*3/4, rectX, rectX);

  if (dist(width*2/9, height*3/4, mouseX, mouseY) <= rectX/2) {
    noStroke();
    fill(0, 126);
    ellipse(width*2/9+10, height*3/4+10, rectX, rectX);
    fill(255);
    strokeWeight(8);
    stroke(#ec6d71);
    ellipse(width*2/9, height*3/4, rectX, rectX);
  } else if (dist(width*7/9, height*3/4, mouseX, mouseY) <= rectX/2) {
    noStroke();
    fill(0, 126);
    ellipse(width*7/9+10, height*3/4+10, rectX, rectX);
    fill(255);
    strokeWeight(8);
    stroke(#ec6d71);
    ellipse(width*7/9, height*3/4, rectX, rectX);
  }

  fill(0);
  textSize(40);
  text("やさしい", width*2/9, height*3/4);
  text("むずかしい", width*7/9, height*3/4);

  noStroke();
  fill(#edde7b);
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


int gamePile0() {
  int flag = 0;
  while (flag != 1) {
    if (a != b && b != c && c != d && a != c && b != d && a != d) {
      background(255);

      tint(255, 50);
      image(img[a], width*0.3, height*0.2);
      image(img[b], width*0.3+70, height*0.2);
      image(img[c], width*0.3, height*0.3);
      image(img[d], width*0.3, height*0.2);

      flag = 1;
    } else {
      a = int(random(19));
      b = int(random(19));
      c = int(random(19));
      d = int(random(19));
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
  rect(width*7/8+10, height*0.1+10, rectX*0.6, rectY*0.6, 20);
  fill(#EBCFFC);
  rect(width*7/8, height*0.1, rectX*0.6, rectY*0.6, 20);
  fill(0);
  textSize(25);
  text("わかった", width*7/8, height*0.1);
  if (mousePressed==true && width*7/8-rectX*0.3 <mouseX & mouseX<width*7/8+rectX*0.3 && height*0.1-rectY*0.3<mouseY && mouseY<height*0.1+rectY*0.3) {
    return 21;
  }
  return 10;
}

int gamePile0_answer() {
  background(#33ff99);

  fill(0, 126);
  noStroke();
  rect(width*7/8+10, height*0.9+10, rectX*0.8, rectY*0.8, 20);
  fill(#F5A1EF);
  stroke(0);
  rect(width*7/8, height*0.9, rectX*0.8, rectY*0.8, 20);
  textSize(50);
  fill(0);
  text("次へ", width*7/8, height*0.9);

  noStroke();
  fill(0);

  tint(255, 255);
  kanban.resize(width*6/7, 0);
  println(kanban.height, kanban.width);
  image(kanban, width*4/45, rectY/10);

  fill(0);
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
  image(img[d], width*0.75, height/2+30);

  if (mousePressed == true) {
    if (width*7/8-rectX*0.4 < mouseX && mouseX < width*7/8+rectX*0.4 && height*0.9-rectY*0.4 < mouseY && mouseY < height*0.9+rectY*0.4) {
      return 2;
    }
  }

  return 11;
}

int gamePile1() {
  int flag = 0;
  while (flag != 1) {
    if (a != b && b != c && c != d && a != c && b != d && a != d) {
      background(255);

      tint(255, 50);
      image(img[a], width*0.3, height*0.2);
      image(img[b], width*0.3+70, height*0.2);
      image(img[c], width*0.3, height*0.3);
      image(img[d], width*0.3, height*0.2);

      flag = 1;
    } else {
      a = int(random(19));
      b = int(random(19));
      c = int(random(19));
      d = int(random(19));
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
  rect(width*7/8+10, height*0.1+10, rectX*0.6, rectY*0.6, 20);
  //stroke(0);
  fill(#EBCFFC);
  rect(width*7/8, height*0.1, rectX*0.6, rectY*0.6, 20);
  fill(0);
  textSize(25);
  text("わかった", width*7/8, height*0.1);
  if (mousePressed==true && width*7/8-rectX*0.3 <mouseX & mouseX<width*7/8+rectX*0.3 && height*0.1-rectY*0.3<mouseY && mouseY<height*0.1+rectY*0.3) {
    return 21;
  }
  
  return 20;
}


int gamePile1_answer() {

  background(#33ff99);

  fill(0, 126);
  noStroke();
  rect(width*7/8+10, height*0.9+10, rectX*0.8, rectY*0.8, 20);
  fill(#F5A1EF);
  stroke(0);
  rect(width*7/8, height*0.9, rectX*0.8, rectY*0.8, 20);
  textSize(50);
  fill(0);
  text("次へ", width*7/8, height*0.9);

  noStroke();
  fill(0);

  tint(255, 255);
  kanban.resize(width*6/7, 0);
  println(kanban.height, kanban.width);
  image(kanban, width*4/45, rectY/10);

  fill(0);
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
  image(img[d], width*0.75, height/2+30);

  if (mousePressed == true) {
    if (width*7/8-rectX*0.4 < mouseX && mouseX < width*7/8+rectX*0.4 && height*0.9-rectY*0.4 < mouseY && mouseY < height*0.9+rectY*0.4) {
      return 2;
    }
  }

  return 21;
}

int ending() {
  background(#AEEA6B);
  fill(#F29584);
  stroke(0);
  rect(width/2, height/2, rectX*3.2, rectY*3/2, 20);

  tint(255, 255);
  return_title.resize(width*2/3, 0);
  image(return_title, width/6, height/3+rectY/4);

  timecount.limitTime = 60;
  timemode = tmode;

  if (mousePressed == true) {
    if (width/2-rectX*1.6 < mouseX && mouseX < width/2+rectX*1.6 && height/2-rectY*3/4 < mouseY && mouseY < height/2+rectY*3/4) {
      return 0;
    }
  }
  return 2;
}
