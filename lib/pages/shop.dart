import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_extiachine_a_cafe/services/api_services.dart';
import 'package:flutter_extiachine_a_cafe/widget/product.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late String name = '';
  late int score = 0;

  Future<String?> _getPrefsName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    return name;
  }

  Future<int?> _getPrefsScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? score = int.parse(prefs.getString('score')!);
    return score;
  }

  
  @override
  void initState() {
    super.initState();
    ApiServices.getUser();
    _setPrefs();
  }

  void _setPrefs() async {
    String? prefsName = await _getPrefsName();
    int? prefsScore = await _getPrefsScore();
    setState(() {
      name = prefsName ?? '';
      score = prefsScore!;
    });
    print("name : $name");
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 212, 154),
      body: Center(
        child: Row(
          children: [
            const SizedBox(width: 30),
            Column(
              children: [
                const SizedBox(height: 70),
                Text(
                  "EXTIARBONE",
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  height: 120,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xFF265D62),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.grey.withOpacity(0.5), // couleur de l'ombre
                        spreadRadius: 3, // rayon de dispersion
                        blurRadius: 7, // flou de l'ombre
                        offset: const Offset(0,
                            3), // position de l'ombre par rapport au container
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Bonjour $name",
                              style: GoogleFonts.montserrat(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        "Vous avez $score points",
                        style: GoogleFonts.montserrat(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Row(
                        children: [
                          Column(
                            children: const [
                              Product(),
                              Product(),
                              Product(),
                              Product(),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            children: const [
                              Product(),
                              Product(),
                              Product(),
                              Product(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
