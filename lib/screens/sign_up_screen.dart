import 'package:daily_planner/class/const_variable.dart';
import 'package:daily_planner/class/custom_format.dart';
import 'package:daily_planner/models/person.dart';
import 'package:daily_planner/services/person_service.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:daily_planner/widgets/custom_text_field.dart';
import 'package:daily_planner/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    _nameController = new TextEditingController();
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _confirmPasswordController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: Form(
            key: _formKey,
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
                        image: AssetImage(
                            "assets/images/note-removebg-preview.png"),
                      ),
                    ),
                  ),
                  Text(
                    "TẠO TÀI KHOẢN",
                    style: PrimaryTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Cùng sắp xếp công việc của bạn",
                    style: PrimaryTextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      controller: _nameController,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      context: context,
                      hintText: "Họ và tên"),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Tên phải lớn hơn 3 kí tự",
                      style: PrimaryTextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                      controller: _emailController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("^[\u0000-\u007F]+\$"))
                      ],
                      prefixIcon: Icon(
                        Icons.attach_email_rounded,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      context: context,
                      hintText: "Email của bạn"),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _passwordController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("^[\u0000-\u007F]+\$"))
                    ],
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
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Mật khẩu của bạn phải bao gồm:  " +
                          "\n    - Ít nhất 6 kí tự  " +
                          "\n    - Kí tự chữ a-z \n    - Kí tự in hoa A-Z  " +
                          "\n    - Kí tự số 0-9 \n    - Kí tự đặc biệt !, @, #, \$, %, \...",
                      style: PrimaryTextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp("^[\u0000-\u007F]+\$"))
                    ],
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
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
                  GestureDetector(
                    onTap: () {
                      ValidAndCreatePerson();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(
                        child: Text(
                          "ĐĂNG KÝ",
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
      ),
    );
  }

  void ValidAndCreatePerson() async {
    if (_formKey.currentState!.validate()) {}
    final String _email = _emailController.text.toString().trim();
    final String _name = _nameController.text.toString().trim();
    final String _password = _passwordController.text.toString().trim();
    final String _confirmPassword =
        _confirmPasswordController.text.toString().trim();
    if (_name.length < 3) {
      WarningToast(
        context: context,
        message: "Sai định dạng tên",
      ).ShowToast();
      return;
    }

    if (!_email.isValidEmail()) {
      WarningToast(
        context: context,
        message: "Sai định dạng email",
      ).ShowToast();
      return;
    }

    if (!_password.isValidPassword()) {
      WarningToast(
        context: context,
        message: "Sai định dạng mật khẩu",
      ).ShowToast();
      return;
    }

    if (_confirmPassword != _password) {
      WarningToast(
        context: context,
        message: "Xác nhận mật khẩu không trùng khớp",
      ).ShowToast();
      return;
    }

    Person? person = await PersonService().getPersonByEmail(_email);
    if (person != null) {
      WarningToast(
        context: context,
        message: "Tài khoản với email đã tồn tại.",
      ).ShowToast();
      return;
    }
    try {
      bool addSuccess = await PersonService()
          .addPerson(name: _name, email: _email, password: _password);

      if (addSuccess) {
        SuccessToast(
          context: context,
          message: "Tạo tài khoản thành công",
        ).ShowToast();
      } else {
        WarningToast(
          context: context,
          message: "Đã có lỗi xảy ra khi tạo tài khoản",
        ).ShowToast();
      }
    } catch (e) {
      WarningToast(
        context: context,
        message: e.toString(),
      ).ShowToast();
      return;
    }
    // Navigation to Sign in screen
  }
}
