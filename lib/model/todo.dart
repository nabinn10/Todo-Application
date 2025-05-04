// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  final String id;
  final String title;
  final String? description;
   bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.description,
     this.isCompleted = false,
  });
  
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'completed': isCompleted,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'].toString(),
      title: map['title'] as String,
      description: map['description'] != null ? map['description'] as String : null,
      isCompleted: map['completed'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source) as Map<String, dynamic>);
}
