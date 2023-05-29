// To parse this JSON data, do
//
//     final gedungModel = gedungModelFromJson(jsonString);

import 'dart:convert';

GedungModel gedungModelFromJson(String str) => GedungModel.fromJson(json.decode(str));

String gedungModelToJson(GedungModel data) => json.encode(data.toJson());

class GedungModel {
  bool success;
  String message;
  List<Datum> data;

  GedungModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GedungModel.fromJson(Map<String, dynamic> json) => GedungModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String namaGedung;
  String statusGedung;
  String alamat;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.namaGedung,
    required this.statusGedung,
    required this.alamat,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        namaGedung: json["nama_gedung"],
        statusGedung: json["status_gedung"],
        alamat: json["alamat"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_gedung": namaGedung,
        "status_gedung": statusGedung,
        "alamat": alamat,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
