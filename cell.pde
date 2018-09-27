class Cell {
  int x, y, s;
  color c;
  int id;
  boolean alive = true;
  int aliveNeighbors = 0;
  
  Cell(int x, int y, int s) {
    this.x = x;
    this.y = y;
    this.s = s;
  }

void show() {
  if(alive) {
    fill(20, 20, 250);
  } else {
    noFill();
  }
  stroke(61);
  rect(x*s,y*s,s,s);
  
  /*
  textSize(32);
  fill(255,100,0);
  textAlign(CENTER,RIGHT);
  text(x,x*s,y*s+s);
  text(y,x*s+16,y*s+s);
  text(aliveNeighbors,(x*s)+(s/2)-16,(y*s)+(s/2)+16);
  */
}

void updateAliveStatus(int numAliveNeighbors) {
 // use game of life rules to determine cell's status
// Any live cell with fewer than two live neighbors dies, as if by under population.
//Any live cell with two or three live neighbors lives on to the next generation.
//Any live cell with more than three live neighbors dies, as if by overpopulation.
//Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction

  if(this.alive && numAliveNeighbors < 2) {
    this.alive = false;
  }
  if(this.alive && numAliveNeighbors < 4) {
    this.alive = true;
  }
  if(this.alive && numAliveNeighbors > 3) {
    this.alive = false;
  }
  if(!this.alive && numAliveNeighbors == 3) {
    this.alive = true;
  }

}

}
