// To parse this JSON data, do
//
//     final placesModel = placesModelFromJson(jsonString);

import 'dart:convert';

PlacesModel placesModelFromJson(String str) => PlacesModel.fromJson(json.decode(str));

String placesModelToJson(PlacesModel data) => json.encode(data.toJson());

class PlacesModel {
    Bus? bus;
    Route? route;
    FromPlace? fromPlace;
    FromPlace? toPlace;
    int? stages;
    int? distanceKm;
    FareRule? fareRule;
    Calculation? calculation;
    List<FromPlace> stops;
    DateTime? travelDate;
    int unitFare;
    int passengers;
    int totalAmount;

    PlacesModel({
        this.bus,
        this.route,
        this.fromPlace,
        this.toPlace,
        this.stages,
        this.distanceKm,
        this.fareRule,
        this.calculation,
        this.stops = const [],
        this.travelDate,
        this.unitFare = 0,
        this.passengers = 1,
        this.totalAmount = 0,
    });

    factory PlacesModel.fromJson(Map<String, dynamic> json) => PlacesModel(
        bus: json["bus"] != null ? Bus.fromJson(json["bus"]) : null,
        route: json["route"] != null ? Route.fromJson(json["route"]) : null,
        fromPlace: json["from_place"] != null ? FromPlace.fromJson(json["from_place"]) : null,
        toPlace: json["to_place"] != null ? FromPlace.fromJson(json["to_place"]) : null,
        stages: json["stages"] != null ? (json["stages"] as num).toInt() : null,
        distanceKm: json["distance_km"] != null ? (json["distance_km"] as num).toInt() : null,
        fareRule: json["fare_rule"] != null ? FareRule.fromJson(json["fare_rule"]) : null,
        calculation: json["calculation"] != null ? Calculation.fromJson(json["calculation"]) : null,
        stops: json["stops"] != null
            ? List<FromPlace>.from(json["stops"].map((x) => FromPlace.fromJson(x)))
            : <FromPlace>[],
        travelDate: json["travel_date"] != null ? DateTime.tryParse(json["travel_date"].toString()) : null,
        unitFare: json["unit_fare"] != null
            ? (json["unit_fare"] as num).toInt()
            : (json["calculation"] != null && json["calculation"]["unit_fare"] != null
                ? (json["calculation"]["unit_fare"] as num).toInt()
                : 0),
        passengers: json["passengers"] != null ? (json["passengers"] as num).toInt() : 1,
        totalAmount: json["total_amount"] != null ? (json["total_amount"] as num).toInt() : 0,
    );

    Map<String, dynamic> toJson() => {
        if (bus != null) "bus": bus!.toJson(),
        if (route != null) "route": route!.toJson(),
        if (fromPlace != null) "from_place": fromPlace!.toJson(),
        if (toPlace != null) "to_place": toPlace!.toJson(),
        if (stages != null) "stages": stages,
        if (distanceKm != null) "distance_km": distanceKm,
        if (fareRule != null) "fare_rule": fareRule!.toJson(),
        if (calculation != null) "calculation": calculation!.toJson(),
        "stops": List<dynamic>.from(stops.map((x) => x.toJson())),
        if (travelDate != null)
          "travel_date":
              "${travelDate!.year.toString().padLeft(4, '0')}-${travelDate!.month.toString().padLeft(2, '0')}-${travelDate!.day.toString().padLeft(2, '0')}",
        "unit_fare": unitFare,
        "passengers": passengers,
        "total_amount": totalAmount,
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
        id: json["id"] != null ? (json["id"] as num).toInt() : 0,
        busNo: json["bus_no"]?.toString() ?? '',
        name: json["name"]?.toString() ?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "bus_no": busNo,
        "name": name,
    };
}

class Calculation {
    int minimumCharge;
    int extraKm;
    int extraAmount;
    int exactFare;
    int unitFare;
    String formula;

    Calculation({
        required this.minimumCharge,
        required this.extraKm,
        required this.extraAmount,
        required this.exactFare,
        required this.unitFare,
        required this.formula,
    });

    factory Calculation.fromJson(Map<String, dynamic> json) => Calculation(
        minimumCharge: json["minimum_charge"] != null ? (json["minimum_charge"] as num).toInt() : 0,
        extraKm: json["extra_km"] != null ? (json["extra_km"] as num).toInt() : 0,
        extraAmount: json["extra_amount"] != null ? (json["extra_amount"] as num).toInt() : 0,
        exactFare: json["exact_fare"] != null ? (json["exact_fare"] as num).toInt() : 0,
        unitFare: json["unit_fare"] != null ? (json["unit_fare"] as num).toInt() : 0,
        formula: json["formula"]?.toString() ?? '',
    );

    Map<String, dynamic> toJson() => {
        "minimum_charge": minimumCharge,
        "extra_km": extraKm,
        "extra_amount": extraAmount,
        "exact_fare": exactFare,
        "unit_fare": unitFare,
        "formula": formula,
    };
}

class FareRule {
    int id;
    String name;
    int minimumCharge;
    int minimumKm;
    int ratePerKm;

    FareRule({
        required this.id,
        required this.name,
        required this.minimumCharge,
        required this.minimumKm,
        required this.ratePerKm,
    });

    factory FareRule.fromJson(Map<String, dynamic> json) => FareRule(
        id: json["id"] != null ? (json["id"] as num).toInt() : 0,
        name: json["name"]?.toString() ?? '',
        minimumCharge: json["minimum_charge"] != null ? (json["minimum_charge"] as num).toInt() : 0,
        minimumKm: json["minimum_km"] != null ? (json["minimum_km"] as num).toInt() : 0,
        ratePerKm: json["rate_per_km"] != null ? (json["rate_per_km"] as num).toInt() : 0,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "minimum_charge": minimumCharge,
        "minimum_km": minimumKm,
        "rate_per_km": ratePerKm,
    };
}

class FromPlace {
    int id;
    String name;
    String? code;
    int stageNo;
    int km;
    int? kmFromBoarding;

    FromPlace({
        required this.id,
        required this.name,
        required this.code,
        required this.stageNo,
        required this.km,
        this.kmFromBoarding,
    });

    factory FromPlace.fromJson(Map<String, dynamic> json) => FromPlace(
        id: json["id"] != null ? (json["id"] as num).toInt() : 0,
        name: json["name"]?.toString() ?? '',
        code: json["code"]?.toString(),
        stageNo: json["stage_no"] != null ? (json["stage_no"] as num).toInt() : 0,
        km: json["km"] != null ? (json["km"] as num).toInt() : 0,
        kmFromBoarding: json["km_from_boarding"] != null ? (json["km_from_boarding"] as num).toInt() : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "stage_no": stageNo,
        "km": km,
        "km_from_boarding": kmFromBoarding,
    };
}

class Route {
    int id;
    String routeNo;
    String name;
    String start;
    String end;
    String direction;

    Route({
        required this.id,
        required this.routeNo,
        required this.name,
        required this.start,
        required this.end,
        required this.direction,
    });

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"] != null ? (json["id"] as num).toInt() : 0,
        routeNo: json["route_no"]?.toString() ?? '',
        name: json["name"]?.toString() ?? '',
        start: json["start"]?.toString() ?? '',
        end: json["end"]?.toString() ?? '',
        direction: json["direction"]?.toString() ?? '',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "route_no": routeNo,
        "name": name,
        "start": start,
        "end": end,
        "direction": direction,
    };
}
