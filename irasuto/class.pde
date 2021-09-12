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
