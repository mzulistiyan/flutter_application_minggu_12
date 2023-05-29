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

Future<List<DataMahasiswa>> fetchMahasiswa() async {
  final response = await http.get(Uri.parse('https://a8d7-103-156-164-13.ngrok-free.app/api/mahasiswa'));
  if (response.statusCode == 200) {
    debugPrint("testing 200");
    var data = jsonDecode(response.body);
    var parsed = data['data']['data'].cast<Map<String, dynamic>>();
    return parsed.map<DataMahasiswa>((json) => DataMahasiswa.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load mahasiswa');
  }
}

Future<http.Response> addSeniorResident(
  _nim,
  _name,
  _fakultas,
  _prodi,
  _no_telp,
  _alamat,
  _id_gedung,
) async {
  final res = await http.post(
    Uri.parse('https://a8d7-103-156-164-13.ngrok-free.app/api/storeMahasiswa'),
    body: {
      "nim": _nim,
      "name": _name,
      "fakultas": _fakultas,
      "prodi": _prodi,
      "no_telp": _no_telp,
      "alamat": _alamat,
      "id_gedung": _id_gedung,
    },
  );
  if (res.statusCode == 200) {
    return res;
  } else {
    throw Exception(res.body);
  }
}

class _Tugas12PageState extends State<Tugas12Page> {
  late Future<List<DataMahasiswa>> futureMahasiswa;

  final _nim = TextEditingController(text: "13012049");
  final _name = TextEditingController(text: "Anggun");
  final _fakultas = TextEditingController(text: "Informatika");
  final _prodi = TextEditingController(text: "IF");
  final _no_telp = TextEditingController(text: "083812379288");
  final _alamat = TextEditingController(text: "Bandung");
  final _id_gedung = TextEditingController(text: "2");
  @override
  void initState() {
    super.initState();
    futureMahasiswa = fetchMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<DataMahasiswa>>(
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
                          children: const [
                            Text("Name"),
                            Text("Price"),
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
                        controller: _nim,
                        decoration: const InputDecoration(
                          hintText: "NIM",
                          labelText: "NIM",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      TextField(
                        controller: _name,
                        decoration: const InputDecoration(
                          hintText: "Nama",
                          labelText: "Nama",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      TextField(
                        controller: _fakultas,
                        decoration: const InputDecoration(
                          hintText: "Fakultas",
                          labelText: "Fakultas",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      TextField(
                        controller: _prodi,
                        decoration: const InputDecoration(
                          hintText: "Prodi",
                          labelText: "Prodi",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      TextField(
                        controller: _no_telp,
                        decoration: const InputDecoration(
                          hintText: "No Telp",
                          labelText: "No Telp",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      TextField(
                        controller: _alamat,
                        decoration: const InputDecoration(
                          hintText: "Alamat",
                          labelText: "Alamat",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      TextField(
                        controller: _id_gedung,
                        decoration: const InputDecoration(
                          hintText: "ID Gedung",
                          labelText: "ID Gedung",
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          var res = await addSeniorResident(_nim.text, _name.text, _fakultas.text, _prodi.text, _no_telp.text, _alamat.text, _id_gedung.text);
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
        ));
  }
}
