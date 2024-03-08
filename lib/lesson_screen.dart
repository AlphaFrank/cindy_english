import 'package:wordology_app/firebase/db.dart';
import 'package:wordology_app/lesson_detail_screen.dart';

import 'generateLesson.dart';
import 'package:flutter/material.dart';


class LessonPage extends StatefulWidget {
  const LessonPage({Key? key}) : super(key: key);

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  Map<String, dynamic> lessons = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getMyLessons();
  }

  getMyLessons() {
    getLessons().then((value) {
      setState(() {
        lessons = value;
        isLoading = false;
      });
    });
  }

  void updateCurrentLesson() {
    updateLesson(lessons);
  }

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
            const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  'Lesson',
                  style: TextStyle(color: Colors.white),
                ),
            )
          ],
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: isLoading
              ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          )
              : lessons.isEmpty
              ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text('No lessons')],
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: lessons.length,
            itemBuilder: (BuildContext context, int index) {
              String date = lessons.keys.elementAt(index);
              return Card(
                child: ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Generated on $date'),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: lessons[date].length,
                      itemBuilder:
                        (BuildContext context, int index) {
                        String key = 'lesson ${index+1}';
                        return Padding(
                          padding:
                            const EdgeInsets.only(top: 8.0),
                          child: Card(
                            color: Color.fromRGBO(
                              203, 241, 236, 1.0),
                            child: Center(
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    lessons[date][index]['lessonCompleted'] = true;

                                  });

                                  updateCurrentLesson();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LessonDetailPage(
                                                lesson: lessons[date][index][key])
                                    )
                                  );

                                },
                                title: Text(
                                  key.toUpperCase(),
                                ),
                                trailing: lessons[date][index]['lessonCompleted']
                                ? Icon(Icons.check)
                                : Icon(Icons.clear),
                                subtitle: Text(
                                  ' ${lessons[date][index][key]['title']}'
                                ),

                              ),
                            ),
                          ),
                        );
                      }
                    )
                  ],

                )
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                    const GenerateLessonPage()))
                .then((value) => getMyLessons());
          },
          label: const Text('Generate Lessons'),
          icon: const Icon(Icons.generating_tokens),
      ),

    );
  }




}



