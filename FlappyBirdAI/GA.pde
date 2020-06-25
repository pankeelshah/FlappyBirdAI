Bird[] selection(){
  
  // Selection
  Bird best1 = savedBirds.get(0);
  
  for(Bird b: savedBirds){
    if(b.fitness() > best1.fitness()){
      best1 = b;
    }
  }
  
  savedBirds.remove(best1);
  Bird best2 = savedBirds.get(0);
  for(Bird b: savedBirds){
    if(b.fitness() > best2.fitness()){
      best2 = b;
    }
  }

  Bird[] bestBirds = {best1, best2};
  return bestBirds;
}

void crossover(Bird best1, Bird best2){
  float[] bestWeights1 = best1.weights;
  float[] bestWeights2 = best2.weights;

  //create 2 birds at a time with crossover
  for(int i = 0; i < populationSize / 2; i++){
      
    int crossOverPoint = int(random(0,numWeights));
    float[] weights1 = new float[numWeights];
    float[] weights2 = new float[numWeights];
    
    for(int k = 0; k < numWeights; k++){
      weights1[k] = bestWeights1[k];
      weights2[k] = bestWeights2[k];
    }
    
    for (int j = 0; j < crossOverPoint; j++){
      weights1[j] = bestWeights2[j];
      weights2[j] = bestWeights1[j];
    }
    
    //int r = int(random(0,5));
    //float val = random(0.9, 1.01);
    //weights1[r] *= val;
    
    //int r2 = int(random(0,5));
    //float val2 = random(0.9, 1.01);
    //weights2[r2] *= val2;
    
    birds.add(new Bird(weights1));
    birds.add(new Bird(weights2)); 
  }
}

void crossover2(Bird best1){
  float[] bestWeights1 = best1.weights;
  println("------------");
  println(bestWeights1);
  println("------------");
  
  for(int i = 0; i < populationSize; i++){
    
    float[] weights1 = new float[numWeights];
    for(int k = 0; k < numWeights; k++){
      weights1[k] = bestWeights1[k];
    }
    
    for(int j = 0; j < numWeights; j++){
      int r = int(random(0,3));
      if(r == 0){
        weights1[j] *= random(0.8,0.9);
      }else if(r == 1){
        weights1[j] *= random(1.01,1.1);
      }
    }
    
    birds.add(new Bird(weights1));
  }
}

void mutation(){
  for(Bird b: birds){
    int r = int(random(0,100));
    if(r < mutationRate){
      int mutationSpot = int(random(0,5));
      b.weights[mutationSpot] = random(0,1);
    }
  }
}
