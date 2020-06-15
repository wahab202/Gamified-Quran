import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:gamifiedquran/QuizCard.dart';
import 'SharedPrefManager.dart';
import 'package:gamifiedquran/DashBoard.dart';

class AccuracyScreen extends StatefulWidget {
  final int incorrect;
  AccuracyScreen(this.incorrect);
  @override
  _AccuracyScreenState createState() => _AccuracyScreenState();
}

class _AccuracyScreenState extends State<AccuracyScreen> {
  SharedPrefManager prefManager;

  @override
  Widget build(BuildContext context) {
    prefManager = SharedPrefManager();
    double accuracy = 8/ (widget.incorrect + 8);
    int accuracy1 = (accuracy * 100).toInt();

    String resultText;

    if (accuracy1>80){
      resultText="Great Job!";
    } else if (accuracy1<=80 && accuracy1>60){
      resultText="Thats a nice score!";
    } else if (accuracy1<=60 && accuracy1>40){
      resultText="Not Bad!";
    } else if (accuracy1<=40){
      resultText="You'll play better next time";
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 1.5,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(resultText,style: kHeadingWicked,textAlign: TextAlign.center,),
                    QuizCard('Accuracy: ' + accuracy1.toString() + '%', false,
                        Colors.grey[50]),
                    QuizCard("Correct: 8", false,
                        Colors.grey[50]),
                    QuizCard("Incorrect: " + widget.incorrect.toString(), false,
                        Colors.grey[50]),
                    RaisedButton(
                        color: Colors.green,
                        shape: kRoundShape,
                        onPressed: (){
                          prefManager.updateAccuracy(accuracy*100);
                          prefManager.updateLevel();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              DashBoard()), (Route<dynamic> route) => false);
                        },
                        child: Text(
                          "Dashboard",
                          style: kButtonStyle,
                        )),
                  ],
                ),
              )

            ),
          ],
        ),
      ),
    );
  }
}
