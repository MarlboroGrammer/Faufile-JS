import 'dart:async';

import 'package:flutter_app/utils/network_util.dart';
import 'package:flutter_app/model/user.dart';
import 'package:flutter_app/model/service.dart';
import 'package:flutter_app/model/region.dart';
import 'package:flutter_app/model/ticket.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static const String BASE_URL = "http://10.0.2.2:3000/api";
  static const String LOGIN_URL = BASE_URL + "/users/auth";
  static const String SERVICES_URL = BASE_URL + "/services";
  static const String REGIONS_URL = BASE_URL + "/regions";
  static const String TICKETS_URL = BASE_URL + "/tickets";

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

  Future<dynamic> postTicket (int userId, int serviceId) {
    var now = new DateTime.now();
    print('inside postTicket ${userId}');
    String timestamp = '${now.hour}${now.minute}${now.second}';
    return _netUtil.post(TICKETS_URL, body: {
      "user_id": '${userId}',
      "service_id": '${serviceId}'
      }).then((dynamic res) {
      print(res.toString());
      if(res["error"] != null) throw new Exception(res);
      return res;
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
  Future<List<Ticket>> getTickets(userId) {
    List<Ticket> tickets = new List();
    return _netUtil.get(TICKETS_URL + '/user/${userId}').then((dynamic res) {
      if(res == null) throw new Exception(res);
      for (var ticket in res) {
        tickets.add(Ticket.map(ticket));
      }
      return (tickets);
    });
  }

  Future<dynamic> getLastTicket (int serviceId) {
    return _netUtil.get(TICKETS_URL + '/last/${serviceId}').then((dynamic res) {
      if(res == null) throw new Exception(res);
      return res[0]["ticket"] == null ? 0 : res[0]["ticket"];
    });
  }
}