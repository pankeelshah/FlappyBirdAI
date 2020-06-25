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
