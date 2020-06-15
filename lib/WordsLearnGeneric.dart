import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:gamifiedquran/QuizCard.dart';

class WordsLearnGeneric extends StatefulWidget {
  final List<Map> wordList;
  final quizWords;
  final String heading;
  final Function operation;
  final int wordsToDisplay;
  WordsLearnGeneric(this.wordList,this.quizWords,this.heading,this.operation,this.wordsToDisplay);

  @override
  _WordsLearnGenericState createState() => _WordsLearnGenericState();
}

class _WordsLearnGenericState extends State<WordsLearnGeneric> {
  List<Widget> cards;

  void setupCards(){

    for(int i=0;i<widget.wordsToDisplay;i++){
      String tempWord=widget.wordList[widget.quizWords[i]]["Uthmani"]+'\n'+widget.wordList[widget.quizWords[i]]["Urdu"];
      cards.add(QuizCard(tempWord,false,Colors.grey[300]));
    }
  }

  @override
  Widget build(BuildContext context) {
    cards=new List<Widget>();

    cards.add(Text(
      widget.heading,
      textAlign: TextAlign.center,
      style: kQuizExplanationStyle,
    ),);

    setupCards();

    cards.add(RaisedButton(
        color: Colors.green,
      shape: kRoundShape,
        onPressed: widget.operation,
        child: Text(
          "Next",
          style: kButtonStyle,
        )),);

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: cards
          ),
        ));
  }
}
