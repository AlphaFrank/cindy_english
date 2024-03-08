import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'firebase/db.dart';

class GenerateLessonPage extends StatefulWidget {
  const GenerateLessonPage({Key? key}) : super(key: key);

  @override
  State<GenerateLessonPage> createState() => _GenerateLessonPageState();
}

class _GenerateLessonPageState extends State<GenerateLessonPage>{
  late final OpenAI _openAI;
  List questions = [];

  @override
  void initState() {
    super.initState();
    _openAI = OpenAI.instance.build(
      token: "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",
      //token : dotenv.env['OPENAI_API_KEY'],
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 30),
      ),
    );
    gptFunctionCalling();
  }

  Future<String> getInfo() async {
    String userInfo = '';
    var info = await getMyInfo();
    userInfo = 'Age: ${info!['age']}. ';
    userInfo += 'Extra info: ${info['info']}. ';
    userInfo += 'I have these lessons: ${fetchLessons(info)}. Please do not create the same lessons.';
    return userInfo;
  }

  fetchLessons(info) {
    String lessonStr = '';

    if (info.containsKey('lessons')) {
      info['lessons'].forEach((key, lessons) {
        for (int i=0; i<lessons.length; i++){
          print(lessons[i]['lesson ${i+1}']['title']);
          lessonStr += lessons[i]['lesson ${i+1}']['title'] + ',';
        }

      });
    } else {
      lessonStr = 'No lessons';
    }

    return lessonStr;
  }



  void gptFunctionCalling() async {
    String info = await getInfo();
    String instrctionPrompt =
        "create a list of english grammar lessons with their correspond filling the blank quiz with at least 5 questions"
        " based on my personal inforamtion $info. Please return only"
        " a json format that looks like this [{'lesson 1': {'title':<title>,"
        "'description':<description>, 'example':<exmaple>, 'explanation':"
        "<explanation>, 'rule':<rule>}, 'quiz 1': [{'question': <filling the blank question for one of the words>,"
        "'answer':<answer>, 'options:<list of four options in which one of them should be the answer>}] }]."
        "Please give me only the json format as an output and do not write anything"
        " before or after the json format.";
    final request = ChatCompleteText(
      messages: [
        Messages(
          role: Role.system,
          content: instrctionPrompt,
        ),
      ],
      maxToken: 2500,
      model: GptTurbo0631Model(),

    );

    ChatCTResponse? response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      String? stringList = element.message?.content;
      setState(() {
        questions = jsonDecode(stringList!);
        saveLessons();
      });
    }

  }

  void saveLessons() {
    DateTime now = DateTime.now();

    for (var question in questions) {
      question['quizScore'] = 0;
      question['lessonCompleted'] = false;
    }

    String formattedDate =
        "${now.month}/${now.day}/${now.year} ${now.hour}:${now.minute}";
    addLessons({formattedDate: questions});
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
                'Generate Lesson',
                style: TextStyle(color: Colors.white),
              )
            )
          ],
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: questions.isEmpty
              ? const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          )
              : ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: questions.length,
            itemBuilder: (BuildContext context, int index){
              String key = 'lesson ${index+1}';
              return Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Card(
                  child: Center(
                    child: ListTile(
                      title: Text(
                        key.toUpperCase(),
                      ),
                      subtitle: Text(
                        ' ${questions[index][key]['title']}'
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        )
      )
    );
  }

}