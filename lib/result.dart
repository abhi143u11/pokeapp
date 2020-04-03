import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int resultScore;
  final Function resetHandler;

  Result({this.resultScore, this.resetHandler});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            resultScore.toString(),
            style: TextStyle(
              fontSize: 76,
              fontWeight: FontWeight.bold,
            ),
          ),
          RaisedButton(
            child: Text("Reset"),
            textColor: Colors.white,
            onPressed: resetHandler,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
