import 'package:flutter/material.dart';
import 'package:gamifiedquran/ExpertiseLevelScreen.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import 'DashBoard.dart';
import 'package:gamifiedquran/SharedPrefManager.dart';
import 'constants.dart';


class GoalsScreen extends StatefulWidget {
  final String name;
  GoalsScreen(this.name);
  @override
  _GoalsScreenState createState() => _GoalsScreenState();
}

class _GoalsScreenState extends State<GoalsScreen> {
  int wordGoal=10;
  int minutesGoal=10;
  SharedPrefManager prefManager;

  @override
  Widget build(BuildContext context) {
    prefManager = SharedPrefManager();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Set Your Goal\nFor Everyday',style: TextStyle(fontSize: 30, color: Colors.black, fontFamily: 'BoldFont'),textAlign: TextAlign.center,),
            Text('Words to learn',style: TextStyle(fontSize: 25, color: Colors.black, fontFamily: 'Balsamiq')),
            StepperSwipe(
              initialValue:10,
              speedTransitionLimitCount: 3, //Trigger count for fast counting
              onChanged: (int value) => wordGoal=value,
              firstIncrementDuration: Duration(milliseconds: 250), //Unit time before fast counting
              secondIncrementDuration: Duration(milliseconds: 100), //Unit time during fast counting
              direction: Axis.horizontal,
              dragButtonColor: Colors.green,
              iconsColor: Colors.green,
              withNaturalNumbers: true,
            ),
            Text("Minutes to spend\nreading Qur'an",style: TextStyle(fontSize: 25, color: Colors.black, fontFamily: 'Balsamiq'),textAlign: TextAlign.center,),
            StepperSwipe(
              initialValue:10,
              speedTransitionLimitCount: 3, //Trigger count for fast counting
              onChanged: (int value) => minutesGoal=value,
              firstIncrementDuration: Duration(milliseconds: 250), //Unit time before fast counting
              secondIncrementDuration: Duration(milliseconds: 100), //Unit time during fast counting
              direction: Axis.horizontal,
              dragButtonColor: Colors.green,
              iconsColor: Colors.green,
              withNaturalNumbers: true,
            ),
            RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.green)),
                onPressed: () {
                  prefManager.addUsername(widget.name, (wordGoal*7), (minutesGoal*7));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ExpertiseLevelScreen())
                  );
                },
                child: Text(
                  "Next",
                  style: kButtonStyle,
                )),
          ],
        ),
      ),
    );
  }
}
