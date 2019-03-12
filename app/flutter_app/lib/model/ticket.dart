import 'package:flutter_app/model/service.dart';

class Ticket {
  int id;
  int user;
  int field;
  String serviceName;
  Ticket();

  Ticket.map (dynamic obj) {
    this.id = obj["id"];
    this.user = obj["user"];
    this.field = obj["field"];
    this.serviceName = obj["name"];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["user"] = user;
    map["field"] = field;

    return map;
  }
}