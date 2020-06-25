import processing.sound.*;

Bird bird;
boolean stopGame = false;
ArrayList<Pipe> pipes = new ArrayList<Pipe>();
float pipeDistance = 200;
Ground ground;
boolean pipeAdded = false;

PImage birdImage;
PImage backgroundImage;
PImage topPipeImage;
PImage bottomPipeImage;
PImage groundPieceImage;

SoundFile swooshSound;
SoundFile dieSound;
SoundFile hitSound;
SoundFile pointSound;

void setup(){
    size(600,800);
    bird = new Bird();
    ground = new Ground();

    birdImage = loadImage("images/bird.png");
    backgroundImage = loadImage("images/background.png");
    bottomPipeImage = loadImage("images/fullbottompipe.png");
    topPipeImage = loadImage("images/fulltoppipe.png");
    groundPieceImage = loadImage("images/groundPiece.png");

    swooshSound = new SoundFile(this, "sounds/sfx_swooshing.wav");
    swooshSound.amp(0.05);
    dieSound = new SoundFile(this, "sounds/sfx_die.wav");
    dieSound.amp(0.05);
    hitSound = new SoundFile(this, "sounds/sfx_hit.wav");
    hitSound.amp(0.05);
    pointSound = new SoundFile(this, "sounds/sfx_point.wav");
    pointSound.amp(0.05);
    
    pipes.add(new Pipe(height/2));
    noLoop();
}

void draw(){
  background(backgroundImage);
  if(!stopGame){
    bird.update();
    ground.update();
    bird.render();
    updatePipes();
    renderPipes();
    ground.render();
    renderText();
  }else{
    renderPipes();
    ground.render();
    bird.render();
    renderText();
  }
}

void mousePressed(){
  loop();
  bird.jump();
  swooshSound.play();
}

void renderText(){
  text("Score: " + bird.score, 10, 20);
  text("Distance: " + bird.distanceTraveled, 10, 40);
}

void updatePipes(){
  for(int i = 0; i < pipes.size(); i++){
    Pipe p = pipes.get(i);
    if(p.x < 0 && p.x > -10){
      bird.score ++;
      pointSound.play();
    }
    // Only shows 2 pipes on screen at at time
    if(p.x < (width/2 - 110) && !pipeAdded){
       pipes.add(new Pipe(random(200, height - 100)));
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
