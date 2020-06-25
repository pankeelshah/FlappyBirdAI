class Bird{
  
  PVector pos;
  PVector vel;
  PVector acc;
  float r = 20;
  PVector gravity = new PVector(0, 0.5);
  float distanceTraveled = 0;
  
  float fallRotation = -PI / 6;
  int score = 0;
  
  float[] weights;
  
  boolean dead = false;
  
  Bird(float[] weights){
    pos = new PVector(50, height/2);
    vel = new PVector(0, 0);
    acc = new PVector();
    
    this.weights = weights;
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  boolean update(){
    think();
    applyForce(gravity);
    pos.add(vel);
    vel.add(acc);
    vel.limit(10);
    acc.mult(0);
  
    if (pos.y > height) {
      pos.y = height;
      vel.mult(0);
      
    }
    
    this.distanceTraveled += 5;
    
    if(BirdCollisionWithPipe(this) || BirdCollisionWithGround() || BirdCollisionWithCeiling()){
      //hitSound.play();
      //stopGame = true;

      alive -= 1;
      return true;
    }
    return false;
  }
  
  boolean BirdCollisionWithGround(){
    if(pos.y > (height - r - 30)){
      return true;
    }else{
      return false;
    }
  }
  
  boolean BirdCollisionWithCeiling(){
    if(pos.y < 0){
      return true;
    }else{
      return false;
    }
  }
  
  void render(){
    pushMatrix();
    //translate(pos.x -18 + birdImage.width/2, pos.y - 18 + birdImage.height / 2);
    //if(vel.y < 4){
    //  rotate(-PI / 6);
    //  this.fallRotation = -PI / 6;
    //} else if(vel.y < 8){
    //  this.fallRotation += PI / 8.0;
    //  this.fallRotation = constrain(this.fallRotation, -PI / 6, PI / 2);
    //  rotate(this.fallRotation);  
    //} else{
    //  rotate(PI / 3);
    //}
    //println(vel.y);
    //image(birdImage, -birdImage.width/2, -birdImage.height/2);
    if(!dead){
      image(birdImage, pos.x, pos.y);
    }
    
    popMatrix();
  }
  
  void jump(){
    PVector up = new PVector(0, jumpForceY);
    applyForce(up);
  }
  
  void think(){
    //neural net
    //input layer, 5 inputs
    float yLocation = pos.y / height;
    float yVelocity = abs(vel.y / 10);
    float xNextPipe;
    float yBottomPipe;
    float yTopPipe;
    
    if(pipes.get(0).x > 0){
       //circle(pipes.get(0).x, pipes.get(0).TopHeight, 50);
       //circle(pipes.get(0).x, pipes.get(0).yBot, 50);
       xNextPipe = pipes.get(0).x / width;
       yBottomPipe = pipes.get(0).BotHeight / height;
       yTopPipe = pipes.get(0).TopHeight / height;
    }
    else{
      //circle(pipes.get(1).x, pipes.get(1).TopHeight, 50);
      //circle(pipes.get(1).x, pipes.get(1).yBot, 50);
      xNextPipe = pipes.get(1).x / width;
      yBottomPipe = pipes.get(1).BotHeight / height;
      yTopPipe = pipes.get(1).TopHeight / height;
    }
    
    //hidden layer
    //yLocation = atan(yLocation);
    //yVelocity = yVelocity * PI;
    //xNextPipe = exp(xNextPipe);
    //yBottomPipe = pow(yBottomPipe, 4);
    //yTopPipe = pow(yTopPipe, 0.5);
    
    float[] features = {yLocation, yVelocity, xNextPipe, yBottomPipe, yTopPipe};
    //output layer, 1 output
    float actionValue = 0;
    for(int i = 0; i < numWeights; i++){
      actionValue += weights[i] * features[i];
    }
    //actionValue = actionValue/(actionValue+1);
    
    if(actionValue > actionThreshold){
      jump();
    }
  }
  
  float fitness(){
    return score * score + (distanceTraveled / 500);
  }
  
}
