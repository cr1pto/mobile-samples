import 'package:flutter/material.dart';
import 'package:glob_app/models/bible.dart';
import 'package:glob_app/screens/verses_screen.dart';
import 'package:glob_app/shared/menu_bar.dart';

class ChapterScreen extends StatefulWidget {
  final CHAPTER chapter;
  final String bookName;
  const ChapterScreen(this.bookName, this.chapter, {Key? key}) : super(key: key);

  @override
  _ChapterScreenState createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late Widget versesWidget;
  @override
  void initState() {
    setState(() {
      versesWidget = VersesScreen('${widget.bookName} - ${widget.chapter.sCnumber}', widget.chapter.vERS);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //probably actually want a special menu drawer
      drawer: const MenuDrawer(),
      body: versesWidget
    );
  }
}
