import 'package:flutter/material.dart';
import 'package:glob_app/data/sembast_db.dart';
import 'package:glob_app/data/shared_prefs.dart';
import 'package:glob_app/models/password.dart';
import 'package:glob_app/screens/password_detail.dart';
import 'package:glob_app/screens/viewable.dart';
import 'package:glob_app/shared/menu_bar.dart';

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
  SembastDb sembastDb = SembastDb();
  List<Password> passwords = <Password>[];
  late List<Widget> allPasswords = <Widget>[];

  @override
  void initState() {
    settings.init().then((value) async {
      passwords = await sembastDb.getPasswords();
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        allPasswords = buildPasswordView(context);
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
      drawer: const MenuDrawer(),
      body: ListView(
        children: buildPasswordView(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Color(settingColor),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              Password pwd = Password('', '');
              return PasswordDetailDialog(pwd, true, sembastDb);
            }
          );
        }
      ),
    );
  }

  List<Widget> buildPasswordView(BuildContext parentContext) {
    List<ListTile> allPasswords = <ListTile>[];
    for(Password pwd in passwords){
      allPasswords.add(ListTile(
        title: Text(pwd.name),
        onLongPress: () {
          showDialog(
            context: parentContext,
            builder: (context) {
              return AlertDialog(
                title: Text('Delete ${pwd.name}?'),
                actions: [
                  TextButton(
                      child: Text('Delete'),
                      onPressed: () async {
                        await sembastDb.deletePassword(pwd);
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => PasswordsScreen()));
                      }),
                  TextButton(
                      onPressed: () => Navigator.pop(context), child: Text('Cancel'))
                ],
              );
            });
        },
        onTap: () {
          showDialog(
            context: parentContext,
            builder: (context) {
              return PasswordDetailDialog(Password(pwd.name, pwd.password), false, sembastDb);
            }
          );
        },
      ));
    }
    return allPasswords;
  }
}