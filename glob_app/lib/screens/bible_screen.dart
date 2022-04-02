import 'package:flutter/material.dart';
import 'package:glob_app/models/bible.dart';
import 'package:glob_app/screens/books_screen.dart';
import 'package:glob_app/services/bible.service.dart';

import '../data/sembast_db.dart';
import '../data/shared_prefs.dart';
import '../shared/menu_bar.dart';

class BibleScreen extends StatefulWidget {
  final String widgetName = 'Bible';
  final BibleService bibleService = BibleService();
  @override
  _BibleScreenState createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  int settingColor = 0xff1976d2;
  double fontSize = 16;
  SPSettings settings = SPSettings();
  SembastDb sembastDb = SembastDb();
  Bible? bible;
  String bibleText = '';
  late Widget booksWidget;

  @override
  void initState() {
    settings.init().then((value) async {
      bible = await widget.bibleService.loadAsset();
      setState(() {
        settingColor = settings.getColor();
        fontSize = settings.getFontSize();
        booksWidget = buildBibleView(context, bible);
      });
    });
    super.initState();
  }

  Widget buildBibleView(BuildContext context, Bible? bible) {
    List<BIBLEBOOK> books = [];

    for (BIBLEBOOK book in bible!.xMLBIBLE!.bIBLEBOOK) {
      books.add(book);
    }

    return BooksScreen(settingColor, fontSize, books);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.widgetName),
        backgroundColor: Color(settingColor),
      ),
      drawer: const MenuDrawer(),
      body: buildBibleView(context, bible),
    );
  }
}
