import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LessonDetailPage extends StatefulWidget {
  const LessonDetailPage({Key? key, required this.lesson}) : super(key:key);
  final Map lesson;

  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: const Color.fromRGBO(39, 133, 133, 1.0),
        toolbarHeight: 100,
        title: Column(
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:8.0),
              child: Text(
                widget.lesson['title'],
                style: TextStyle(color: Colors.white),
              ),
            )

          ],
        ),

      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.lesson['description'],
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Example: ${widget.lesson['example']}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Explanation: ${widget.lesson['explanation']}',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Rule: ${widget.lesson['rule']}',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      )
    );
  }
}