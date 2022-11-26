import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../env.sample.dart';
import '../models/user.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<User>> users;
  final employeeListKey = GlobalKey<HomeState>();

  @override
  void initState() {
    super.initState();
    users = getUserList();
  }

  Future<List<User>> getUserList() async {
    final response = await http.get(Uri.http('127.0.0.1:8000', 'pigeon/users'));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<User> employees = items.map<User>((json) {
      return User.fromJson(json);
    }).toList();


    return employees;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: employeeListKey,
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: users,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return CircularProgressIndicator();
            // Render employee lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      data.name,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}