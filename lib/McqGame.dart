import 'package:flutter/material.dart';
import 'package:gamifiedquran/CardGame.dart';
import 'package:gamifiedquran/WordsLearnGeneric.dart';
import 'constants.dart';
import 'package:gamifiedquran/QuizCard.dart';
import 'dart:async';
import 'dart:math';

class McqGame extends StatefulWidget {
  final List<Map> wordList;
  final quizWords;
  final order;
  final int incorrect;
  McqGame(this.wordList,this.quizWords,this.order,this.incorrect);
  @override
  _McqGameState createState() => _McqGameState();
}

class _McqGameState extends State<McqGame> {
  List<Widget> cards;
  List<int> answer;
  List colors = [
    Colors.grey[300],
    Colors.grey[300],
    Colors.grey[300],
    Colors.grey[300],
  ];
  bool shuffled=false;
  List<String> cardContent;
  String questionType;
  String answerType;
  Function operation;
  int incorrect;

  void cardPressed(int index){
    if(answer[index]==1){
      colors[index] = Colors.green;
      Timer timer = new Timer(new Duration(milliseconds: 700), () {
        if (widget.order==0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    McqGame(widget.wordList, widget.quizWords, 1,incorrect),
              ));
        } else {
          operation = () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CardGame(widget.wordList,widget.quizWords.sublist(2),2,incorrect),
                ));
          };
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WordsLearnGeneric(
                    widget.wordList,
                    widget.quizWords.sublist(2),
                    "These are some words and meanings. \n Try learning them for another card game.",
                    operation,
                    2),
              ));
        }
      });
    } else {
      incorrect++;
      colors[index] = Colors.red[300];
      Timer timer = new Timer(new Duration(milliseconds: 500), () {
        setState(() {
          colors[index] = Colors.grey[300];
        });
      });
    }
  }

  void shuffleCards() {
    if (shuffled == false) {
      shuffled = true;
      var random = new Random();

      for (var i = cardContent.length - 1; i > 0; i--) {
        var n = random.nextInt(i + 1);

        var temp = cardContent[i];
        cardContent[i] = cardContent[n];
        cardContent[n] = temp;

        var temp1 = answer[i];
        answer[i] = answer[n];
        answer[n] = temp1;
      }
    }
  }

  void setupCards(){
    String tempWord;
    if(widget.order==0){
      tempWord=widget.wordList[widget.quizWords[0]][questionType];
    } else {
      tempWord=widget.wordList[widget.quizWords[1]][questionType];
    }
    String heading;
    if(widget.order==0){
      heading = "Choose its correct meaning.";
    } else {
      heading = "Choose the correct word for it.";
    }

    cards.add(QuizCard(tempWord,false,Colors.grey[300]));
    cards.add(Text(
      heading,
      textAlign: TextAlign.center,
      style: kQuizExplanationStyle,
    ),);
    for(int i=0;i<4;i++){
      cards.add(
        GestureDetector(
          child: QuizCard(cardContent[i], true, colors[i]),
          onTap: () {
            setState(() {
              cardPressed(i);
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.order==0){
      questionType="Uthmani";
      answerType="Urdu";
    } else {
      answerType="Uthmani";
      questionType="Urdu";
    }
    if (shuffled == false) {
      incorrect=widget.incorrect;
      cardContent = [
        widget.wordList[widget.quizWords[0]][answerType],
        widget.wordList[widget.quizWords[1]][answerType],
        widget.wordList[widget.quizWords[2]][answerType],
        widget.wordList[widget.quizWords[3]][answerType],
      ];
      if (widget.order==0){
        answer = [1,0,0,0];
      } else {
        answer = [0,1,0,0];
      }
    }
    cards=new List<Widget>();
    String heading;
    if(widget.order==0){
      heading = "Here is a word from last page.";
    } else {
      heading = "Here is a meaning from last page.";
    }

    cards.add(Text(
      heading,
      textAlign: TextAlign.center,
      style: kQuizExplanationStyle,
    ),);
    shuffleCards();
    setupCards();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: cards,
        ),
      ),
    );
  }
}
