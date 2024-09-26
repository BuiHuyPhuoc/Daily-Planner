import 'package:daily_planner/class/custom_format.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final AuthService _authService = AuthService._internal();

  factory AuthService() {
    return _authService;
  }

  AuthService._internal();

  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      String hashPassword = StringFormat.toSha256String(password);
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: hashPassword);
      return cred.user;
    } catch (e) {
      throw Exception("Lỗi xảy ra khi tạo tài khoản");
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      String hashPassword = StringFormat.toSha256String(password);
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: hashPassword);
      return cred.user;
    } catch (e) {
      print("Something went wrong");
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      _auth.signOut();
    } catch (e) {
      print("Something went wrong");
    }
  }
}
