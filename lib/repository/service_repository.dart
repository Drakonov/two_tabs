import 'dart:convert';

import 'package:jsonrpc2/jsonrpc2.dart';

import '../const_in_app.dart';
import 'package:http/http.dart' as http;
import '../models/repository/Todo.dart';
import '../models/repository/Users.dart';
import 'jsonrpc_http_client.dart';

class ServiceRepository {
  static Future<List<User>> getUsers() async {
    return await http.get(Uri.parse(urlUsers), headers: {
      "Accept": "application/json",
      "Content-type": "application/json"
    }).then((http.Response response) {
      List<User> users = [];
      print(response.body);
      List res = json.decode(response.body);
      print(users);
      for (var item in res) {
        users.add(User.fromJson(item));
      }
      print(users);
      return users;
    });
  }

  static Future<List<Todo>> getTodo() async {
    return await http.get(Uri.parse(urlTodo), headers: {
      "Accept": "application/json",
      "Content-type": "application/json"
    }).then((http.Response response) {
      List<Todo> todo = [];
      print(response.body);
      List res = json.decode(response.body);
      print(todo);
      for (var item in res) {
        todo.add(Todo.fromJson(item));
      }
      print(todo);
      return todo;
    });
  }
}
