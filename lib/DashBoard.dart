import 'package:flutter/material.dart';
import 'package:gamifiedquran/QuizLearnScreen.dart';
import 'constants.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'SharedPrefManager.dart';
import 'package:gamifiedquran/ReadQuran.dart';
import 'package:gamifiedquran/DatabaseManager.dart';
import 'package:gamifiedquran/FlashCards.dart';


class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {

  List<Widget> lessons;
  List<Widget> locks;
  List<int> lessonLocks=[0];
  List<Map> wordList;
  String username="...";
  int mins=0;
  int words=0;
  int level=0;
  double accuracy=0;
  int wordGoal=0;
  int minutesGoal=0;
  SharedPrefManager prefManager;
  DatabaseManager databaseManager;

  double wordMeter=0;
  double accuracyMeter=0;
  double minuteMeter=0;


  void getPref() async {
    username = await prefManager.getUsername();
    mins = await prefManager.getMinutes();
    accuracy = await prefManager.getAccuracy();
    level = await prefManager.getLevel();
    wordGoal = await prefManager.getWordGoal();
    minutesGoal = await prefManager.getMinutesGoal();
    words = (level-1)*8;
    setupMeters();
    setupWords();
    setState(() {
      lessonLocks = setupLockInts();
    });
  }

  void setupWords() async {
    databaseManager = DatabaseManager();
    wordList = await databaseManager.initializeDb();
  }

  void setupMeters(){
    wordMeter = words/wordGoal;
    accuracyMeter = accuracy/100;
    minuteMeter = mins/minutesGoal;
  }

  void verifyMeters(){
    if(wordMeter>1){
      wordMeter=1;
    }
    if(accuracyMeter>1){
      accuracyMeter=1;
    }
    if(minuteMeter>1){
      minuteMeter=1;
    }
  }


  Widget getListOfLessons() {
    var listView = Expanded(
        child: ListView(
            padding: EdgeInsets.all(0.0),
            children: lessons
        ));
    return listView;
  }

  void setupLessons(){
    for(int i=0;i<numOfLessons;i++){
      lessons.add(GestureDetector(
        onTap: (){
          lessonPressed(i);
        },
        child: ListTile(
          leading: Icon(Icons.library_books),
          title: Text("Lesson "+(i+1).toString()),
          trailing: locks[i],
        ),
      ),);
    }
  }

  void lessonPressed(int index){
    if (lessonLocks[index]==1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizLearnScreen(index),
        ),
      );
    }
  }

  void setupLocks(){
    for(int i in lessonLocks){
      if (i==0){
        locks.add(Icon(Icons.lock));
      } else {
        locks.add(Icon(Icons.lock_open));
      }
    }
  }

  List<int> setupLockInts () {
    List<int> lst = new List<int>();
    for(int i=0;i<numOfLessons;i++){
      if (i<level){
        lst.add(1);
      } else {
        lst.add(0);
      }
    }
    return lst;
  }

  @override
  Widget build(BuildContext context) {
    prefManager = SharedPrefManager();

    lessons = new List<Widget>();
    locks = new List<Widget>();

    if(username=="..."){
      lessonLocks = List<int>.filled(numOfLessons, 0);
      getPref();
    }
    setupLocks();
    setupLessons();
    verifyMeters();
    setupWords();

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(
                  "Assalam-u-Alaykum\n$username",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontFamily: 'Balsamiq'),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Progress",
                    style: kQuizExplanationStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Last 7 days",
                    style: kSmallText,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 7.0,
                  percent: wordMeter,
                  center: new Text("$words Words"),
                  progressColor: greenColor,
                ),
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 7.0,
                  percent: accuracyMeter,
                  center: new Text(
                    "${accuracy.toInt()}%\nAccuracy",
                    textAlign: TextAlign.center,
                  ),
                  progressColor: greenColor,
                ),
                CircularPercentIndicator(
                  radius: 100.0,
                  lineWidth: 7.0,
                  percent: minuteMeter,
                  center: new Text("$mins\nminutes",textAlign: TextAlign.center,),
                  progressColor: greenColor,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,15,0,0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                      color: Colors.transparent,
                      shape: kRoundRectShape,
                      onPressed: (){
                        if(wordList.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  FlashCards(wordList, words + 8),
                              ));
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.sd_card,color: Colors.grey[700]),
                          Text(
                            "Flashcards",
                            style: kGreyButtonFont,
                          )
                        ],
                      )),
                  FlatButton(
                      color: Colors.transparent,
                      shape: kRoundRectShape,
                      onPressed: (){
                        if(wordList.isNotEmpty) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  ReadQuran(wordList),
                              ));
                        }
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.library_books,color: Colors.grey[700],),
                          Text(
                            "Read Quran",
                            style: kGreyButtonFont,
                          )
                        ],
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 5),
              child: Text(
                "Lessons",
                style: kQuizExplanationStyle,
              ),
            ),
            getListOfLessons(),
          ],
        ),
      ),
    );
  }
}