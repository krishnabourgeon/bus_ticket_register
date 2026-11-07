// To parse this JSON data, do
//
//     final saveTicketResponse = saveTicketResponseFromJson(jsonString);

import 'dart:convert';

SaveTicketResponse saveTicketResponseFromJson(String str) => SaveTicketResponse.fromJson(json.decode(str));

String saveTicketResponseToJson(SaveTicketResponse data) => json.encode(data.toJson());

class SaveTicketResponse {
    String message;
    Ticket ticket;

    SaveTicketResponse({
        required this.message,
        required this.ticket,
    });

    factory SaveTicketResponse.fromJson(Map<String, dynamic> json) => SaveTicketResponse(
        message: json["message"],
        ticket: Ticket.fromJson(json["ticket"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "ticket": ticket.toJson(),
    };
}

class Ticket {
    int id;
    String ticketNo;
    Bus bus;
    Route route;
    String fromPlace;
    String toPlace;
    int stages;
    int distanceKm;
    int unitFare;
    int passengers;
    int totalAmount;
    DateTime travelDate;
    String status;
    IssuedBy issuedBy;
    String issuedAt;

    Ticket({
        required this.id,
        required this.ticketNo,
        required this.bus,
        required this.route,
        required this.fromPlace,
        required this.toPlace,
        required this.stages,
        required this.distanceKm,
        required this.unitFare,
        required this.passengers,
        required this.totalAmount,
        required this.travelDate,
        required this.status,
        required this.issuedBy,
        required this.issuedAt,
    });

    factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        ticketNo: json["ticket_no"],
        bus: Bus.fromJson(json["bus"]),
        route: Route.fromJson(json["route"]),
        fromPlace: json["from_place"],
        toPlace: json["to_place"],
        stages: json["stages"],
        distanceKm: json["distance_km"],
        unitFare: json["unit_fare"],
        passengers: json["passengers"],
        totalAmount: json["total_amount"],
        travelDate: DateTime.parse(json["travel_date"]),
        status: json["status"],
        issuedBy: IssuedBy.fromJson(json["issued_by"]),
        issuedAt: json["issued_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ticket_no": ticketNo,
        "bus": bus.toJson(),
        "route": route.toJson(),
        "from_place": fromPlace,
        "to_place": toPlace,
        "stages": stages,
        "distance_km": distanceKm,
        "unit_fare": unitFare,
        "passengers": passengers,
        "total_amount": totalAmount,
        "travel_date": "${travelDate.year.toString().padLeft(4, '0')}-${travelDate.month.toString().padLeft(2, '0')}-${travelDate.day.toString().padLeft(2, '0')}",
        "status": status,
        "issued_by": issuedBy.toJson(),
        "issued_at": issuedAt,
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

class IssuedBy {
    int id;
    String name;

    IssuedBy({
        required this.id,
        required this.name,
    });

    factory IssuedBy.fromJson(Map<String, dynamic> json) => IssuedBy(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Route {
    int id;
    String routeNo;
    String name;

    Route({
        required this.id,
        required this.routeNo,
        required this.name,
    });

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        routeNo: json["route_no"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "route_no": routeNo,
        "name": name,
    };
}
