import 'package:flutter_app/widgets/regions_dropdownlist.dart';
import 'package:flutter_app/model/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/rest_ds.dart';
import 'package:flutter_app/detail_page.dart';

import 'package:flutter_app/screens/services_presenter.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}
/*
* ,*/
class _ListPageState extends State<ListPage> implements ServicesScreenContract{
  RestDatasource api;
  @override
  void initState(){
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
            future: api.getServices(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              print('getList ${snapshot}');
              if (snapshot.hasData) {
                if (snapshot.data!=null) {
                  print('getList ${snapshot.data}');
                  return new Column (
                    children: <Widget>[
                      new Row(children: [
                        new SizedBox(width: 40.0,),
                        new Text('Select your area:'),
                        new SizedBox(width: 20.0,),
                        new RegionsDropDown()]
                      ),
                      new Expanded(child: getList(snapshot))]
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

  ListTile makeListTile(Service service) => ListTile(
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
      service.name,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    trailing:
    Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
    onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(service: service)));
    },
  );
  Card makeCard(Service service) => Card(
    elevation: 8.0,
    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    child: Container(
      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
      child: makeListTile(service),
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

  @override
  void onGetData(List<Service> services) {
  }

  @override
  void onDataError(String errorTxt) {
    print('Error!');
    // TODO: implement onLoginError
  }
}