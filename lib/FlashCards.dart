import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:gamifiedquran/constants.dart';
import 'dart:math';
import 'package:gamifiedquran/CardGame.dart';

class FlashCards extends StatefulWidget {
  final List<Map> wordList;
  final int words;
  FlashCards(this.wordList, this.words);
  @override
  _FlashCardsState createState() => _FlashCardsState();
}

class _FlashCardsState extends State<FlashCards> {
  List<int> indexes = new List<int>();
  String word = ".";
  String meaning = ".";
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  int cardState = 0;
  String bottomText = "<-----  Swipe for next card";
  int cardNumber = 0;
  List quizWords = new List();
  double opacityValue = 0.0;

  Widget getCard(String text, String heading, Color textColor, Color color) {
    return Dismissible(
      resizeDuration: null,
      onDismissed: (DismissDirection direction) {
        setState(() {
          if (cardNumber < 8) {
            setCard();
            if (cardState == 1) {
              cardKey.currentState.toggleCard();
              cardState = 0;
            }
            bottomText = "Cards: $cardNumber/8";
          }
        });
      },
      key: new ValueKey(word),
      child: GestureDetector(
        onTap: () {
          if (cardState == 0) {
            cardState = 1;
          } else {
            cardState = 0;
          }
          cardKey.currentState.toggleCard();
        },
        child: Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 2,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: color,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  heading,
                  style: TextStyle(
                      fontSize: 30, color: textColor, fontFamily: 'Balsamiq'),
                  textAlign: TextAlign.center,
                ),
                Text(
                  text,
                  style: TextStyle(fontSize: 40, color: textColor),
                  textAlign: TextAlign.center,
                ),
              ],
            )),
      ),
    );
  }

  void setCard() {
    setState(() {
      Random random = new Random();
      int randomNumber = random.nextInt(widget.words);
      word = widget.wordList[randomNumber]["Uthmani"];
      meaning = widget.wordList[randomNumber]["Urdu"];
      quizWords.add(randomNumber);
    });
    cardNumber++;
    if (cardNumber==8) {
      setState(() {
        opacityValue = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (word == ".") {
      setCard();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Spacer(),
            Expanded(
              flex: 2,
                child: Text(
              "Tap to FLIP the card",
              style: kQuizCardTextStyle,
            )),
            Expanded(
              flex: 4,
              child: FlipCard(
                key: cardKey,
                flipOnTouch: false,
                direction: FlipDirection.HORIZONTAL, // default
                front: getCard(word, "WORD", Colors.white, Colors.green[300]),
                back:
                    getCard(meaning, "MEANING", Colors.black, Colors.grey[300]),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
                child: Text(
              bottomText,
              style: kGreyButtonFont,
            )),
            Expanded(
              flex: 2,
              child: Opacity(
                opacity: opacityValue,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Colors.grey[200],
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Opacity(
                        opacity: opacityValue,
                        child: Text(
                          "You reached the end of flashcards.\nDo you want a test for the words ?",
                          textAlign: TextAlign.center,
                          style: kQuizCardTextStyle,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Opacity(
                            opacity: opacityValue,
                            child: RaisedButton(
                                color: Colors.green[200],
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CardGame(widget.wordList,quizWords,4,0)),
                                  );
                                },
                                child: Text(
                                  "Yes",
                                  style: kButtonStyle,
                                )),
                          ),
                          Opacity(
                            opacity: opacityValue,
                            child: RaisedButton(
                                color: Colors.red[200],
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "No",
                                  style: kButtonStyle,
                                )),
                          ),
                    ],
                  ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
