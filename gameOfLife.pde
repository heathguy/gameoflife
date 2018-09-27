Cell[][] currentState;
Cell[][] tempState;

int cellSize = 100;
int rows,cols;

boolean pauseSim = false;

void copyArray(Cell[][] origarr, Cell[][] newarr) {
  for(int row = 0; row < rows; row++) {
      for(int col = 0; col < cols; col++) {
        newarr[row][col] = origarr[row][col];
      }  
  }
}
  

void setup() {
  size(401, 401);
  frameRate(10);
  
  rows = floor(width / cellSize);
  cols = floor(height / cellSize);
  
  currentState = new Cell[rows][cols];
  tempState = new Cell[rows][cols];
  
  // Initalize the current state with random alive cells
  for(int row = 0; row < rows; row++) {
      for(int col = 0; col < cols; col++) {
      currentState[row][col] = new Cell(row,col,cellSize);
      
      float test = random(0,1);
      if(test > .5) {
        currentState[row][col].alive = false;
      }
    }  
  }
 copyArray(currentState, tempState);

  
  // Calculate neighbors and show the current state
  background(51);
  noStroke();
  fill(255);
  int na = 0;
  for(int row = 0; row < rows; row++) {
      for(int col = 0; col < cols; col++) {
        //println("CURRENT CELL: " + i + ", " + j);
        na = numAliveNeighbors(row,col);
        currentState[row][col].aliveNeighbors = na;
        currentState[row][col].show();
        tempState[row][col].updateAliveStatus(na);
        //println("CELL:" + i + "," + j + ":" + currentState[i][j].aliveNeighbors);
        //na = 0;
      }
  }
  copyArray(tempState, currentState);
}

void mousePressed() {
  //background(51);
  //noStroke();
  //fill(255);
  //int numAlive;
  //for(int j = 0; j < cols; j++) {
  //    for(int i = 0; i < rows; i++) {
  //      numAlive = numAliveNeighbors(i,j);
  //      currentState[i][j].aliveNeighbors = numAlive;
  //      currentState[i][j].show();
  //      tempState[i][j].updateAliveStatus(numAlive);
  //    }
  //}
  //copyArray(tempState, currentState);
  //redraw();
  
  if(pauseSim) {
    pauseSim = false;
  }
  else {
    pauseSim = true;
  }
  
}


void draw() {
  if(!pauseSim) {
  background(51);
  noStroke();
  fill(255);
  int numAlive;
  for(int row = 0; row < rows; row++) {
      for(int col = 0; col < cols; col++) {
        numAlive = numAliveNeighbors(row,col);
        currentState[row][col].aliveNeighbors = numAlive;
        currentState[row][col].show();
        tempState[row][col].updateAliveStatus(numAlive);
      }
  }
  copyArray(tempState, currentState);
}

}

int numAliveNeighbors(int x, int y) {
  int alive = 0;
  for(int row = -1; row < 2; row++) {
    for(int col = -1; col < 2; col++) {
      int checkx = x + row;
      int checky = y + col;
      //print("CHECKING: "+checkx+","+checky);
      // check if arr vals are out of bounds and not itself
      if( (checkx == x) && (checky == y) ) {
        //println(" SKIPPING SELF");
      }
      else if( (checkx > -1) && (checkx < rows) && (checky > -1) && (checky < cols) ){
        //println(" " + currentState[checkx][checky].alive);
        if(currentState[checkx][checky].alive) {
          
          alive++;
        }
      }
      else {
        //println(" INVALID POSITION");
      }
      
    }
  }
  return alive;
}
