import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS= 20;
public final static int NUM_MINES= 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r =0; r < NUM_ROWS; r++)
    {
        for(int c=0; c < NUM_COLS;c++)
        {
            buttons[r][c]= new MSButton(r,c);
        }
    }

    
    setMines();
}
public void setMines()
{
    for(int i=0; i<NUM_MINES;i++)
    {
        int r = (int)(Math.random()*NUM_ROWS);
        int c = (int)(Math.random()*NUM_COLS);
        if(!mines.contains(buttons[r][c]))
        {
            mines.add(buttons[r][c]);
        }
    }
    
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();

}
public boolean isWon()
{
    for(int i=0;i<mines.size();i++)
    {
        if(mines.get(i).isFlagged()==false)
            return false;
    }
    
    return true;
}
public void displayLosingMessage()
{
    //your code here
    buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("Y");
    buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("U");
    buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("L");
    buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("S");
    buttons[NUM_ROWS/2][NUM_COLS/2+4].setLabel("E");
}
public void displayWinningMessage()
{
    //your code here
    buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("Y");
    buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("U");
    buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("W");
    buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("I");
    buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("N");
    
}
public boolean isValid(int r, int c)
{
    //your code here
    if(r<NUM_ROWS && c<NUM_COLS && r>=0 && c>=0)
        return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    if(isValid(row,col)==false )
  {
    return 0;
  }
  else 
  {
    if(isValid(row-1,col-1)==true && mines.contains(buttons[row-1][col-1]))
    {
      numMines++;
    }
    if(isValid(row-1,col)==true && mines.contains(buttons[row-1][col]))
    {
      numMines++;
    }
    if(isValid(row-1,col+1)==true && mines.contains(buttons[row-1][col+1]))
    {
      numMines++;
    }
    if(isValid(row,col-1)==true && mines.contains(buttons[row][col-1]))
    {
      numMines++;
    }
    if(isValid(row,col+1)==true && mines.contains(buttons[row][col+1]))
    {
      numMines++;
    }
    if(isValid(row+1,col-1)==true && mines.contains(buttons[row+1][col-1]))
    {
      numMines++;
    }
    if(isValid(row+1,col)==true && mines.contains(buttons[row+1][col]))
    {
      numMines++;
    }
    if(isValid(row+1,col+1)==true && mines.contains(buttons[row+1][col+1]))
    {
      numMines++;
    }
   
  }
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        if(mouseButton == RIGHT)
        {
            flagged = !flagged;
            clicked = flagged;
            
        }
        else if(mines.contains(buttons[myRow][myCol]))
        {
            displayLosingMessage();
        }
        else if(countMines(myRow,myCol)>0)
        {
            myLabel = ""+ (countMines(myRow,myCol));
        }
        else 
        {
            if(isValid(myRow,myCol-1) && !buttons[myRow][myCol-1].isClicked())
                buttons[myRow][myCol-1].mousePressed();

            if(isValid(myRow,myCol+1) && !buttons[myRow][myCol+1].isClicked())
                buttons[myRow][myCol+1].mousePressed();

            if(isValid(myRow-1,myCol) && !buttons[myRow-1][myCol].isClicked())
                buttons[myRow-1][myCol].mousePressed();
          
            if(isValid(myRow-1,myCol-1) && !buttons[myRow-1][myCol-1].isClicked())
                buttons[myRow-1][myCol-1].mousePressed();

            if(isValid(myRow-1,myCol+1) && !buttons[myRow-1][myCol+1].isClicked())
                buttons[myRow-1][myCol+1].mousePressed();

            if(isValid(myRow+1,myCol) && !buttons[myRow+1][myCol].isClicked())
                buttons[myRow+1][myCol].mousePressed();

            if(isValid(myRow+1,myCol+1) && !buttons[myRow+1][myCol+1].isClicked())
                buttons[myRow+1][myCol+1].mousePressed();

            if(isValid(myRow+1,myCol-1) && !buttons[myRow+1][myCol-1].isClicked())
                buttons[myRow+1][myCol-1].mousePressed();
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
        
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
    public boolean isClicked()
    {
        return clicked;
    }
}
