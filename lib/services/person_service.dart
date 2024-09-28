import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daily_planner/models/person.dart';
import 'package:daily_planner/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  Future<Person?> getCurrentPerson() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null){
      Person? currentPerson = await getPersonByEmail(currentUser.email.toString());
      return currentPerson;
    } else {
      return null;
    }
  }

  Future<bool> addPerson({required String email,required String password,required String name}) async {
    try {
      User? user = await AuthService().createUserWithEmailAndPassword(email, password);
     
      if (user != null) {
        await persons.doc(user.uid).set({
          'email': email,
          'name': name,
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Đăng ký thất bại: ${e.toString()}');
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
