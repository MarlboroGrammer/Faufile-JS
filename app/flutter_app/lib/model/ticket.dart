class Ticket {
  int user;
  int field;
  Ticket();

  Ticket.map (dynamic obj) {
    this.user = obj["user"];
    this.field = obj["field"];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["user"] = user;
    map["field"] = field;

    return map;
  }
}