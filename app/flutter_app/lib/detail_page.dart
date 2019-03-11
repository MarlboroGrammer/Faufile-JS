import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:flutter_app/model/service.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  Future<String> postTicket() async{
    http.Response response = await http.post(
      Uri.encodeFull("http://10.0.2.2:3000/api/tickets"),
    );
    print (response.body);
  }
  final Service service;
  DetailPage({Key key, this.service}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 80.0,
        child: Image.asset('assets/${service.name}.png'),
      ),
    );
//    final levelIndicator = Container(
//      child: Container(
//        child: LinearProgressIndicator(
//            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
//            value: lesson.indicatorValue,
//            valueColor: AlwaysStoppedAnimation(Colors.green)),
//      ),
//    );

//    final coursePrice = Container(
//      padding: const EdgeInsets.all(7.0),
//      decoration: new BoxDecoration(
//          border: new Border.all(color: Colors.white),
//          borderRadius: BorderRadius.circular(5.0)),
//      child: new Text(
//        "\$" + lesson.price.toString(),
//        style: TextStyle(color: Colors.white),
//      ),
//    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text(
          service.name,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(width: 80.0,),
            logo
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.5,
            ),
        Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery
              .of(context)
              .size
              .width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      service.description,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          onPressed: postTicket,
          color: Color.fromRGBO(0, 66, 250, 1.0),
          child:
          Text("Get queue ticket", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}