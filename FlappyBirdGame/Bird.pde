class Bird{
  
  PVector pos;
  PVector vel;
  PVector acc;
  float r = 25;
  PVector gravity = new PVector(0, 0.5);
  float distanceTraveled = 0;
  
  float fallRotation = -PI / 6;
  int score = 0;
  
  Bird(){
    pos = new PVector(50, height/2);
    vel = new PVector(0, 0);
    acc = new PVector();
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void update(){
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
    
    if(BirdCollisionWithPipe() || BirdCollisionWithGround() || BirdCollisionWithCeiling()){
      hitSound.play();
      stopGame = true;
    }
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
    image(birdImage, pos.x, pos.y);
    popMatrix();
  }
  
  void jump(){
    PVector up = new PVector(0, -125);
    applyForce(up);
  }
  
}
