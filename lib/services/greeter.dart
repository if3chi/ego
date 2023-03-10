import 'dart:math';

class Greeter {
  static String timeOfDay() {
    var hour = DateTime.now().hour;

    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';

    return 'Evening';
  }

  static String hello(
      {greetings = const ['Good', 'Awesome', 'Great', 'Beautiful']}) {
    return "${greetings[Random().nextInt(greetings.length)]} ${timeOfDay()}!";
  }
}
