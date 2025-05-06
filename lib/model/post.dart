// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Post {
  final String userId;
  final String id;
  final String title;
  final String body;

  Post({
    required this.userId;
      required this.id,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'] as String,
      id: map['id'] as String,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source) as Map<String, dynamic>);
}
