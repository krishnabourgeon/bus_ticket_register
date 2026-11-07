// To parse this JSON data, do
//
//     final rotesBusesModel = rotesBusesModelFromJson(jsonString);

import 'dart:convert';

RotesBusesModel rotesBusesModelFromJson(String str) => RotesBusesModel.fromJson(json.decode(str));

String rotesBusesModelToJson(RotesBusesModel data) => json.encode(data.toJson());

class RotesBusesModel {
    List<Routes> routes;

    RotesBusesModel({
        required this.routes,
    });

    factory RotesBusesModel.fromJson(Map<String, dynamic> json) => RotesBusesModel(
        routes: List<Routes>.from(json["routes"].map((x) => Routes.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "routes": List<dynamic>.from(routes.map((x) => x.toJson())),
    };
}

class Routes {
    int id;
    String routeNo;
    String name;
    List<Bus> buses;

    Routes({
        required this.id,
        required this.routeNo,
        required this.name,
        required this.buses,
    });

    factory Routes.fromJson(Map<String, dynamic> json) => Routes(
        id: json["id"],
        routeNo: json["route_no"],
        name: json["name"],
        buses: List<Bus>.from(json["buses"].map((x) => Bus.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "route_no": routeNo,
        "name": name,
        "buses": List<dynamic>.from(buses.map((x) => x.toJson())),
    };
}

class Bus {
    int id;
    String busNo;
    String name;

    Bus({
        required this.id,
        required this.busNo,
        required this.name,
    });

    factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id"],
        busNo: json["bus_no"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bus_no": busNo,
        "name": name,
    };
}
