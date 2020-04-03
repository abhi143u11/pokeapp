import 'package:flutter/material.dart';
import 'package:pokeapp/result.dart';

import 'quiz.dart';

//
//     final hitsArray = hitsArrayFromJson(jsonString);

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _questions = const [
      {
        'questionText': 'What\'s your favorite color?',
        'answers': [
          {'text': 'Black', 'score': 10},
          {'text': 'Red', 'score': 5},
          {'text': 'Green', 'score': 3},
          {'text': 'White', 'score': 1},
        ],
      },
      {
        'questionText': 'What\'s your favorite animal?',
        'answers': [
          {'text': 'Rabbit', 'score': 3},
          {'text': 'Snake', 'score': 11},
          {'text': 'Elephant', 'score': 5},
          {'text': 'Lion', 'score': 9},
        ],
      },
      {
        'questionText': 'Who\'s your favorite instructor?',
        'answers': [
          {'text': 'Max', 'score': 1},
          {'text': 'Max', 'score': 1},
          {'text': 'Max', 'score': 1},
          {'text': 'Max', 'score': 1},
        ],
      },
    ];

    void _answerQuestion(int score) {
      _totalScore = _totalScore + score;
      print(_totalScore);
      setState(() {
        _questionIndex = _questionIndex + 1;
      });
      print(_questionIndex);
    }

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('First App'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              answerQuestion: _answerQuestion,
              questionIndex: _questionIndex,
              questions: _questions,
            )
          : Result(
              resultScore: _totalScore,
              resetHandler: _resetQuiz,
            ),
    ));
  }
}
