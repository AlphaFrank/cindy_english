import 'package:flutter/material.dart';
import 'firebase/db.dart';
import 'lesson_detail_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  String lessonStr = '';

  @override
  void initState() {
    super.initState();
    fetchLessons();
  }

  fetchLessons() {
    getLessons().then((info) {
      Map<String, dynamic> tempLesson = {};
      info.forEach((date, lessons) {
        for (int i=0; i<lessons.length; i++) {
          if (!lessons[i]['lessonCompleted']) {
            lessonStr += '- ' + lessons[i]['lesson ${i+1}']['title'] + '\n';
          }
        }
      });

      setState(() {
        isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

    );
  }
}


