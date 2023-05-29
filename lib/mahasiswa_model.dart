// To parse this JSON data, do
//
//     final mahasiswaModel = mahasiswaModelFromJson(jsonString);

import 'dart:convert';

MahasiswaModel mahasiswaModelFromJson(String str) => MahasiswaModel.fromJson(json.decode(str));

String mahasiswaModelToJson(MahasiswaModel data) => json.encode(data.toJson());

class MahasiswaModel {
  Meta meta;
  Data data;

  MahasiswaModel({
    required this.meta,
    required this.data,
  });

  factory MahasiswaModel.fromJson(Map<String, dynamic> json) => MahasiswaModel(
        meta: Meta.fromJson(json["meta"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  String message;
  List<DataMahasiswa> data;

  Data({
    required this.message,
    required this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        data: List<DataMahasiswa>.from(json["data"].map((x) => DataMahasiswa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataMahasiswa {
  int nim;
  String name;
  String fakultas;
  String prodi;
  String alamat;
  String noTelp;
  String idGedung;
  DateTime createdAt;
  DateTime updatedAt;

  DataMahasiswa({
    required this.nim,
    required this.name,
    required this.fakultas,
    required this.prodi,
    required this.alamat,
    required this.noTelp,
    required this.idGedung,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataMahasiswa.fromJson(Map<String, dynamic> json) => DataMahasiswa(
        nim: json["nim"],
        name: json["name"],
        fakultas: json["fakultas"],
        prodi: json["prodi"],
        alamat: json["alamat"],
        noTelp: json["no_telp"],
        idGedung: json["id_gedung"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nim": nim,
        "name": name,
        "fakultas": fakultas,
        "prodi": prodi,
        "alamat": alamat,
        "no_telp": noTelp,
        "id_gedung": idGedung,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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
