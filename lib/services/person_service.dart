import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/class/custom_format.dart';
import 'package:daily_planner/models/person.dart';
import 'package:daily_planner/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PersonService {
  static final PersonService _personService = PersonService._internal();

  final CollectionReference persons =
      FirebaseFirestore.instance.collection("persons");

  factory PersonService() {
    return _personService;
  }

  PersonService._internal();

  Future<Person?> getPersonByEmail(String email) async {
    QuerySnapshot querySnapshot =
        await persons.where('email', isEqualTo: email).get();
    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      Person person =
          Person.fromMap(documentSnapshot.data() as Map<String, dynamic>);
      return person;
    } else {
      return null;
    }
  }

  Future<bool> addPerson(Person person) async {
    try {
      User? user = await AuthService()
          .createUserWithEmailAndPassword(person.email, person.password);
      await persons.add(person.toMap());
      if (user == null) {
        return false;
      }
      return true;
    } catch (onError) {
      throw Exception(onError.toString());
    }
  }

  Future<Person?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    User? user =
        await AuthService().signInWithEmailAndPassword(email, password);
    if (user != null) {
      Person? person = await getPersonByEmail(email);
      return person;
    } else {
      return null;
    }
  }
}
