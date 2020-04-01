import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';
// To parse this JSON data, do
//
//     final hitsArray = hitsArrayFromJson(jsonString);

import 'dart:convert';

import 'models/workerrating.dart';

List<HitsArray> hitsArrayFromJson(String str) =>
    List<HitsArray>.from(json.decode(str).map((x) => HitsArray.fromJson(x)));

String hitsArrayToJson(List<HitsArray> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    String jsonString =
        ' [    {      "tt": 1567566438144,    "status": "0",    "count": 2257056,    "status_count": 2257053    }    ,    {    "tt": 1567566438144,    "status": "1",    "count": 2257056,    "status_count": 3    }    ]';
    var response = await http.get(url);
    var values = workerRatingFromJson(response.body);

    //var values = hitsArrayFromJson(jsonString);
    //throw new Exception("Danger Will Robinson!!!");

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
} /*new Column(
          children: <Widget>[
            /*new ListTile(
              title:
                  new Text(' count ${values[index].customerName.toString()}'),
              subtitle:
                  new Text('status count ${values[index].feedback.toString()}'),
            ),*/
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }
}*/
