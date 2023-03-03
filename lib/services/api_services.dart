import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class ApiServices {
  static const _urlApi = "https://extiarbone-back.azurewebsites.net";

  static Future<void> fetchDataLogin(email, password) async {
    final http.Response response = await http.post(
      (Uri.parse('$_urlApi/auth/login')),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{'mail': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      String name = jsonResponse['name'];
      String score = jsonResponse['score'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', name);
      prefs.setString('score', score);
      
    } else {
      throw Exception('Erreur de connexion');
    }
  }

  static Future<void> signUp(name, surname, mail, password) async {
    final http.Response response = await http.post(
      (Uri.parse('$_urlApi/auth/subscribe')),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'surname': surname,
        'mail': mail,
        'password': password
      }),
    );

    if (response.statusCode == 200) {
      print("Compte cree");
    } else {
      throw Exception('Erreur de connexion');
    }
  }


static Future<void> getUser() async {
    final http.Response response = await http.post(
      (Uri.parse('$_urlApi/auth/subscribe')),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'nfc': "83,44,239,72,113,0,1"
      }),
    );

    if (response.statusCode == 200) {
      print(response);
    } else {
      throw Exception('Erreur de connexion');
    }
  }

 
  static Future<List> getUserCount() async {
    final response = await http.get(
      Uri.parse("https://democracity-api.herokuapp.com/count"),
    );
    if (response.statusCode != 200) {
      throw Error();
    }
    final jsonBody = json.decode(response.body);
    //print(jsonBody);
    final List userCount = (jsonBody as List);
    return userCount;
  }

  static Future<bool> login(String username, String password) async {
    final http.Response response = await http.post(
      (Uri.parse('https://democracity-api.herokuapp.com/login')),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );
    var data = response.body;
    print(data);

    return response.statusCode == 200;
  }

  static Future<bool> addFavorite(String username) async {
    final http.Response response = await http.put(
      (Uri.parse('https://democracity-api.herokuapp.com/favorite/$username')),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );
    var data = response.body;
    print(data);

    return response.statusCode == 200;
  }
}
