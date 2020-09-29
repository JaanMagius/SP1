import java.util.Random;

class Game {
  private Random rnd;
  private int width;
  private int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private int playerLife2;
  private Dot player;
  private Dot player2;
  private Dot[] enemies;
  private Dot[] food;


  Game(int width, int height, int numberOfEnemies, int amountOfFood) {
    if (width < 10 || height < 10) {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0) {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 

    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player = new Dot(0, 0, width-1, height-1);
    player2 = new Dot(24, 0, width-1, height-1);
    food = new Dot[amountOfFood];
    for (int i = 0; i < amountOfFood; ++i) {
      food[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    enemies = new Dot[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i) {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    this.playerLife = 100;
    this.playerLife2 = 100;
  }

  public int getWidth() {
    return width;
  }

  public int getHeight() {
    return height;
  }

  public int getPlayerLife() {
    return playerLife;
  }

  public int getPlayerLife2() {
    return playerLife2;
  }



  public void onKeyPressed(char ch) {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch) {
    keys.onKeyReleased(ch);
  }
  
  public void arrowKeyPressed() {
    keys.arrowKeyPressed();
  }

  public void arrowKeyReleased() {
    keys.arrowKeyReleased();
  }

  public void update() {
    updatePlayer();
    updatePlayer2();
    updateEnemies();
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }



  public int[][] getBoard() {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard() {
    for (int y = 0; y < height; ++y) {
      for (int x = 0; x < width; ++x) {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer() {
    //Update player
    if (keys.wDown() && !keys.sDown()) {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown()) {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown()) {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown()) {
      player.moveRight();
    }
  }

  private void updatePlayer2() {
    if (keys.arrowUpPressed() && !keys.arrowDownPressed()) {
     player2.moveUp(); 
    }
    if (keys.arrowDownPressed() && !keys.arrowUpPressed()) {
     player2.moveDown(); 
    }
    if (keys.arrowLeftPressed() && !keys.arrowRightPressed()) {
     player2.moveLeft(); 
    }
    if (keys.arrowRightPressed() && !keys.arrowLeftPressed()) {
     player2.moveRight(); 
    }
  }

  private void updateEnemies() {
    for (int i = 0; i < enemies.length; ++i) {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2) {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        int ddx = player2.getX() - enemies[i].getX();
        int ddy = player2.getY() - enemies[i].getY();
        if (abs(dx) > abs(dy) || abs(ddx) > abs(ddy)) {
          if (dx > 0 || ddx > 0) {
            //Player is to the right
            enemies[i].moveRight();
          } else {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0 || ddy > 0) {
          //Player is down;
          enemies[i].moveDown();
        } else {//Player is up;
          enemies[i].moveUp();
        }
      } else {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0) {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1) {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2) {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3) {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void updateFood() {
    for (int i = 0; i < food.length; ++i) {
      if (rnd.nextInt(3) < 2) {
        int dx = player.getX() + food[i].getX();
        int dy = player.getY() + food[i].getY();
        int ddx = player2.getX() + food[i].getX();
        int ddy = player2.getY() + food[i].getY();
        if (abs(dx) > abs(dy) || abs(ddx) > abs(ddy)) {
          if (dx > 0 || ddx > 0) {
            food[i].moveLeft();
          } else {
            food[i].moveRight();
          }
        } else if (dy > 0 || ddy > 0) {
          food[i].moveUp();
        } else {
          food[i].moveDown();
        }
      } else {
        int move = rnd.nextInt(3);
        if (move == 0) {
          food[i].moveRight();
        } else if (move == 1) {
          food[i].moveLeft();
        } else if (move == 2) {
          food[i].moveUp();
        } else if (move == 3) {
          food[i].moveDown();
        }
      }
    }
  } 

  private void populateBoard() {
    //Insert player(s)
    board[player.getX()][player.getY()] = 1;
    if (playerLife == 0) {
     board[player.getX()][player.getY()] = 0; 
    }
    board[player2.getX()][player2.getY()] = 4;
    if (playerLife2 == 0) {
      board[player2.getX()][player2.getY()] = 0;
    }
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i) {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    for (int i = 0; i < food.length; ++i) {
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }


  private void checkForCollisions() {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i) {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY()) {
        //We have a collision
        --playerLife;
        file.amp(0.2);
        file.play();
        if (playerLife < 0) {
          playerLife = 0; //Player health can not go lower than 0
        }
      } else if (enemies[i].getX() == player2.getX() && enemies[i].getY() == player2.getY()) {
        --playerLife2;
        file.amp(0.2);
        file.play();
        if (playerLife2 < 0) {
          playerLife2 = 0;
        }
      }
    }
    for (int i = 0; i < food.length; ++i) {
      if (food[i].getX() == player.getX() && food[i].getY() == player.getY()) {
        playerLife += 10; //When player and NPC intersect, player receives 10 HP
        food[i].finished();
        if (playerLife > 100) {
          playerLife = 100; //Player health can not go above 100
        }
      }
      if (food[i].getX() == player2.getX() && food[i].getY() == player2.getY()) {
        playerLife2 += 10;
        food[i].finished();
        if (playerLife2 > 100) {
          playerLife2 = 100;
        }
      }
    }
  }
}
