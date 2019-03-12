
import 'package:flutter_app/data/rest_ds.dart';
import 'package:flutter_app/model/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/auth_util.dart';

import 'home_page.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key, this.service}) : super(key: key);
  final Service service;


  @override
  _DetailPageState createState () => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TimeOfDay _time = new TimeOfDay.now();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
   void postTicket() async{
    try {
      var res = await api.postTicket(AuthUtil.getCurrent(), widget.service.id, _time);
      Navigator.popUntil(context, ModalRoute.withName(HomePage.tag));
    }on Exception catch(error) {
      showErrorDialog();
    }
//    if (res != null)
//      Navigator.popUntil(context, ModalRoute.withName(HomePage.tag));
  }
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text(text)));
  }
  Future<Null> selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(context: context, initialTime: _time);
    if(picked != null && picked != _time){

      setState(() {
        _time = picked;
      });
    }
}
  // user defined function
  void show_Dialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Choose the time for your service"),
          content: new Text("Take an appointement at ${widget.service.name} at:${_time.toString()}"),
          actions: <Widget>[
            new Column(
              children: <Widget>[
                new Text('Time selected: ${_time}\n'),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new RaisedButton(
                        child: new Text('Select time', style: TextStyle(color: Colors.white),),
                        onPressed: (){selectTime(context);}
                    ),
                    new RaisedButton(
                        padding: const EdgeInsets.all(20),
                        child: new Text('Confirm choice', style: TextStyle(color: Colors.white),),
                        color: Color.fromRGBO(83, 66, 250, 1.0),
                        onPressed: postTicket
                    ),
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            )
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }
  void showErrorDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: new Text("Please pick another time!"),
          actions: <Widget>[
            new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            )
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }
  RestDatasource api;
  @override
  void initState(){
    api = new RestDatasource();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 80.0,
        child: Image.asset('assets/${widget.service.name}.png'),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 10.0),
        Text(
          widget.service.name,
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
      widget.service.description,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 11.0),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          onPressed: show_Dialog,
          color: Color.fromRGBO(0, 66, 250, 1.0),
          child:
          Text("Get queue ticket", style: TextStyle(color: Colors.white)),
        ));
    final futureTicketCount = FutureBuilder(
      future: api.getLastTicket(widget.service.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!=null) {
              return new Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Center(
                    child: new Text('Current ticket number: ${snapshot.data}', style: new TextStyle(fontSize: 20.0),)
                ),
              );
            }
          }
          return new Column(
            children: <Widget>[new CircularProgressIndicator()],
          );
        }
    );
    final ticketCount = Container(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Center(
        child: new Text('Current ticket number: 0001', style: new TextStyle(fontSize: 20.0),)
      ),
    );
    final bottomContent = Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, futureTicketCount, readButton],
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