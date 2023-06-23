import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Course extends Equatable {
  int? id;
  String? name;
  int? visible;
  String? summary;
  int? summaryformat;
  int? section;
  int? hiddenbynumsections;
  bool? uservisible;

  Course({
    this.id,
    this.name,
    this.visible,
    this.summary,
    this.summaryformat,
    this.section,
    this.hiddenbynumsections,
    this.uservisible,
  });

  @override
  List<Object?> get props => [id,name, visible, summary, summaryformat, section, hiddenbynumsections, uservisible];

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    visible = json['visible'];
    summary = json['summary'];
    summaryformat = json['summaryformat'];
    section = json['section'];
    hiddenbynumsections = json['hiddenbynumsections'];
    uservisible = json['uservisible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['visible'] = visible;
    data['summary'] = summary;
    data['summaryformat'] = summaryformat;
    data['section'] = section;
    data['hiddenbynumsections'] = hiddenbynumsections;
    data['uservisible'] = uservisible;
    return data;
  }
}
