class Vegetable {
  String name;
  String detail;
  PImage img;
  
 Vegetable(String name, PImage img) {
    this.name = name;
    this.img = img;
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
  
  void display() {
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
  
  void timeCountDisp(){
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
