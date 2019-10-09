import 'package:day_5_starter/quiz_brain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizlr());
}

class Quizlr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
      ),
    ));
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  _onAlertButtonPressed(context) {
    Alert(
      context: context,
      title: "Quiz Completed",
      desc:
          "you have reached the end of the quiz and have scored $score/${brain.questions.length}",
      buttons: [
        DialogButton(
          child: Text(
            "Restart",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              score = 0;
              brain.count = 0;
              scoreKeeper = [];
              Navigator.pop(context);
            });
          },
          width: 120,
        )
      ],
    ).show();
  }

  int score = 0;
  Icon tick = Icon(
    Icons.done,
    color: Colors.green,
  );
  Icon cross = Icon(
    Icons.close,
    color: Colors.red,
  );
  List<Icon> scoreKeeper = [];
  QuizBrain brain = QuizBrain();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                brain.getCurrentQuestion().questionText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (brain.count == (brain.questions.length - 1)) {
                    if (brain.checkAnswer(true)) {
                      scoreKeeper.add(tick);
                      score += 1;
                    }
                    _onAlertButtonPressed(context);
                  } else if (brain.count != (brain.questions.length - 1)) {
                    if (brain.checkAnswer(true)) {
                      scoreKeeper.add(tick);
                      score += 1;
                    } else
                      scoreKeeper.add(cross);
                    brain.count += 1;
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (brain.count == (brain.questions.length - 1)) {
                    if (brain.checkAnswer(false)) {
                      scoreKeeper.add(tick);
                      score += 1;
                    }
                    _onAlertButtonPressed(context);
                  } else if (brain.count != (brain.questions.length - 1)) {
                    if (brain.checkAnswer(false)) {
                      scoreKeeper.add(tick);
                      score += 1;
                    } else
                      scoreKeeper.add(cross);
                    brain.count += 1;
                  }
                });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: scoreKeeper,
          ),
        )
        // TODO a row here to keep the scores
      ],
    );
  }
}

// Sample Questions and Answers
// Q.1 Amartya Sen was awarded the Nobel prize for his contribution to Welfare Economics., true
// Q.2 The Headquarters of the Southern Naval Command of the India Navy is located at Thiruvananthapuram., false
// Q.3 There are 4 sessions of the Parliament each year: Spring, Summer, Autumn and Winter., false
