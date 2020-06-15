import 'package:flutter/material.dart';
import 'constants.dart';

class QuizCard extends StatefulWidget {
  final bool interactable;
  final String word;
  final Color color;
  QuizCard(this.word,this.interactable,this.color);
  @override
  _QuizCardState createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.all(
              Radius.circular(15)
          )
      ),

      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Text(
          widget.word,
          style: kQuizCardTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
