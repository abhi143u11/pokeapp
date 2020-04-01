import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
// To parse this JSON data, do
//
//     final hitsArray = hitsArrayFromJson(jsonString);

import 'dart:convert';

import 'models/workerrating.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: _getData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Text('loading...');
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return createListView(context, snapshot);
        }
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home Page"),
      ),
      body: futureBuilder,
    );
  }

  Future<List<WorkerRating>> _getData() async {
    final url =
        'http://192.168.0.107/acsphp/provider_rating.php?service_provider_id=2';
    var response = await http.get(url);
    var values = workerRatingFromJson(response.body);

    await new Future.delayed(new Duration(seconds: 1));

    return values;
  }

  Widget createListView(BuildContext context, AsyncSnapshot snapshot) {
    List<WorkerRating> values = snapshot.data;
    return new ListView.builder(
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  "${values[index].customerName.toString()}"
                      .text
                      .white
                      .medium
                      .make(),
                  "${values[index].rating.toString()}"
                      .text
                      .medium
                      .orange500
                      .make(),
                ],
              ),
              10.heightBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  "${values[index].createdDate.toString()}"
                      .text
                      .color(
                        Color.fromRGBO(242, 242, 242, 1),
                      )
                      .make(),
                  10.heightBox,
                  '${values[index].feedback.toString()}'
                      .text
                      .color(
                        Color.fromRGBO(242, 242, 242, 1),
                      )
                      .make(),
                ],
              ),
            ],
          ).p16().card.roundedSM.color(Color.fromRGBO(30, 30, 30, 1)).p8.make();
        });
  }
}
