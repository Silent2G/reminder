import 'dart:math';

class Util {
  int createRandomId() {
    Random random = Random();
    return random.nextInt(99999999) + 100000000;
  }
}
