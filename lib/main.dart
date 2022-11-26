import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Data',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'User Data'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  _DataFromAPIState createState() => _DataFromAPIState();
}

class _DataFromAPIState extends State<MyHomePage> {
  Future getUserData() async {
    var response =
        await Dio().get('http://10.0.2.2:8000/pigeon/users/');

    var jsonData = response.data;

    List<User> users = [];

    for (var u in jsonData) {
      User user = User(u['first_name']);
      users.add(user);
    }

    print(users.length);

    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
            child: Card(
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  print('here 0');
                  print(snapshot.data);
                  return Container(
                      child: const Center(
                    child: Text('loading NOW...'),
                  ));
                } else {
                  print('here 1');
                  print(snapshot.data);
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data[index].first_name),
                          // subtitle: Text(snapshot.data[index].userName),
                          // trailing: Text(snapshot.data[index].email),
                        );
                      });
                }
              }),
        )));
  }
}

class User {
  final String first_name;
  User(this.first_name);
}
