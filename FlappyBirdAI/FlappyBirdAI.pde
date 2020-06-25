import processing.sound.*;
import java.util.*;
import controlP5.*;

//Adjustable Variables
float pipeDistance = 300;
float actionThreshold = 0.5;
float jumpForceY = -50;
int populationSize = 1000;
int mutationRate = 5;

ArrayList<Bird> birds = new ArrayList<Bird>();
int generation = 0;
int maxScore = 0;
int alive = populationSize;
int currentScore = 0;
boolean stopGame = false;
ArrayList<Pipe> pipes = new ArrayList<Pipe>();
Ground ground;
boolean pipeAdded = false;
int numWeights = 5;
ArrayList<Bird> savedBirds = new ArrayList<Bird>();
boolean render = true;

PImage birdImage;
PImage backgroundImage;
PImage topPipeImage;
PImage bottomPipeImage;
PImage groundPieceImage;

SoundFile swooshSound;
SoundFile dieSound;
SoundFile hitSound;
SoundFile pointSound;

ControlP5 controlP5;
Slider s;

void setup(){
    size(600,800);
    for(int i = 0; i < populationSize; i++){
      float[] weights = new float[numWeights];
      for(int j = 0; j < numWeights; j++){
        weights[j] = random(0,1);
      }
      birds.add(new Bird(weights));
    }

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
    
    controlP5 = new ControlP5(this);
    s = controlP5.addSlider("Speed")
    .setPosition(10,90)
    .setRange(1,100)
    ;
    noLoop();
}

void draw(){
  background(backgroundImage);
  
  for(int i = 0; i < s.getValue(); i++){
    List<Bird> toRemove = new ArrayList<Bird>();
    for(Bird b: birds){
      if(b.update()){
        toRemove.add(b);
        savedBirds.add(b);
      }
    }
    birds.removeAll(toRemove);
    ground.update();
    updatePipes();
    
    if(alive <= 0){
      reset();
    }
  }

  if(render){
    for(Bird b: birds){
      b.render();
    }
    renderPipes();
    ground.render();
  }
  renderText();
}

void renderText(){
  text("Current Score: " + currentScore, 10, 20);
  text("Max Score: " + maxScore, 10, 40);
  text("Generation: " + generation, 10, 60);
  text("Alive: " + alive + "/" + populationSize, 10, 80);
}

void reset(){
  pipes = new ArrayList<Pipe>();
  pipes.add(new Pipe(height/2));
  ground = new Ground();
  alive = populationSize;
  generation += 1;
  currentScore = 0;
  pipeAdded = false;
  
  Bird[] bestBirds = selection();
  //crossover(bestBirds[0], bestBirds[1]);
  crossover2(bestBirds[0]);
  mutation();

  savedBirds = new ArrayList<Bird>();
}
