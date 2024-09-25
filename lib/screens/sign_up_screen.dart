import 'package:daily_planner/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
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
                  "TẠO TÀI KHOẢN",
                  style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff1A4D2E),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Cùng sắp xếp công việc của bạn",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: Color(0xff1A4D2E),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    prefixIcon: Icon(
                      Icons.person,
                      color: Color(0xff1A4D2E),
                    ),
                    context: context,
                    hintText: "Họ và tên"),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                    prefixIcon: Icon(Icons.attach_email_rounded,
                        color: Color(0xff1A4D2E)),
                    context: context,
                    hintText: "Email của bạn"),
                SizedBox(
                  height: 10,
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
                  height: 10,
                ),
                CustomTextField(
                  prefixIcon: Icon(Icons.lock, color: Color(0xff1A4D2E)),
                  context: context,
                  hintText: "Xác nhận mật khẩu",
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
                      "ĐĂNG KÝ",
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


