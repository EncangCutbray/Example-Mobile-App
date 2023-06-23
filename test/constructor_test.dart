import 'package:flutter_test/flutter_test.dart';

class Point1 {
  final double x;
  final double y;
  Point1({required this.x, required this.y});
}

class Point2 {
  final double x;
  final double y;
  Point2({this.x = 30, this.y = 10});
}

class Point3 {
  final double x;
  final double y;
  Point3({this.x = 30, required this.y});
}

class Point4 {
  double? x;
  double? y;
  Point4({this.x, this.y});
}

void main() {
  group('Test Class Contractor', () {
    test('Constructor with argument', () {
      double xPoint = 10;
      double yPoint = 20;

      var point = Point1(x: xPoint, y: yPoint);

      expect(point.x, xPoint);
      expect(point.y, yPoint);
    });

    test('Constructor with default argument', () {
      var point2 = Point2();
      expect(point2.x.toString().isNotEmpty == true, true);
      expect(point2.y.toString().isNotEmpty == true, true);
    });

    test(
        'Constructor with two argument, the first have a default argument and the last one doesnt have ',
        () {
      double yPoint = 300;
      var point3 = Point3(y: yPoint);
      expect(point3.x.toString().isNotEmpty == true, true);
      expect(point3.y == yPoint, true);
    });

    test('Constructor with two argument, that all argument are nullable', () {
      double yPoint = 300;
      Point4 point4 = Point4(x: null, y: yPoint);
      expect(point4.x == null, true);
      expect(point4.y != null, true);
    });
  });
}
