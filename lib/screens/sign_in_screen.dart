import 'package:daily_planner/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
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
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1A4D2E),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Và bắt đầu quản lý công việc của bạn",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: Color(0xff1A4D2E),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    prefixIcon: Icon(Icons.attach_email_rounded,
                        color: Color(0xff1A4D2E)),
                    context: context,
                    hintText: "Email của bạn"),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.lock, color: Color(0xff1A4D2E)),
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
                Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xff1A4D2E),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Text(
                      "ĐĂNG NHẬP",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xffF5EFE6),
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
}
