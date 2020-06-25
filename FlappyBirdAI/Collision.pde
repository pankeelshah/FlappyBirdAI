boolean circleRect(float cx, float cy, float radius, float rx, float ry, float rw, float rh) {

  // temporary variables to set edges for testing
  float testX = cx;
  float testY = cy;

  // which edge is closest?
  if (cx < rx)         testX = rx;      // test left edge
  else if (cx > rx+rw) testX = rx+rw;   // right edge
  if (cy < ry)         testY = ry;      // top edge
  else if (cy > ry+rh) testY = ry+rh;   // bottom edge

  // get distance from closest edges
  float distX = cx-testX;
  float distY = cy-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // if the distance is less than the radius, collision!
  if (distance <= radius) {
    return true;
  }
  return false;
}

boolean BirdCollisionWithPipe(Bird bird){
  //Pipe p = pipes.get(0);
  for(Pipe p: pipes){
    if(circleRect(bird.pos.x + bird.r, bird.pos.y + bird.r - 17, bird.r, p.x, p.yBot, 104, p.BotHeight) || circleRect(bird.pos.x + bird.r, bird.pos.y + bird.r, bird.r, p.x, 0, 104, p.TopHeight)){
      return true;
    }
  }
  return false;
}
