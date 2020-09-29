class Keys
{
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;

  //Player 2 controls
  private boolean arrowUpPressed    = false;
  private boolean arrowDownPressed  = false;
  private boolean arrowLeftPressed  = false;
  private boolean arrowRightPressed = false;

  public boolean wDown() {
    return wDown;
  }

  public boolean aDown() {
    return aDown;
  }

  public boolean sDown() {
    return sDown;
  }

  public boolean dDown() {
    return dDown;
  }

  public boolean arrowUpPressed() {
    return arrowUpPressed;
  }

  public boolean arrowDownPressed() {
    return arrowDownPressed;
  }

  public boolean arrowLeftPressed() {
    return arrowLeftPressed;
  }

  public boolean arrowRightPressed() {
    return arrowRightPressed;
  }



  void onKeyPressed(char ch) {
    if (ch == 'W' || ch == 'w') {
      wDown = true;
    } else if (ch == 'A' || ch == 'a') {
      aDown = true;
    } else if (ch == 'S' || ch == 's') {
      sDown = true;
    } else if (ch == 'D' || ch == 'd') {
      dDown = true;
    }
  } 

  void arrowKeyPressed() {
    if (key == CODED) {
      if (keyCode == UP) {
        arrowUpPressed = true;
      } else if (keyCode == DOWN) {
        arrowDownPressed = true;
      } else if (keyCode == LEFT) {
        arrowLeftPressed = true;
      } else if (keyCode == RIGHT) {
        arrowRightPressed = true;
      }
    }
  }

  void onKeyReleased(char ch) {
    if (ch == 'W' || ch == 'w') {
      wDown = false;
    } else if (ch == 'A' || ch == 'a') {
      aDown = false;
    } else if (ch == 'S' || ch == 's') {
      sDown = false;
    } else if (ch == 'D' || ch == 'd') {
      dDown = false;
    }
  }

  void arrowKeyReleased() {
    if (key == CODED) {
      if (keyCode == UP) {
        arrowUpPressed = false;
      } else if (keyCode == DOWN) {
        arrowDownPressed = false;
      } else if (keyCode == LEFT) {
        arrowLeftPressed = false;
      } else if (keyCode == RIGHT) {
        arrowRightPressed = false;
      }
    }
  }
}
