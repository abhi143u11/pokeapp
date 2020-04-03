import 'package:flutter/material.dart';

import 'widget/user_transactions.dart';
//     final hitsArray = hitsArrayFromJson(jsonString);

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // String titleInput;
  // String amountInput;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('First App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: Colors.blue,
              child: Text('Chart'),
            ),
            UserTransactions(),
          ],
        ),
      ),
    );
  }
}
