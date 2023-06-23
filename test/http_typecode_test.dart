// ignore_for_file: unused_import

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:project/core/services/http_service.dart';
import 'package:project/courses/cubit/course_cubit.dart';
import 'package:project/courses/models/course_model.dart';

void main() {
  const urlPrefix = 'https://jsonplaceholder.typicode.com';

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "X-Authorization":
        'X5ckXwVzY5729zwlYomzgZfcLCQRJtDCyPByDfglvy2VDVpGyBfJ9FT9tvi4C3Xh'
  };

  String devBeApi = 'https://devbe.bahaso.com/api';

  group('Http Typecode :', () {
    test('send to typecode', () {
      const hello = 'Hello';
      expect(hello.isNotEmpty, true);
    });

    test('get posts from typecode', () async {
      final url = Uri.parse('$urlPrefix/posts');
      var response = await http.get(url);
      expect(response.statusCode, 200);
      expect(response.body.isNotEmpty, true);
    });

    test('get courses content from devbe.bahaso.com', () async {
      final url = Uri.parse('$devBeApi/courses/content/54');
      http.Response response = await http.get(url, headers: headers);
      expect(response.statusCode, 200);
      Map<String, dynamic> courses = convert.jsonDecode(response.body);
      expect(courses['data'][0]['name'].isNotEmpty, true);
    });

    test('get courses content from devbe.bahaso.com using HttpService', () async {
      var endPoint = '/courses/content/54';
      HttpService backend= HttpService();
      http.Response response = await backend.httpGet(endPoint);
      var courseModel = CourseModel.fromJson({'result' : response.body, 'counter': 0});
      expect(courseModel.toArrayResult()['data'][0]['name'].isNotEmpty, true);
    });

    test('get courses content from devbe.bahaso.com using CourseCubit', () async {
      var course = CourseCubit(CourseModel.fromJson(const {'result': '', 'counter': 0}));
      await course.getCourses54();
      expect(course.state.toArrayResult()['data'][0]['name'].isNotEmpty, true);
    });
  });
}
