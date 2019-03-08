import 'package:flutter_app/data/rest_ds.dart';
import 'package:flutter_app/model/region.dart';
import 'package:flutter/material.dart';


class RegionsDropDown extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _RegionsDropDownState createState () => new _RegionsDropDownState();

}

class _RegionsDropDownState extends State<RegionsDropDown>{

  String _currentCity;
  RestDatasource api;

  @override
  void initState() {
    api = new RestDatasource();
    _currentCity = 'All';
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems(regionsSnapshot) {
    List<DropdownMenuItem<String>> items = new List();
    items.add(new DropdownMenuItem(
        value: 'All',
        child: new Text('All')
    ));
    for (Region region in regionsSnapshot) {
      items.add(new DropdownMenuItem(
          value: region.name,
          child: new Text(region.name)
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      child: new FutureBuilder(
          future: api.getRegions(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!=null) {
                return new Column (
                    children: <Widget>[
                      new DropdownButton(
                        value: _currentCity,
                        items:  getDropDownMenuItems(snapshot.data),
                        onChanged: changedDropDownItem,
                      )
                    ]
                );
              }
            }
            return new Column(
              children: <Widget>[new CircularProgressIndicator()],
            );
          }
      )
    );
  }

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _currentCity = selectedCity;
    });
  }
}