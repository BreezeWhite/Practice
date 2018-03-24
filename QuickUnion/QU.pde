
class QU{
  private int[] tree;
  private int[] tsize;
  private int n_;
  
  public QU(int n){
    n_ = n;
    tree = new int[n*n+2 + n*4+4/*wall around border*/];
    tsize = new int[tree.length];
    
    for(int i=0; i<tree.length; i+=1){
      tree[i] = i;
      tsize[i] = 1;
    }
    for(int i=1; i<n+3; i+=1) tree[i] = 0;
    for(int i=tree.length-(n+2)-1; i<tree.length-1; i+=1) tree[i] = tree.length-1;
  }
  
  public void union(int a, int b){
    a += 1;
    b += 1;
    if(connected(a, b)) return;
    
    int root_a = root(a);
    int root_b = root(b);
    
    if(tsize[root_a] < tsize[root_b]){
      tree[root_a] = root_b;
      tsize[root_b] += tsize[root_a];
    }
    else{
      tree[root_b] = root_a;
      tsize[root_a] += tsize[root_b];
    }
  }
  
  private int root(int n){
    while(n != tree[n]){
      tree[n] = tree[tree[n]];
      n = tree[n];
    }
    return n;
  }
  public boolean connected(int a, int b){
    return root(a) == root(b);
  }
  
  public boolean isPercolate(){
    return connected(0, tree.length-1);
  }
  
  public void status(){
    println();
    println(tree[0]);
    for(int i=0; i<n_+2; i+=1){
      for(int j=0; j<n_+2; j+=1){
        print(i*(n_+2)+j+1 + "(");
        print(tree[i*(n_+2)+j+1] + ") ");
      }
      println();
    }
    print(tree[tree.length-1]);
    println();
  }
}