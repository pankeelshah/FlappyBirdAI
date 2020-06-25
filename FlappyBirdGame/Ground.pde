class Ground {

    float topPixelCoord;
    float pixelOffset;
  
    Ground(){
      this.topPixelCoord = height - 30;
      this.pixelOffset = 0;
    }
    
    void update(){
      this.pixelOffset -= 1;
      if (this.pixelOffset <= -groundPieceImage.width) {
        this.pixelOffset += groundPieceImage.width;
      }
    }
    
    void render(){
      for (float i = this.pixelOffset; i < width; i += groundPieceImage.width) {
        image(groundPieceImage, i, this.topPixelCoord);
      }
    }
}
