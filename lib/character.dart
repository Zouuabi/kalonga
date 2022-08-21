class Character {
  Character();
  int position = 25;
  List border = [6, 13, 20, 27, 34, 41, 48, 55, 62, 69];
  bool isOnBorder(position) {
    for (int i = 0; i < 10; ++i) {
      if (position == border[i]) {
        return true;
      }
    }
    return false;
  }

  void moveLeft() {
    if (position - 1 >= 0 && (position % 7) != 0) {
      position--;
    }
  }

  void moveRight() {
    if (position + 1 < 70 && isOnBorder(position) == false) {
      position++;
    }
  }

  void moveUp() {
    if (position - 7 >= 0) {
      position -= 7;
    }
  }

  void moveDown() {
    if (position + 7 < 70) {
      position += 7;
    }
  }
}
