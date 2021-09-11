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
