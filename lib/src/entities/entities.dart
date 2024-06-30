import 'dart:async';

abstract class Character {
  Character({required this.position});
  int position;

  void moveLeft() {
    position--;
  }

  void moveRight() {
    position++;
  }

  void moveUp() {
    position -= 9;
  }

  void moveDown() {
    position += 9;
  }
}

class Monkey extends Character {
  Monkey({required super.position});
}

class Banana extends Character {
  Banana({required super.position});
}

class Map {
  Map(
      {required this.border,
      required this.bananas,
      required this.monkey,
      required this.holes}) {
    levelComplete.add(false);
  }
  List<int> border;
  List<Banana> bananas;
  List<int> holes;
  Monkey monkey;
  StreamController<bool> levelComplete = StreamController<bool>();

  bool isSameList(List<int> list1, List<int> list2) {
    if (list1.length != list2.length) {
      return false;
    }

    List<int> sortedList1 = List<int>.from(list1)..sort();
    List<int> sortedList2 = List<int>.from(list2)..sort();

    for (int i = 0; i < sortedList1.length; i++) {
      if (sortedList1[i] != sortedList2[i]) {
        return false;
      }
    }

    return true;
  }

  void isLevelComplete() {
    if (isSameList(holes, bananas.map((e) => e.position).toList())) {
      levelComplete.add(true);
    } else {
      levelComplete.add(false);
    }
  }

  bool isBorder(int to) {
    for (int b in border) {
      if (b == to) {
        return true;
      }
    }
    return false;
  }

  int? isBanana(int pos) {
    for (int i = 0; i < bananas.length; i++) {
      if (bananas[i].position == pos) {
        return i;
      }
    }
    return null;
  }

  void moveDown() {
    if (!isBorder(monkey.position + 9)) {
      int? pos = isBanana(monkey.position + 9);
      if (pos != null) {
        // poss not null means there is a banana in front of the monkey

        if (!isBorder(bananas[pos].position + 9) &&
            isBanana(bananas[pos].position + 9) == null) {
          bananas[pos].moveDown();
          monkey.moveDown();
        }
      } else {
        monkey.moveDown();
      }
    }
    isLevelComplete();
  }

  void moveUp() {
    if (!isBorder(monkey.position - 9)) {
      int? bananaIndex = isBanana(monkey.position - 9);
      if (bananaIndex != null) {
        if (!isBorder(bananas[bananaIndex].position - 9) &&
            isBanana(bananas[bananaIndex].position - 9) == null) {
          bananas[bananaIndex].moveUp();
          monkey.moveUp();
        }
      } else {
        monkey.moveUp();
      }
    }
    isLevelComplete();
  }

  void moveRight() {
    if (!isBorder(monkey.position + 1)) {
      int? bananaPos = isBanana(monkey.position + 1);
      if (bananaPos != null) {
        if (!isBorder(bananas[bananaPos].position + 1) &&
            isBanana(bananas[bananaPos].position + 1) == null) {
          bananas[bananaPos].moveRight();
          monkey.moveRight();
        }
      } else {
        monkey.moveRight();
      }
    }
    isLevelComplete();
  }

  void moveLeft() {
    if (!isBorder(monkey.position - 1)) {
      int? bananaPos = isBanana(monkey.position - 1);
      if (bananaPos != null) {
        if (!isBorder(bananas[bananaPos].position - 1) &&
            isBanana(bananas[bananaPos].position - 1) == null) {
          bananas[bananaPos].moveLeft();
          monkey.moveLeft();
        }
      } else {
        monkey.moveLeft();
      }
    }
    isLevelComplete();
  }
}

class Level {
  Level(
      {required this.characterPosition,
      required this.holesPositions,
      required this.bananasPositions,
      required this.borders});

  int characterPosition;
  List<int> bananasPositions;
  List<int> holesPositions;
  List<int> borders;
}
