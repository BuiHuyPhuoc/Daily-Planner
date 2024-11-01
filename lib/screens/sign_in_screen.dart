// ignore_for_file: must_be_immutable

import 'package:daily_planner/class/const_variable.dart';
import 'package:daily_planner/models/person.dart';
import 'package:daily_planner/screens/auth_screen.dart';
import 'package:daily_planner/screens/navigation_screen.dart';
import 'package:daily_planner/services/person_service.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:daily_planner/widgets/custom_text_field.dart';
import 'package:daily_planner/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key, this.email = "", this.password = ""});

  String email;
  String password;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isObscure = true;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _emailController.text = widget.email;
    _passwordController.text = widget.password;
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          context: context,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/note-removebg-preview.png"),
                    ),
                  ),
                ),
                Text(
                  "ĐĂNG NHẬP",
                  style: PrimaryTextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Và bắt đầu quản lý công việc của bạn",
                  style: PrimaryTextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("^[\u0000-\u007F]+\$"),
                      )
                    ],
                    obscureText: false,
                    enableSuggestions: false,
                    controller: _emailController,
                    prefixIcon: Icon(
                      Icons.attach_email_rounded,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    context: context,
                    hintText: "Email của bạn"),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _passwordController,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  context: context,
                  hintText: "Nhập mật khẩu",
                  obscureText: _isObscure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => ValidateAccountAndSignIn(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        "ĐĂNG NHẬP",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ValidateAccountAndSignIn() async {
    final String _email = _emailController.text.toString().trim();
    final String _password = _passwordController.text.toString().trim();
    if (_email.isEmpty ||
        _email.length == 0 ||
        _password.isEmpty ||
        _password.length == 0) {
      WarningToast(
        context: context,
        message: "Vui lòng nhập đủ thông tin",
      ).ShowToast();
      return;
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          );
        },
      );
      Person? person = await PersonService()
          .signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.pop(context);
      if (person != null) {
        SuccessToast(
          context: context,
          message: "Đăng nhập thành công",
        ).ShowToast();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AuthScreen(),
            ),
            (Route<dynamic> route) => false);
      } else {
        WarningToast(
          context: context,
          message: "Đăng nhập thất bại",
        ).ShowToast();
      }
    }
  }
}
