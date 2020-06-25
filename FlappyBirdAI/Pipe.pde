class Pipe{

  float len;
  float x = width;
  float yBot;;
  float BotHeight;
  float TopHeight;
  
  Pipe(float len){
    this.len = len;
    this.yBot = this.len;
    this.BotHeight = height - this.len;
    this.TopHeight = this.len - pipeDistance;
  }
  
  void update(){
    this.x -= 5;
  }
  
  void render(){
    image(topPipeImage, this.x, this.len - (height + pipeDistance));
    image(bottomPipeImage, this.x, this.len);
  }
}

void updatePipes(){
  for(int i = 0; i < pipes.size(); i++){
    Pipe p = pipes.get(i);
    if(p.x < 0 && p.x > -10){
      for(Bird b: birds){
        b.score ++;  
      }
      currentScore ++;
      if(currentScore > maxScore){
        maxScore = currentScore;
      }
      //pointSound.play();
    }
    // Only shows 2 pipes on screen at at time
    if(p.x < (width/2 - 110) && !pipeAdded){
       pipes.add(new Pipe(random(400, height - 100)));
       pipeAdded = true;
    }
    // Removes the pipe after it goes off the screen
    if(p.x < -110){
      pipes.remove(p);
      pipeAdded = false;
    }
    p.update();
  }
}

void renderPipes(){
  for(Pipe p: pipes){
    p.render();
  }
}
