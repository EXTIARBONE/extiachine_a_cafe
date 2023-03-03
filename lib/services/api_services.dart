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
      (Uri.parse('$_urlApi/nfc/getInfo')),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{'nfc': "83,44,239,72,113,0,1"}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);

      String name = jsonResponse['name'];
      String score = jsonResponse['score'].toString();
      String userId = jsonResponse['_id'].toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', name);
      prefs.setString('score', score);
      prefs.setString('userId', userId);
      print("name and score: $name $score");
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

  static Future<bool> subPoints(int score, String userId) async {
    print("Score: $score");
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('score', score.toString());
    final http.Response response = await http.put(
      (Uri.parse('https://extiarbone-back.azurewebsites.net/user/nfc/6400fe950c5d30d8b1735768')),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, int>{'score': score}),
    );
    if (response.statusCode == 200) {
      print("nombre de points mis a jours");
      return true;
    } else {
      throw Exception('Erreur de connexion');
    }
  }
}
