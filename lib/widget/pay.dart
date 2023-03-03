import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_extiachine_a_cafe/pages/scanner.dart';
import 'package:flutter_extiachine_a_cafe/services/api_services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pay extends StatefulWidget {
  const Pay({super.key});

  @override
  State<Pay> createState() => _PayState();
}

class _PayState extends State<Pay> {
  late int score;
  late String userId = '';
  bool _showDialog = false;

  void initState() {
    super.initState();
    _setPrefs();
  }

  Future<String?> _getPrefsUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    return userId;
  }

  Future<int?> _getPrefsScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? score = int.parse(prefs.getString('score')!);
    return score;
  }

  void _setPrefs() async {
    String? prefsId = await _getPrefsUserId();
    int? prefsScore = await _getPrefsScore();
    setState(() {
      userId = prefsId ?? '';
      int scoree = prefsScore!;
      score = scoree - 10;
    });
    print("score : $score");
  }

  void checkPoints(String userId, int score) {
    if (score <= 0) {
      print("pas assez d'argent");
    } else {
      
      ApiServices.subPoints(score, userId);
      setState(() {
        _showDialog = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showDialog) {
      return AlertDialog(
        title: Text("Votre achat a été effectué avec succès !"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _showDialog = false;
              });
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    }
    return Container(
      height: 200,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Achat:",
            style: GoogleFonts.montserrat(
                fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Kinder Bueno",
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "10 points",
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {
              print("OOooOo $score");
              //_showDialog = true;
              checkPoints(userId, score);
              //sleep(Duration(seconds: 2));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Scanner()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF5EB09C),
              ),
            ),
            child: Text(
              "Valider",
              style: GoogleFonts.montserrat(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
