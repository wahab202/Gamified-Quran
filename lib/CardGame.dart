import 'package:flutter/material.dart';
import 'package:gamifiedquran/AccuracyScreen.dart';
import 'package:gamifiedquran/WordsLearnGeneric.dart';
import 'constants.dart';
import 'package:gamifiedquran/QuizCard.dart';
import 'dart:math';
import 'dart:async';
import 'McqGame.dart';

class CardGame extends StatefulWidget {
  final List<Map> wordList;
  final List quizWords;
  final int numOfCards;
  final incorrect;
  CardGame(this.wordList, this.quizWords,this.numOfCards,this.incorrect);
  @override
  _CardGameState createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {
  List<String> cardContent;
  List<int> answer;
  List<Widget> cards;
  List<int> removeCards = [0, 0, 0, 0, 0, 0, 0, 0];
  bool shuffled = false;
  Function operation;
  int correct=0;
  int incorrect=0;
  List quizwords= new List();


  List colors = [
    Colors.grey[300],
    Colors.grey[300],
    Colors.grey[300],
    Colors.grey[300],
    Colors.grey[300],
    Colors.grey[300],
    Colors.grey[300],
    Colors.grey[300]
  ];
  int pressedCards = 0;

  void cardPressed(index) {
    if (colors[index] != Colors.green) {
      colors[index] = Colors.green;
      pressedCards++;
    } else {
      colors[index] = Colors.grey[300];
      pressedCards--;
    }
    if (pressedCards == 2) {
      pressedCards = 0;
      List indices = new List();
      int i = 0;
      for (Color c in colors) {
        if (c == Colors.green) {
          indices.add(i);
        }
        i++;
      }
      if (answer[indices[0]] == answer[indices[1]]) {
        correct++;
        colors[indices[0]] = Colors.green[200];
        colors[indices[1]] = Colors.green[200];
        Timer timer = new Timer(new Duration(milliseconds: 200), () {
          setState(() {
            removeCards[indices[0]] = 1;
            removeCards[indices[1]] = 1;
            navigateToNext();
          });
        });


      } else {
        colors[indices[0]] = Colors.red[300];
        colors[indices[1]] = Colors.red[300];
        Timer timer = new Timer(new Duration(milliseconds: 200), () {
          setState(() {
            colors[indices[0]] = Colors.grey[300];
            colors[indices[1]] = Colors.grey[300];
          });
        });
        incorrect++;
      }
    }
  }

  void navigateToNext(){
    if (correct == widget.numOfCards) {
      if (widget.numOfCards == 4) {
        operation = () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    McqGame(
                        widget.wordList, quizwords.sublist(4), 0,incorrect),
              ));
        };
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  WordsLearnGeneric(
                      widget.wordList,
                      quizwords.sublist(4),
                      "These are some words and meanings. \n Try learning them for an MCQ game next.",
                      operation,
                      2),
            ));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AccuracyScreen(incorrect),
            ));
      }
    }
  }

  void setupCards() {
    cards.add(
      Text(
        "Your goal is to match words to their meanings.",
        textAlign: TextAlign.center,
        style: kQuizExplanationStyle,
      ),
    );
    for (int i = 0; i < (widget.numOfCards*2); i++) {
      if (removeCards[i] == 0) {
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
      } else {
        cards.add(
          QuizCard('', false, Colors.grey[50]),
        );
      }
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

  @override
  Widget build(BuildContext context) {
    cards = new List<Widget>();
    quizwords = widget.quizWords;
    if(widget.quizWords!=null) {
      if (widget.quizWords.length > 0) {
        if (shuffled == false) {
          cardContent = new List<String>();
          incorrect = widget.incorrect;
          for (int i = 0; i < widget.numOfCards; i++) {
            cardContent.add(widget.wordList[widget.quizWords[i]]["Uthmani"]);
          }
          for (int i = 0; i < widget.numOfCards; i++) {
            cardContent.add(widget.wordList[widget.quizWords[i]]["Urdu"]);
          }
          if (widget.numOfCards == 4) {
            answer = [0, 1, 2, 3, 0, 1, 2, 3];
          } else {
            answer = [0, 1, 0, 1];
          }
        }
      }
    }

    shuffleCards();
    setupCards();

    return Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: cards));
  }
}
