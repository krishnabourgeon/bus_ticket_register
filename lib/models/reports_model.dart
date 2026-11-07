// // To parse this JSON data, do
// //
// //     final reportsModel = reportsModelFromJson(jsonString);

// import 'dart:convert';

// ReportsModel reportsModelFromJson(String str) => ReportsModel.fromJson(json.decode(str));

// String reportsModelToJson(ReportsModel data) => json.encode(data.toJson());

// class ReportsModel {
//     String message;
//     Filters filters;
//     Summary summary;
//     List<Summary> dailyCollection;

//     ReportsModel({
//         required this.message,
//         required this.filters,
//         required this.summary,
//         required this.dailyCollection,
//     });

//     factory ReportsModel.fromJson(Map<String, dynamic> json) => ReportsModel(
//         message: json["message"],
//         filters: Filters.fromJson(json["filters"]),
//         summary: Summary.fromJson(json["summary"]),
//         dailyCollection: List<Summary>.from(json["daily_collection"].map((x) => Summary.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "message": message,
//         "filters": filters.toJson(),
//         "summary": summary.toJson(),
//         "daily_collection": List<dynamic>.from(dailyCollection.map((x) => x.toJson())),
//     };
// }

// class Summary {
//     DateTime? date;
//     int totalTickets;
//     int totalPassengers;
//     int totalAmount;

//     Summary({
//         this.date,
//         required this.totalTickets,
//         required this.totalPassengers,
//         required this.totalAmount,
//     });

//     factory Summary.fromJson(Map<String, dynamic> json) => Summary(
//         date: json["date"] == null ? null : DateTime.parse(json["date"]),
//         totalTickets: json["total_tickets"],
//         totalPassengers: json["total_passengers"],
//         totalAmount: json["total_amount"],
//     );

//     Map<String, dynamic> toJson() => {
//         "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
//         "total_tickets": totalTickets,
//         "total_passengers": totalPassengers,
//         "total_amount": totalAmount,
//     };
// }

// class Filters {
//     DateTime fromDate;
//     DateTime toDate;

//     Filters({
//         required this.fromDate,
//         required this.toDate,
//     });

//     factory Filters.fromJson(Map<String, dynamic> json) => Filters(
//         fromDate: DateTime.parse(json["from_date"]),
//         toDate: DateTime.parse(json["to_date"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "from_date": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
//         "to_date": "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
//     };
// }




// To parse this JSON data, do
//
//     final reportsModel = reportsModelFromJson(jsonString);

import 'dart:convert';

ReportsModel reportsModelFromJson(String str) => ReportsModel.fromJson(json.decode(str));

String reportsModelToJson(ReportsModel data) => json.encode(data.toJson());

class ReportsModel {
    String message;
    Filters filters;
    Summary summary;
    List<Summary> dailyCollection;

    ReportsModel({
        required this.message,
        required this.filters,
        required this.summary,
        required this.dailyCollection,
    });

    factory ReportsModel.fromJson(Map<String, dynamic> json) => ReportsModel(
        message: json["message"],
        filters: Filters.fromJson(json["filters"]),
        summary: Summary.fromJson(json["summary"]),
        dailyCollection: List<Summary>.from(json["daily_collection"].map((x) => Summary.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "filters": filters.toJson(),
        "summary": summary.toJson(),
        "daily_collection": List<dynamic>.from(dailyCollection.map((x) => x.toJson())),
    };
}

class Summary {
    DateTime? date;
    int totalTickets;
    int totalPassengers;
    int totalAmount;

    Summary({
        this.date,
        required this.totalTickets,
        required this.totalPassengers,
        required this.totalAmount,
    });

    factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        totalTickets: json["total_tickets"],
        totalPassengers: json["total_passengers"],
        totalAmount: json["total_amount"],
    );

    Map<String, dynamic> toJson() => {
        "date": date == null ? null : "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "total_tickets": totalTickets,
        "total_passengers": totalPassengers,
        "total_amount": totalAmount,
    };
}

class Filters {
    DateTime fromDate;
    DateTime toDate;

    Filters({
        required this.fromDate,
        required this.toDate,
    });

    factory Filters.fromJson(Map<String, dynamic> json) => Filters(
        fromDate: DateTime.parse(json["from_date"]),
        toDate: DateTime.parse(json["to_date"]),
    );

    Map<String, dynamic> toJson() => {
        "from_date": "${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')}",
        "to_date": "${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')}",
    };
}
