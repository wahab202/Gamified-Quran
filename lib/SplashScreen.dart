import 'package:flutter/material.dart';
import 'constants.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String image='bg.jpg';
  List<String> tips = new List<String>();
  bool first=true;
  String tip;

  @override
  Widget build(BuildContext context) {
    if(first){
      tips.add("He who loves my Sunnah has loved me, and he who loves me will be with me in Paradise.");
      tips.add("Heaven lies under the feet of your mother.");
      tips.add("God will not show mercy to him who does not show mercy to others.");
      tips.add("Verily anger spoils faith as aloe spoils honey.");
      tips.add("Indeed, We have sent it down as an Arabic Qur’an that you might understand.");
      tips.add("Those who make things hard for themselves will be destroyed.");
      tips.add("And thus we have made you a just community that you will be witnesses over the people.");
      Random random = new Random();
      int randomNumber = random.nextInt(7);
      tip = tips[randomNumber];
      first=false;

    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$image"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30,260,30,5),
                child: Text("Hadith Of The Day",textAlign: TextAlign.center,style: kGreyButtonFontSplashscreen,),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30,0,30,100),
                child: Text(tip,textAlign: TextAlign.center,style: kGreyButtonFontSplashscreenSmall,),
              )
            ],
          )
        ),
      ),
    );
  }
}
