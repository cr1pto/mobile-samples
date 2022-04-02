import 'package:flutter/material.dart';
import 'package:glob_app/models/bible.dart';
import 'package:glob_app/screens/chapter_screen.dart';
import 'package:glob_app/shared/menu_bar.dart';

class ChaptersScreen extends StatefulWidget {
  final List<CHAPTER> chapters;
  final String bookName;
  const ChaptersScreen(this.bookName, this.chapters, {Key? key}) : super(key: key);

  @override
  _ChaptersScreenState createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  late Widget chaptersWidget;
  @override
  void initState() {
    setState(() {
      List<Widget> allChapters = [];

      for(CHAPTER chapter in widget.chapters) {
        allChapters.add(
            ListTile(
                title: Text(chapter.sCnumber ?? ''),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ChapterScreen(widget.bookName, chapter)));
                }
            )
        );
      }

       chaptersWidget = ListView(
          children: allChapters
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      body: chaptersWidget,
    );
  }
}
