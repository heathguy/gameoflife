Cell[][] currentState;
Cell[][] tempState;

int cellSize = 10;
int rows,cols;

boolean pauseSim = false;

void copyArray(Cell[][] origarr, Cell[][] newarr) {
  for(int j = 0; j < cols; j++) {
      for(int i = 0; i < rows; i++) {
        newarr[i][j] = origarr[i][j];
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
  for(int j = 0; j < cols; j++) {
    for(int i = 0; i < rows; i++) {
      currentState[i][j] = new Cell(i,j,cellSize);
      
      float test = random(0,1);
      if(test > .5) {
        currentState[i][j].alive = false;
      }
    }  
  }
 copyArray(currentState, tempState);

  
  // Calculate neighbors and show the current state
  background(51);
  noStroke();
  fill(255);
  int na = 0;
  for(int j = 0; j < cols; j++) {
      for(int i = 0; i < rows; i++) {
        //println("CURRENT CELL: " + i + ", " + j);
        na = numAliveNeighbors(i,j);
        currentState[i][j].aliveNeighbors = na;
        currentState[i][j].show();
        tempState[i][j].updateAliveStatus(na);
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
  for(int j = 0; j < cols; j++) {
      for(int i = 0; i < rows; i++) {
        numAlive = numAliveNeighbors(i,j);
        currentState[i][j].aliveNeighbors = numAlive;
        currentState[i][j].show();
        tempState[i][j].updateAliveStatus(numAlive);
      }
  }
  copyArray(tempState, currentState);
}

}

int numAliveNeighbors(int x, int y) {
  int alive = 0;
  for(int j = -1; j < 2; j++) {
    for(int i = -1; i < 2; i++) {
      int checkx = x + i;
      int checky = y + j;
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
