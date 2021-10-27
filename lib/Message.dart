import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'Message.g.dart';

@JsonSerializable()
class Message {
  Message({
    required this.id,
    required this.author,
    required this.message,
  });

  String id;
  String author;
  String message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

