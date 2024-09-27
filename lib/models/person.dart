import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  String email;
  String name;
  Person({
    required this.email,
    required this.name,
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source) as Map<String, dynamic>);
}
