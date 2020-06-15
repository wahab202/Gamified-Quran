import 'package:flutter/material.dart';
import 'package:gamifiedquran/GoalsScreen.dart';
import 'constants.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name;
  String image='bgEnglish.jpg';

  @override
  Widget build(BuildContext context) {
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
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(60, 60, 60, 20),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    prefixIcon: Icon(
                      Icons.perm_identity,
                      color: Colors.grey[700],
                    ),
                    hintText: "Name",
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                  onChanged: (value) {
                    name = value;
                    print(name);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                      color: greenColorLight,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: greenColorLight)),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => GoalsScreen(name))
                        );
                      },
                      child: Text(
                        "Start",
                        style: kButtonStyle,
                      )),
                ],
              ),
              Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
