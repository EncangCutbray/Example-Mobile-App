import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:project/configs/backend_api.dart';
import 'package:project/exceptions/api_exception.dart';
import 'package:project/features/courses/data/models/course_list_54_model.dart';

abstract class CourseList54DataSource {
  Future<CourseList54Model> getCourseList54();
}

class CourseList54DataSourceImpl implements CourseList54DataSource {
  final http.Client client;

  CourseList54DataSourceImpl({required this.client});

  @override
  Future<CourseList54Model> getCourseList54() async {
    try {
      String endPoint = '/courses/content/54';

      final configs = BackendApi.get(endPoint);
      
      final response = await client.get(configs['url'], headers: configs['headers']);

      if (response.statusCode == 200) {
        final convertData = convert.jsonDecode(response.body)['data'];
        return CourseList54Model(result: convertData);
      }
      throw ApiException();
    } catch (e) {
      throw ApiException();
    }
  }
}
