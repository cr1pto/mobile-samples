import 'package:flutter/material.dart';
import 'package:glob_app/data/shared_prefs.dart';
import 'package:glob_app/models/password.dart';
import 'package:glob_app/screens/password_detail.dart';
import 'package:glob_app/screens/viewable.dart';

class PasswordsScreen extends StatefulWidget implements Viewable {
 static const String widgetName = 'Passwords List';

  const PasswordsScreen({Key? key}) : super(key: key);

  @override
  _PasswordsScreenState createState() => _PasswordsScreenState();

  @override
  Widget getWidget(String name) {
    return this;
  }
}

class _PasswordsScreenState extends State<PasswordsScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();

  @override
  void initState() {
    settings.init().then((value) {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(PasswordsScreen.widgetName),
        backgroundColor: Color(settingColor),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Color(settingColor),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return PasswordDetailDialog(Password('', ''), true);
            }
          );
        }
      ),
    );
  }
}