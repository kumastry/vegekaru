void mouseClicked() {
  println("111111");
  if(state == 1) {
      if (width/2-rectX*3/2< mouseX && mouseX < width/2-rectX/2 && height*0.8-rectY/2 < mouseY && mouseY < height*0.8+rectY/2) {
      tmode = timemode;
      a = int(random(19));
      b = int(random(19));
      c = int(random(19));
      d = int(random(19));
      println(a, b, c, d);
      gameclick3 = true;
   
    }
    
    
    if (width/2-rectX*1.6 < mouseX && mouseX < width/2+rectX*1.6 && height/2-rectY*3/4 < mouseY && mouseY < height/2+rectY*3/4) {
      gameclick4 = true;
      println("22222");
    }
  }
  
  


  int time = millis() - baseTime;
  for(int i = 0; i < CARD_NUMBER; i++) {
    if(mouseX >= card[i].x && mouseX <= card[i].x + card[i].karuta.width
    && mouseY >= card[i].y && mouseY <= card[i].y + card[i].karuta.height && card[i].isShow == true && state == 4) {
      println(card[i].vegetable.name);
      
      if(card[cur].vegetable.name == card[i].vegetable.name) {
        //カードを消失させる(見えなくさせる)
        card[i].isShow = false;
        cur ++;
        
        //終わりの処理
        if(cur == CARD_NUMBER) {
          endtime = time;
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


void shuffleVegetable(Vegetable[] array) {
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

void shuffleCard(Card[] array) {
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
    
    endTime = (2000*wrongNum+time) / 1000.0;
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
