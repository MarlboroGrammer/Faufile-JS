import 'dart:async';

import 'package:flutter_app/utils/network_util.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/model/service.dart';
import 'package:flutter_app/model/region.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static const String BASE_URL = "http://10.0.2.2:3000/api";
  static const String LOGIN_URL = BASE_URL + "/users/auth";
  static const String SERVICES_URL = BASE_URL + "/services";
  static const String REGIONS_URL = BASE_URL + "/regions";

  Future<User> login(String username, String password) {
    return _netUtil.post(LOGIN_URL, body: {
      "email": username,
      "password": password
    }).then((dynamic res) {
      print(res.toString());
      if(res["error"] != null) throw new Exception(res);
      return new User.map(res["user"]);
    });
  }

  Future<List<Service>> getServices() {
    List<Service> services = new List();
    return _netUtil.get(SERVICES_URL).then((dynamic res) {
      if(res == null) throw new Exception(res);
      for (var service in res) {
        services.add(Service.map(service));
      }
      return (services);
    });
  }
  Future<List<Region>> getRegions() {
    List<Region> regions = new List();
    return _netUtil.get(REGIONS_URL).then((dynamic res) {
      if(res == null) throw new Exception(res);
      for (var region in res) {
        regions.add(Region.map(region));
      }
      return (regions);
    });
  }
}