import 'package:flutter/material.dart';
import 'package:glob_app/data/shared_prefs.dart';
import 'package:glob_app/screens/bible_screen.dart';
import 'package:glob_app/screens/home.dart';
import 'package:glob_app/screens/memos.dart';
import 'package:glob_app/screens/passwords.dart';
import 'package:glob_app/screens/settings.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  SPSettings settings = SPSettings();
  int settingColor = 0xff1976d2;
  double fontSize = 16;

  List<Widget> buildMenuItems(BuildContext context) {
    final List<String> menuTitles = [
      'Home',
      'Memos',
      'Passwords',
      'My Network',
      'Bible',
      'Settings'
    ];

    List<Widget> menuItems = [];
    menuItems.add(DrawerHeader(
        decoration: BoxDecoration(color: Color(settingColor)),
        child: const Text('Globo Fitness',
            style: TextStyle(color: Colors.white, fontSize: 28))));
    //iterate through all menuItems and assign title to widgets
    for (var element in menuTitles) {
      Widget screen = Container();
      menuItems.add(ListTile(
        title: Text(element, style: TextStyle(fontSize: fontSize)),
        onTap: () {
          // screen = Viewable().getWidget(element)
          switch (element) {
            case 'Home':
              screen = HomeScreen();
              break;
            case 'Memos':
              screen = const MemoScreen();
              break;
            case 'Passwords':
              screen = const PasswordsScreen();
              break;
            case 'Bible':
              screen = BibleScreen();
              break;
            case 'Settings':
              screen = const SettingsScreen();
              break;
          }
          
          // pop the stack so that the drawer doesn't open up again since it gets pushed onto the navigation route stack
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => screen));
        },
      ));
    }
    return menuItems;
  }

  @override
  void initState() {
    settings.init().then((value) => {
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: buildMenuItems(context),
        ));
  }
}
