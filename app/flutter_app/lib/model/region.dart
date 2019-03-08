class Region {
  String name;
  int id;
  Region(this.name, this.id);

  Region.map (dynamic obj) {
    this.name = obj["name"];
    this.id = obj["id"];
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["id"] = id;

    return map;
  }
  @override
  String toString() {
    // TODO: implement toString
    return this.name;
  }
}