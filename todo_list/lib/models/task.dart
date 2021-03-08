import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task {
  Task(this.title, this.dateCreated, this.isOk);

  static Task fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  String title;
  bool isOk;
  String dateCreated;

  @override
  String toString() => '$title,$dateCreated';
}
