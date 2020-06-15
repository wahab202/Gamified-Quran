import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:gamifiedquran/QuizLearnScreen.dart';


class InstructionScreen extends StatefulWidget {
  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Lets move to your first lesson.',
                style: TextStyle(
                    fontSize: 30, color: Colors.black, fontFamily: 'Balsamiq'),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                      border: Border.all(
                        color: Colors.grey[300],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Instructions',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, fontFamily: 'Balsamiq'),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'Step 1. Learn the words shown on screen.\nStep 2. Play the Card Game.\nStep 3. Play the MCQ Game.\nStep 4. Review Result Card.',
                          style: TextStyle(
                              fontSize: 20, color: Colors.black, fontFamily: 'Balsamiq'),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green)),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => QuizLearnScreen(0)
                  ));
                },
                child: Text(
                  "Start Lesson 1",
                  style: kButtonStyle,
                )),
          ],
        ),
      ),
    );
  }
}
