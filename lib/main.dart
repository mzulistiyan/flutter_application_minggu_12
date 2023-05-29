import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_minggu_12/mahasiswa_model.dart';
//import http
import 'package:http/http.dart' as http;

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

class _Tugas12PageState extends State<Tugas12Page> {
  late Future<List<DataMahasiswa>> futureMahasiswa;

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
    );
  }
}
