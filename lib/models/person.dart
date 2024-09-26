import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  String email;
  String name;
  String password;
  Person({
    required this.email,
    required this.name,
    required this.password,
  });
  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'password': password,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      email: map['email'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source) as Map<String, dynamic>);
}
