import ddf.minim.*;

//カルタのクラス
class Card {
  int x;
  int y;
  int h = 50;
  int w = 5;
  boolean isShow = true;
  
  String path;
  PImage img;
  String name;
  String detail;
  
  Card(int x, int y, String path) {
    this.x = x;
    this.y = y;
    this.path = path;
    this.img = loadImage(path);
    this.name = path;
  }
  
  void display() {
    if(isShow) {
      image(img, x, y); 
    }
  }
}



Card card[] = new Card [10];
PImage img;
String path[] = {"ゴーヤ.png","imo.png","kabu.png","melo.png","nasu.png",
                 "onion.png","papu.png","take.png","tomato.png","pi.png"};
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

void setup() {
  size(800, 600);
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
  
  
}




void draw() {
  background(255);
  if(ready == false) {
    int time = millis() - baseTime;
    println(time);
    if(time/1000 == 1) {
      fill(0);
      textSize(32);
      text("ready",30, 500, 200, 200);
    } else if(time/1000 == 2) {
      fill(0);
      textSize(32);
      text("go",30, 500, 200, 200);
     
    } else if(time / 1000 == 3) {
      baseTime = millis();
      ready = true;
    }
  } else {
  int time = millis() - baseTime;
  
  if(cur < 10) { 
    for(int i = 0; i < 10; i++) {
      card[i].display();
  }
  
  fill(255);
  rect(20, 430, 750, 150);
  
  fill(0);
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
  
  }
}

void mouseClicked() {
  int time = millis() - baseTime;
  for(int i = 0; i < CARD_NUMBER; i++) {
    if(mouseX >= card[i].x && mouseX <= card[i].x + card[i].img.width
    && mouseY >= card[i].y && mouseY <= card[i].y + card[i].img.height && card[i].isShow == true && ready ==true) {
      println(card[i].name);
      
      if(path[cur] == card[i].name) {
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

void stop() {
  correctSnd.close();
  wrongSnd.close();
  minim.stop();
  super.stop();  
}

                 
void shuffle(String[] array) {
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

void displayScore() {
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

void cardClicked(AudioSnippet snd) {
  snd.rewind();
  snd.play();
}

void saveScore(float time) {
    //上位を5を記録
    endTime = time / 1000.0;
    String[] scores = loadStrings(savefile);
    float[] saveScores = new float[scores.length+1];
    saveScores[0]  = endTime;
    for(int j = 0; j < scores.length; j++) {
      saveScores[j+1] = float(scores[j]);
    }
    
    saveScores = sort(saveScores);
    int min_num = min(SCORE_NUMBER, saveScores.length);
    String[] memoScores = new String[min_num];
    for(int j = 0; j < min_num; j++) {
      memoScores[j] = str(saveScores[j]);
    }    
    saveStrings(savefile, memoScores);    
}
