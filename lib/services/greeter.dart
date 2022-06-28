class Greeter {
  static String timeOfDay() {
    var hour = DateTime.now().hour;

    if (hour < 12) return 'Morning';
    if (hour < 17) return 'Afternoon';

    return 'Evening';
  }

  static String hello() {
    return "Good ${timeOfDay()}!";
  }
}
