import 'package:flutter/material.dart';
import 'package:gamifiedquran/DashBoard.dart';
import 'package:gamifiedquran/SharedPrefManager.dart';
import 'package:gamifiedquran/constants.dart';
import 'package:gamifiedquran/InstructionScreen.dart';

class ExpertiseLevelScreen extends StatefulWidget {
  @override
  _ExpertiseLevelScreenState createState() => _ExpertiseLevelScreenState();
}

class _ExpertiseLevelScreenState extends State<ExpertiseLevelScreen> {
  SharedPrefManager prefManager;
  List colors = [
    Colors.grey[50],
    Colors.grey[50],
    Colors.grey[50],
  ];
  int value=0;

  void buttonPressed(int index){
    value=index;
    colors[0]=Colors.grey[50];
    colors[1]=Colors.grey[50];
    colors[2]=Colors.grey[50];
    setState(() {
      colors[index]=Colors.green[300];
    });
  }


  @override
  Widget build(BuildContext context) {
    prefManager = SharedPrefManager();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              'Select Your\nExpertise Level',
              style: TextStyle(
                  fontSize: 30, color: Colors.black, fontFamily: 'BoldFont'),
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              child: RadioButton("Beginner","I have never learned Quran vocabulary.", true, colors[0]),
              onTap: () {
                setState(() {
                    buttonPressed(0);
                });
              },
            ),
            GestureDetector(
              child: RadioButton("Intermediate","I know some of the words from Quran.", true, colors[1]),
              onTap: () {
                setState(() {
                  buttonPressed(1);
                });
              },
            ),
            GestureDetector(
              child: RadioButton("Advanced","I think I know all of the words of Quran.", true, colors[2]),
              onTap: () {
                setState(() {
                  buttonPressed(2);
                });
              },
            ),
            RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green)),
                onPressed: () {
                  prefManager.addExpertLevel(value);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => InstructionScreen())
                  );
                },
                child: Text(
                  "Lets Begin",
                  style: kButtonStyle,
                )),
          ],
        ),
      ),
    );
  }
}

class RadioButton extends StatefulWidget {
  final bool interactable;
  final String word;
  final String word1;
  final Color color;
  RadioButton(this.word,this.word1,this.interactable,this.color);
  @override
  _RadioButton createState() => _RadioButton();
}

class _RadioButton extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(
            color: Colors.black
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(15)
          )
      ),

      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          children: <Widget>[
            Text(
              widget.word,
              style: kHeadingStyle,
              textAlign: TextAlign.center,
            ),
            Text(
              widget.word1,
              style: kSmallText,
              textAlign: TextAlign.center,
            ),
          ],
        )
      ),
    );
  }
}