import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {

  Future<bool> isFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('username');
    return !(checkValue);
  }

  void addUsername(String username,int wordGoal, int minutesGoal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    prefs.setInt('level', 1);
    prefs.setInt('mins', 0);
    prefs.setInt('words', 0);
    prefs.setDouble('accuracy', 0);
    prefs.setInt('sec', 0);
    prefs.setInt('wordGoal', wordGoal);
    prefs.setInt('minutesGoal', minutesGoal);
  }

  void addExpertLevel(int expert) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('expert', expert);
  }

  Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username');
    return username;
  }

  void updateLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int level = prefs.getInt('level');
    level++;
    prefs.setInt('level', level);
  }

  void updateMinute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int sec = prefs.getInt('sec');
    sec++;
    if (sec==60){
      int mins = prefs.getInt('mins');
      mins++;
      prefs.setInt('mins', mins);
      prefs.setInt('sec', 0);
    } else {
      prefs.setInt('sec', sec);
    }
  }

  void updateAccuracy(double accuracy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double accSP = prefs.getDouble('accuracy');
    int level = prefs.getInt('level');
    double newAcc = ((accSP*(level-1))+accuracy)/level+1;
    if(newAcc<=100){
      prefs.setDouble('accuracy', newAcc);
    }
  }

  Future<int> getMinutes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int mins = prefs.getInt('mins');
    return mins;
  }

  Future<double> getAccuracy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double accuracy = prefs.getDouble('accuracy');
    return accuracy;
  }

  Future<int> getLevel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int level = prefs.getInt('level');
    return level;
  }

  Future<int> getWordGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int level = prefs.getInt('wordGoal');
    return level;
  }

  Future<int> getMinutesGoal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int level = prefs.getInt('minutesGoal');
    return level;
  }

  void updateTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int mins = prefs.getInt('mins');

    mins++;
    prefs.setInt('mins', mins);
  }



}