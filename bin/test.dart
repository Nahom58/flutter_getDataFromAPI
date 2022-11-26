import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

Future main() async {
  var response = await Dio().get('http://localhost:8000/pigeon/users/');

  var jsonData = response.data;

  List<User> users = [];

  for (var u in jsonData) {
    User user = User(u['first_name'], u['age'].toString(), u['registration_country'],
        u['registration_date'].toString(), u['type_id'].toString());
    users.add(user);
  }
  print(users[1].name);
  return users;
}

class User {
  final String name, age, registation_country, registration_date, type_id;
  User(this.name, this.age, this.registation_country, this.registration_date,
      this.type_id);
}
