import 'package:flutter/material.dart';
import 'package:flutter_app/data/rest_ds.dart';
import 'package:flutter_app/model/ticket.dart';
import 'package:flutter_app/utils/auth_util.dart';

class TicketPage extends StatefulWidget {

  @override
  _TicketPageState createState() => new _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  RestDatasource api;

  @override
  void initState () {
    print(AuthUtil.getCurrent());
    api = new RestDatasource();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(240, 255, 255, 1.0),
        body: Container(
          // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
            child: new FutureBuilder(
                future: api.getTickets(AuthUtil.getCurrent()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!=null) {
                      return snapshot.data.length > 0 ? new Column (
                          children: <Widget>[
                            new Row(children: [
                              new SizedBox(width: 20.0,)
                            ]
                            ),
                            new Expanded(child: getList(snapshot))]
                      ) : new Column(
                        children: <Widget>[
                          new SizedBox(height: 20.0,),
                          new Center(
                            child: Text('No tickets found!', style: TextStyle(color: Colors.black, fontSize: 24.0)),
                          )
                        ],
                      );
                    }
                  }
                  return new Column(
                    children: <Widget>[new CircularProgressIndicator()],
                  );
                }
            )
        )
    );
  }

  ListTile makeListTile(Ticket ticket) => ListTile(
    contentPadding:
    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    leading: Container(
      padding: EdgeInsets.only(right: 12.0),
      decoration: new BoxDecoration(
          border: new Border(
              right: new BorderSide(width: 1.0, color: Colors.white24))),
      child: Icon(Icons.autorenew, color: Colors.white),
    ),
    title: Text(
      ticket.serviceName,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    subtitle: Row(
      children: <Widget>[
        Text("${ticket.id}", style: TextStyle(color: Colors.white)),
        SizedBox(width: 15.0,),
        Text("Horraire: ${ticket.bookingTime}", style: TextStyle(color: Colors.white))
      ],
    ),
    trailing:
    Icon(Icons.photo_album, color: Colors.white, size: 30.0),
    onTap: () {},
  );
  Card makeCard(Ticket ticket) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: makeListTile(ticket),
    ),
  );
  dynamic getList (AsyncSnapshot snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(snapshot.data[index]);
      },
    );
  }

}