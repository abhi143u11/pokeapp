import 'package:flutter/material.dart';
import 'package:pokeapp/models/workerrating.dart';
import 'package:http/http.dart' as http;
import 'package:velocity_x/velocity_x.dart';

class WorkerDetails extends StatefulWidget {
  @override
  _WorkerDetailsState createState() => _WorkerDetailsState();
}

class _WorkerDetailsState extends State<WorkerDetails> {
  final url =
      'http://192.168.0.107/acsphp/provider_rating.php?service_provider_id=2';

  Future<List<WorkerRating>> _getRating() async {
    var response = await http.get(url);
    var values = workerRatingFromJson(response.body);
    //throw new Exception("Danger Will Robinson!!!");

    await new Future.delayed(new Duration(seconds: 1));

    return values;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: "ACS".text.black.make(),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: _getRating(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              List<WorkerRating> values = snapshot.data;
              print(values[0].customerName);

              return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Text(values[index].customerName),
                    );
                  },
                  itemCount: values.length);
            }),

        /*VStack(
          [
            Column(
              children: <Widget>[
                VStack(
                  [
                    Column(
                      children: <Widget>[
                        10.heightBox,
                        "Abhishek Jain".text.bold.xl2.white.makeCentered(),
                        10.heightBox,
                        "4.6".text.medium.orange500.makeCentered(),
                        10.heightBox,
                      ],
                    )
                        .card
                        .p8
                        .roundedSM
                        .color(Color.fromRGBO(30, 30, 30, 1))
                        .make(),
                    Column(
                      children: <Widget>[
                        "Recent Reviews".text.white.medium.make(),
                      ],
                    ).p8(),
                    VStack(
                      [
                        CustomerReview(),
                        CustomerReview(),
                        CustomerReview(),
                        CustomerReview(),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ).scrollVertical(physics: BouncingScrollPhysics()),*/
      ),
    );
  }

  Widget customerReview() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            "Customer Name".text.white.medium.make(),
            "4.6".text.medium.orange500.make(),
          ],
        ),
        10.heightBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            "20-12-2020"
                .text
                .color(
                  Color.fromRGBO(242, 242, 242, 1),
                )
                .make(),
            10.heightBox,
            "Abhishek provided a very quick and easy solution to a problem that I've had for days. He was very good, knowledgable and provided a fast solution. I will be hiring him for future projects. I recommend him for any work regarding WordPress, HTML, CSS, and PHP. A+ "
                .text
                .color(
                  Color.fromRGBO(242, 242, 242, 1),
                )
                .make(),
          ],
        ),
      ],
    ).p16().card.roundedSM.color(Color.fromRGBO(30, 30, 30, 1)).p8.make();
  }
}
