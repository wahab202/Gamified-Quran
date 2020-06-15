import 'package:flutter/material.dart';
import 'package:gamifiedquran/DatabaseManager.dart';
import 'constants.dart';
import 'package:gamifiedquran/QuizCard.dart';
import 'dart:async';
import 'package:gamifiedquran/CardGame.dart';

class ReadQuran extends StatefulWidget {
  final List<Map> wordList;
  ReadQuran(this.wordList);
  @override
  _ReadQuranState createState() => _ReadQuranState();
}

class _ReadQuranState extends State<ReadQuran> {
  List<Map> wordList;
  List<int> rowIndex = new List<int>();
  bool firstTime = true;
  DatabaseManager databaseManager;
  var wordIndex = 0;
  var meaning = "Press on any word to see its meaning.";
  int wordsPerRow = 4;
  int linePerPage = 13;

  List<Widget> getRow(int index) {
    List<Widget> lst;
    lst = new List<Widget>();

    lst.add(GestureDetector(
      child: Text(wordList[index+3]["Uthmani"],
        style: kReadQuranTextStyle,
        textAlign: TextAlign.center,),
      onTap: (){
        showMeaning(wordList[index+3]["Urdu"]);
      },
    ));
    lst.add(GestureDetector(
      child: Text(wordList[index+2]["Uthmani"],
        style: kReadQuranTextStyle,
        textAlign: TextAlign.center,),
      onTap: (){
        showMeaning(wordList[index+2]["Urdu"]);
      },
    ));
    lst.add(GestureDetector(
      child: Text(wordList[index+1]["Uthmani"],
        style: kReadQuranTextStyle,
        textAlign: TextAlign.center,),
      onTap: (){
        showMeaning(wordList[index+1]["Urdu"]);
      },
    ));
    lst.add(GestureDetector(
      child: Text(wordList[index]["Uthmani"],
        style: kReadQuranTextStyle,
        textAlign: TextAlign.center,),
      onTap: (){
        showMeaning(wordList[index]["Urdu"]);
      },
    ));

    return lst;
  }

  void showMeaning(String meaning1) {
    setState(() {
      meaning = meaning1;
    });
  }

  void turnPage() {
    int mul = wordsPerRow * linePerPage;
    setState(() {
      for (int i = 0; i < linePerPage; i++) {
        rowIndex[i] += mul;
      }
    });
  }

  void turnPageBack() {
    if(rowIndex[0]!=0){
      int mul = wordsPerRow * linePerPage;
      setState(() {
        for (int i = 0; i < linePerPage; i++) {
          rowIndex[i] -= mul;
        }
      });
    }
  }

  void setupIndex() {
    int itmp = 0;
    for (int i = 0; i < linePerPage; i++) {
      rowIndex.add(itmp);
      itmp += wordsPerRow;
    }
  }

  List<Widget> getPage() {
    List<Widget> lst = new List<Widget>();
    for (int i = 0; i < linePerPage; i++) {
      lst.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: getRow(rowIndex[i]),
      ));
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    wordList = widget.wordList;
    if (firstTime) {
      setupIndex();
      firstTime = false;
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            meaning,
            style: kReadQuranMeaningStyle,
            textAlign: TextAlign.center,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getPage(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                  color: Colors.transparent,
                  onPressed: () {
                    turnPage();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.arrow_back_ios, color: Colors.grey[700]),
                      Text(
                        "Next Page",
                        style: kGreyButtonFontSmall,
                      )
                    ],
                  )
              ),
              FlatButton(
                  color: Colors.transparent,
                  onPressed: () {
                    turnPageBack();
                  },
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Previous Page",
                        style: kGreyButtonFontSmall,
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey[700])
                    ],
                  )
              ),
            ],
          )
        ],
      ),
    );
  }
}
