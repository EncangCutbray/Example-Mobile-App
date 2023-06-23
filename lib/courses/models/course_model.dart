import 'dart:convert' as convert;

import 'package:project/core/models/model.dart';

class CourseModel implements Model {
  final String? result;
  final int? counter;

  const CourseModel({this.result, this.counter});

  Map<String, dynamic> toArrayResult() {
    return result != null ? convert.jsonDecode(result as String) : {};
  }

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(result: json['result'], counter: json['counter']);
  }

  @override
  Map<String, dynamic> toJson() => {
        "result": toArrayResult()['data'] ?? [],
        "counter": counter,
      };

  CourseModel copyWith(Map<String, Object?> map, {String? result, int? counter}) {
    return CourseModel(
      result: result ?? this.result,
      counter: counter ?? this.counter,
    );
  }
}
