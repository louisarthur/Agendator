// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    json['title'] as String,
    json['dateCreated'] as String,
    json['isOk'] as bool,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'title': instance.title,
      'isOk': instance.isOk,
      'dateCreated': instance.dateCreated,
    };
