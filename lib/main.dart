import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_minggu_12/mahasiswa_model.dart';
//import http
import 'package:http/http.dart' as http;

import 'mahasiswa_success.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Tugas12Page(),
    );
  }
}

class Tugas12Page extends StatefulWidget {
  const Tugas12Page({super.key});

  @override
  State<Tugas12Page> createState() => _Tugas12PageState();
}

Future<List<Datum>> fetchMahasiswa() async {
  final response = await http.get(Uri.parse('https://ae39-103-156-164-13.ngrok-free.app/api/gedung'));
  if (response.statusCode == 200) {
    debugPrint("testing 200");
    var data = jsonDecode(response.body);
    var parsed = data['data'].cast<Map<String, dynamic>>();
    return parsed.map<Datum>((json) => Datum.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load mahasiswa');
  }
}

Future<http.Response> addSeniorResident(
  namaGedung,
  nomorGedung,
  longtitude,
  latitude,
) async {
  final res = await http.post(
    Uri.parse('https://ae39-103-156-164-13.ngrok-free.app/api/gedung'),
    body: {
      "nama_gedung": namaGedung,
      "nomor_gedung": nomorGedung,
      "longtitude": longtitude,
      "latitude": latitude,
    },
  );
  if (res.statusCode == 200) {
    return res;
  } else {
    throw Exception(res.body);
  }
}

class _Tugas12PageState extends State<Tugas12Page> {
  late Future<List<Datum>> futureMahasiswa;

  //DARI SINI
  final namaGedungController = TextEditingController(text: "Gedung - B");
  final nomorGedungController = TextEditingController(text: "112");
  final longtitudeController = TextEditingController(text: "00000");
  final latitudeController = TextEditingController(text: "00000");

  @override
  void initState() {
    super.initState();
    futureMahasiswa = fetchMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Datum>>(
        future: futureMahasiswa,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  child: InkWell(
                    child: Container(
                      child: Column(
                        children: [
                          Text(snapshot.data![index].namaGedung),
                          Text(snapshot.data![index].statusGedung),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text("Tambah Data"),
                  children: [
                    TextField(
                      controller: namaGedungController,
                      decoration: const InputDecoration(
                        hintText: "Nama Gedung",
                        labelText: "Nama Gedung",
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    TextField(
                      controller: nomorGedungController,
                      decoration: const InputDecoration(
                        hintText: "Nama",
                        labelText: "Nama",
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    TextField(
                      controller: longtitudeController,
                      decoration: const InputDecoration(
                        hintText: "Fakultas",
                        labelText: "Fakultas",
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    TextField(
                      controller: latitudeController,
                      decoration: const InputDecoration(
                        hintText: "Prodi",
                        labelText: "Prodi",
                        contentPadding: EdgeInsets.all(10),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        var res = await addSeniorResident(
                          namaGedungController.text,
                          nomorGedungController.text,
                          longtitudeController.text,
                          latitudeController.text,
                        );
                        if (res.statusCode != 200) {
                          throw Exception('Unexpected error occured!');
                        } else {
                          setState(() {
                            futureMahasiswa = fetchMahasiswa();
                          });
                        }
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                        var snackBar = const SnackBar(
                          content: Text('Data berhasil ditambahkan'),
                        );
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: const Text("Tambah"),
                    ),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
