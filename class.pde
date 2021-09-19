class Vegetable {
  String name;
  String detail;
  String place;
  PImage img;
  final int twidth;
  final int theight;
  
 Vegetable(String name, PImage img) {
    this.name = name;
    this.img = img;
    twidth = img.width;
    theight = img.height;
  }
  
 Vegetable(String name, String detail, PImage img) {
   this.name = name;
   this.img = img;
   this.detail = detail;
   twidth = img.width;
   theight = img.height;
 }
 
 Vegetable(String name, String detail, PImage img, String place) {
   this.name = name;
   this.img = img;
   this.detail = detail;
   this.place = place;
   twidth = img.width;
   theight = img.height;
 }
}

//カルタのクラス
class Card {
  int x;
  int y;
  boolean isShow = true;
  PImage karuta = loadImage("karuta.png");
  Vegetable vegetable;
  
  Card(int x, int y, Vegetable vegetable) {
    this.x = x;
    this.y = y;
    this.vegetable = vegetable;
    vegetable.img.resize(vegetable.twidth/3-20, vegetable.theight/3-20);
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
