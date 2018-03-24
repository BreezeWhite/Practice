
int N = 40;
boolean[] maze;
int[] open_idx;
int iid = 0;
int block_size;
int padding = 80;

QU qu;

float startT = millis();
void setup(){
  size(700, 700);
  background(255);
  
  maze = new boolean[N*N + N*4+4/*wall around border*/];
  for(int i=0; i<N+2; i+=1) maze[i] = true;
  for(int i=maze.length-N-2; i<maze.length; i+=1) maze[i] = true;
  
  block_size = (height-padding)/N;
  qu = new QU(N);
  
  rectMode(CENTER);
  PrintMaze();
  
  open_idx = shuffle();
}

void draw(){
  openBlock();
  PrintMaze();
  
  if(qu.isPercolate()){
    noLoop();
    println("Stopped");
    println("Exec time: " + (millis()-startT)/1000 + " sec");
  }
}


void openBlock(){
  if(iid >= open_idx.length) return; 
  
  int idx = open_idx[iid];
  iid += 1;
  
  int row = idx / N;
  int col = idx % N;
  int maz_idx = (row+1)*(N+2) + col + 1;
  maze[maz_idx] = true;
  
  addUnion(maz_idx);
}
int up = -(N+2);
int down = N+2;
int right = 1;
int left = -1;
void addUnion(int cur){
  if(maze[cur+up]) qu.union(cur, cur+up);
  if(maze[cur+down]) qu.union(cur, cur+down);
  if(maze[cur+left]) qu.union(cur, cur+left);
  if(maze[cur+right]) qu.union(cur, cur+right);
}


void PrintMaze(){
  translate((padding+block_size)/2, 0);
  
  for(int i=1; i<N+1; i+=1){
    for(int j=0; j<N; j+=1){
      if(maze[i*(N+2)+j+1]) fill(255);
      else fill(100);
      
      rect(j*block_size, i*block_size, block_size, block_size);
    }
  }
}

int[] shuffle(){
  int total = N*N;
  int cur = 0;
  int[] idx = new int[total];
  for(int i=0; i<total; i+=1) idx[i] = i;
  
  while(cur != total){
    int pos = round(random(0, cur));
    idx = splice(idx, idx[total-1], pos);
    idx = subset(idx, 0, total);
    cur += 1;
  }
  
  return idx;
}