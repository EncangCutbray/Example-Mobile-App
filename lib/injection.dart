import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:project/features/home/home_injection.dart';
import 'package:project/features/courses/course_injection.dart';

final locator = GetIt.instance;

class Injection {
  
  Injection() {
    initInjection();
  } 

  // Registration your Injection Here
  void initInjection() {
    CourseInjection(locator: locator);
    HomeInjection(locator: locator);
    locator.registerLazySingleton(() => http.Client());
  }
}
