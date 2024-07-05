import 'package:flutter/material.dart';
import 'package:kalonga/src/utils/image_manager.dart';

class Borderr extends StatelessWidget {
  const Borderr({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Card();
  }
}

class Hole extends StatelessWidget {
  const Hole({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageManager.hole,
      fit: BoxFit.cover,
    );
  }
}

class Banana extends StatelessWidget {
  const Banana({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageManager.banana,
      fit: BoxFit.cover,
    );
  }
}

class HappyBanana extends StatelessWidget {
  const HappyBanana({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageManager.happyBanana,
      fit: BoxFit.cover,
    );
  }
}

class Character extends StatelessWidget {
  const Character({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageManager.monkey,
      fit: BoxFit.cover,
    );
  }
}
