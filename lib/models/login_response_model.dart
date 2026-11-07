// class LoginResponseModel {
//   bool? status;
//   String? message;
//   String? token;
//   LoginResponseModel({this.status, this.message, this.token});
//   LoginResponseModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     token = json['token'];
//   }
// }




// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
    String message;
    String tokenType;
    String accessToken;
    User user;
    Duty duty;

    LoginResponseModel({
        required this.message,
        required this.tokenType,
        required this.accessToken,
        required this.user,
        required this.duty,
    });

    factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
        message: json["message"],
        tokenType: json["token_type"],
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
        duty: Duty.fromJson(json["duty"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "token_type": tokenType,
        "access_token": accessToken,
        "user": user.toJson(),
        "duty": duty.toJson(),
    };
}

class Duty {
    Route route;
    BusLogin bus;

    Duty({
        required this.route,
        required this.bus,
    });

    factory Duty.fromJson(Map<String, dynamic> json) => Duty(
        route: Route.fromJson(json["route"]),
        bus: BusLogin.fromJson(json["bus"]),
    );

    Map<String, dynamic> toJson() => {
        "route": route.toJson(),
        "bus": bus.toJson(),
    };
}

class BusLogin {
    int id;
    String busNo;
    String name;

    BusLogin({
        required this.id,
        required this.busNo,
        required this.name,
    });

    factory BusLogin.fromJson(Map<String, dynamic> json) => BusLogin(
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

class User {
    int id;
    String name;
    String username;
    String email;
    String role;
    String status;
    String phone;
    String gender;
    DateTime dateOfBirth;
    dynamic address;
    dynamic city;
    dynamic state;
    dynamic country;
    dynamic postalCode;
    String fullAddress;
    DateTime createdAt;

    User({
        required this.id,
        required this.name,
        required this.username,
        required this.email,
        required this.role,
        required this.status,
        required this.phone,
        required this.gender,
        required this.dateOfBirth,
        required this.address,
        required this.city,
        required this.state,
        required this.country,
        required this.postalCode,
        required this.fullAddress,
        required this.createdAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        role: json["role"],
        status: json["status"],
        phone: json["phone"],
        gender: json["gender"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postal_code"],
        fullAddress: json["full_address"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "role": role,
        "status": status,
        "phone": phone,
        "gender": gender,
        "date_of_birth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "postal_code": postalCode,
        "full_address": fullAddress,
        "created_at": createdAt.toIso8601String(),
    };
}
