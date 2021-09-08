import ddf.minim.*;

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
    img = loadImage(path);
    name = path;
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

Minim minim;
AudioSnippet correctSnd;
AudioSnippet wrongSnd;
int correctNum = 0;
int wrongNum = 0;
float endTime;
int cur = 0;
boolean ready = true;

void setup() {
  size(800, 600);
  shuffle(path);
  minim = new Minim(this);
  correctSnd = minim.loadSnippet("Quiz-Correct_Answer02-1.mp3");
  wrongSnd = minim.loadSnippet("Quiz-Wrong_Buzzer02-3.mp3");
  
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
    
  } else {
  
  
  if(cur < 10) { 
    for(int i = 0; i < 10; i++) {
      card[i].display();
  }
  
  fill(255);
  rect(20, 430, 750, 150);
  
  fill(0);
  textSize(32);
  text(path[cur],30, 500, 200, 200); 
  } else {
    fill(0);
    textSize(32);
    text("FINISH",30, 500, 200, 200);
    text(str(endTime), 140, 500, 200, 200);
  }
  
  }
}

void mouseClicked() {
  for(int i = 0; i < 10; i++) {
    if(mouseX >= card[i].x && mouseX <= card[i].x + card[i].img.width
    && mouseY >= card[i].y && mouseY <= card[i].y + card[i].img.height && card[i].isShow == true) {
      println(card[i].name);
      
      if(path[cur] == card[i].name) {
        card[i].isShow = false;
        cur ++;
        if(cur == 10) {
          endTime = millis() / 1000.0;
        }
        
        correctNum ++;
        correctSnd.rewind();
        correctSnd.play();
      } else {
        wrongNum ++;
        wrongSnd.rewind();
        wrongSnd.play();
        
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
