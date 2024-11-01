import 'package:daily_planner/class/const_variable.dart';
import 'package:daily_planner/screens/auth_screen.dart';
import 'package:daily_planner/services/auth_service.dart';
import 'package:daily_planner/theme/theme.dart';
import 'package:daily_planner/theme/theme_provider.dart';
import 'package:daily_planner/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    bool isDarkmode =
        Provider.of<ThemeProvider>(context, listen: false).themeData ==
            darkMode;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(context: context, title: "Cài đặt"),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 60),
                    padding: EdgeInsets.only(
                        top: 70, right: 10, left: 10, bottom: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Text(
                            "MÀU CHỦ ĐẠO",
                            style: PrimaryTextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        Container(
                          height: 30,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: listColorScheme.length,
                            itemBuilder: (context, index) {
                              return ChangeColorThemeButton(context, index);
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SettingFieldButton(
                          leadingIcon: Icons.dark_mode,
                          context: context,
                          title: "Chế độ sáng tối",
                          actions: SizedBox(
                            height: 40,
                            width: 50,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Switch(
                                trackOutlineWidth: WidgetStatePropertyAll(0),
                                inactiveTrackColor:
                                    Theme.of(context).colorScheme.surface,
                                value: isDarkmode,
                                activeColor:
                                    Theme.of(context).colorScheme.onSurface,
                                onChanged: (bool value) {
                                  Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .toggleTheme();
                                  setState(
                                    () {
                                      isDarkmode = !isDarkmode;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SettingFieldButton(
                          onTap: () {
                            AuthService().signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => AuthScreen(),
                                ),
                                (Route<dynamic> route) => false);
                          },
                          leadingIcon: Icons.logout,
                          context: context,
                          title: "Đăng xuất",
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/whistle-rmbg.png"),
                        ),
                        shape: BoxShape.circle,
                        color: Color(0xffffeeb5),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SettingFieldButton(
      {required BuildContext context,
      IconData? leadingIcon,
      required String title,
      Widget? actions,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              leadingIcon,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                title,
                style: PrimaryTextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ),
            actions ?? SizedBox()
          ],
        ),
      ),
    );
  }

  Widget ChangeColorThemeButton(BuildContext context, int themeIndex) {
    return GestureDetector(
      onTap: () {
        Provider.of<ThemeProvider>(context, listen: false)
            .changeColorScheme(themeIndex);
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: listColorScheme[themeIndex].primary,
        ),
      ),
    );
  }
}
