// To parse this JSON data, do
//
//     final responseSuccesss = responseSuccesssFromJson(jsonString);

import 'dart:convert';

ResponseSuccesss responseSuccesssFromJson(String str) => ResponseSuccesss.fromJson(json.decode(str));

String responseSuccesssToJson(ResponseSuccesss data) => json.encode(data.toJson());

class ResponseSuccesss {
  Meta meta;
  ResponseSuccesssData data;

  ResponseSuccesss({
    required this.meta,
    required this.data,
  });

  factory ResponseSuccesss.fromJson(Map<String, dynamic> json) => ResponseSuccesss(
        meta: Meta.fromJson(json["meta"]),
        data: ResponseSuccesssData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class ResponseSuccesssData {
  String message;
  DataData data;

  ResponseSuccesssData({
    required this.message,
    required this.data,
  });

  factory ResponseSuccesssData.fromJson(Map<String, dynamic> json) => ResponseSuccesssData(
        message: json["message"],
        data: DataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class DataData {
  int nim;
  String name;
  String fakultas;
  String prodi;
  String alamat;
  String noTelp;
  String idGedung;
  DateTime updatedAt;
  DateTime createdAt;

  DataData({
    required this.nim,
    required this.name,
    required this.fakultas,
    required this.prodi,
    required this.alamat,
    required this.noTelp,
    required this.idGedung,
    required this.updatedAt,
    required this.createdAt,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        nim: json["nim"],
        name: json["name"],
        fakultas: json["fakultas"],
        prodi: json["prodi"],
        alamat: json["alamat"],
        noTelp: json["no_telp"],
        idGedung: json["id_gedung"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nim": nim,
        "name": name,
        "fakultas": fakultas,
        "prodi": prodi,
        "alamat": alamat,
        "no_telp": noTelp,
        "id_gedung": idGedung,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
      };
}

class Meta {
  int code;
  String status;
  String message;

  Meta({
    required this.code,
    required this.status,
    required this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        code: json["code"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
      };
}
