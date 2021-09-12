class CardInfo {
  String name;
  String detail;
  PImage img;
  
  CardInfo(String name, PImage img) {
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
  
  private CardInfo cardinfo;
  
  Card(int x, int y, String path) {
    this.x = x;
    this.y = y;
  
    img.resize(img.width/3-20, img.height/3-20);
  }
  
  void display() {
    if(isShow) {
      
      image(karuta, x, y);
      image(img, x+20, y+50); 
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
