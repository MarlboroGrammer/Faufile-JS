class Service {
  String name;
  String description;
  int id;
  Service(this.name, this.description);

  Service.map (dynamic obj) {
    this.name = obj["name"];
    this.description = obj["description"];
    this.id = obj["id"];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;
    map["id"] = id;

    return map;
  }
}