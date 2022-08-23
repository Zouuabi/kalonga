class Character {
  Character({required this.position , required this.border});
  int position;

  List<int> border = [
    2,
    1,
    8,
    15,
    22,
    29,
    36,
    43,
    42,
    49,
    56,
    57,
    58,
    59,
    66,
    67,
    68,
    61,
    54,
    47,
    40,
    39,
    38,
    31,
    24,
    25,
    26,
    27,
    20,
    13,
    12,
    11,
    10,
    3
  ];
  bool isOnBorder(position) {
    int borderLength = border.length;
    for (int i = 0; i < borderLength; ++i) {
      if (position == border[i]) {
        return true;
      }
    }
    return false;
  }

  void moveLeft() {
    if (isOnBorder(position - 1) == false) {
      position--;
    }
  }

  void moveRight() {
    if (isOnBorder(position + 1) == false) {
      position++;
    }
  }

  void moveUp() {
    if (isOnBorder(position - 9) == false) {
      position -= 9;
    }
  }

  void moveDown() {
    if (isOnBorder(position + 9) == false) {
      position += 9;
    }
  }
}
