import 'package:flutter/material.dart';
import 'services_list.dart';
import 'tickets_list.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  TabController controller;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Faufile', style: TextStyle(color: Colors.white),),
        actions: <Widget>[

        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: TabBarView(
            children: [
              new ListPage(title: 'Lessons'),
              new TicketPage(),
            ],
          ),
          bottomNavigationBar: new TabBar(
            tabs: [
              Tab(
                icon: new Icon(Icons.home),
              ),
              Tab(
                icon: new Icon(Icons.rss_feed),
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black45,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.white,
          ),
          backgroundColor: Colors.lightBlueAccent,
        ),
      ),
    );
  }
}