import 'package:flutter/material.dart';
import 'package:gamifiedquran/DatabaseManager.dart';
import 'constants.dart';
import 'package:gamifiedquran/QuizCard.dart';
import 'dart:async';
import 'package:gamifiedquran/CardGame.dart';

class QuizLearnScreen extends StatefulWidget {
  final int level;
  QuizLearnScreen(this.level);

  @override
  _QuizLearnScreenState createState() => _QuizLearnScreenState();
}

class _QuizLearnScreenState extends State<QuizLearnScreen> {
  List<Map> wordList;
  List quizWords;
  DatabaseManager databaseManager;
  String word1 = '';
  String word2 = '';
  String word3 = '';
  String word4 = '';
  bool buttonDisabled = true;
  int level;

  void setupWords() async {
    level = widget.level;
    databaseManager = DatabaseManager();
    wordList = await databaseManager.initializeDb();
    getRandomWords();
    if (!mounted) return;
    setState(() {
      word1 = wordList[quizWords[0]]["Uthmani"] +
          '\n' +
          wordList[quizWords[0]]["Urdu"];
      word2 = wordList[quizWords[1]]["Uthmani"] +
          '\n' +
          wordList[quizWords[1]]["Urdu"];
      word3 = wordList[quizWords[2]]["Uthmani"] +
          '\n' +
          wordList[quizWords[2]]["Urdu"];
      word4 = wordList[quizWords[3]]["Uthmani"] +
          '\n' +
          wordList[quizWords[3]]["Urdu"];
    });
    Timer timer = new Timer(new Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        buttonDisabled=false;
      });
    });
  }

  void getRandomWords() {
    quizWords.add(0+(8*level));
    quizWords.add(1+(8*level));
    quizWords.add(2+(8*level));
    quizWords.add(3+(8*level));
    quizWords.add(4+(8*level));
    quizWords.add(5+(8*level));
    quizWords.add(6+(8*level));
    quizWords.add(7+(8*level));
  }

  @override
  Widget build(BuildContext context) {
    quizWords = new List();
    setupWords();
    return Scaffold(
        body: Center(
      child: Column(
        children: <Widget>[
          Spacer(),
          Text(
            "These are some words and meanings. \n Try learning them for a card game next.",
            textAlign: TextAlign.center,
            style: kQuizExplanationStyle,
          ),
          Spacer(),
          QuizCard(word1,false,Colors.grey[300]),
          Spacer(),
          QuizCard(word2,false,Colors.grey[300]),
          Spacer(),
          QuizCard(word3,false,Colors.grey[300]),
          Spacer(),
          QuizCard(word4,false,Colors.grey[300]),
          Spacer(),
          RaisedButton(
            color: Colors.green,
            shape: kRoundShape,
            onPressed: buttonDisabled ? null : (){
              if(wordList.isNotEmpty) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) =>
                      CardGame(wordList, quizWords, 4, 0)),
                );
              }
            },
              child: Text(
            "Next",
            style: kButtonStyle,
          )),
          Spacer(),
        ],
      ),
    ));
  }
}
