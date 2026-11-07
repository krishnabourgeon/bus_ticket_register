// To parse this JSON data, do
//
//     final saveTicketBody = saveTicketBodyFromJson(jsonString);

import 'dart:convert';

SaveTicketBody saveTicketBodyFromJson(String str) => SaveTicketBody.fromJson(json.decode(str));

String saveTicketBodyToJson(SaveTicketBody data) => json.encode(data.toJson());

class SaveTicketBody {
    int fromPlaceId;
    int toPlaceId;
    int passengers;
    int fare;
    int totalAmount;
    DateTime date;

    SaveTicketBody({
        required this.fromPlaceId,
        required this.toPlaceId,
        required this.passengers,
        required this.fare,
        required this.totalAmount,
        required this.date,
    });

    factory SaveTicketBody.fromJson(Map<String, dynamic> json) => SaveTicketBody(
        fromPlaceId: json["from_place_id"],
        toPlaceId: json["to_place_id"],
        passengers: json["passengers"],
        fare: json["fare"],
        totalAmount: json["total_amount"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "from_place_id": fromPlaceId,
        "to_place_id": toPlaceId,
        "passengers": passengers,
        "fare": fare,
        "total_amount": totalAmount,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    };
}
