class Service {
  String name;
  String description;
  Service(this.name, this.description);

  Service.map (dynamic obj) {
    this.name = obj["name"];
    this.description = obj["description"];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["description"] = description;

    return map;
  }
}