import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_extiachine_a_cafe/pages/scanner.dart';
import 'package:google_fonts/google_fonts.dart';

class Pay extends StatelessWidget {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 200,
        child: Column(
          
          children: [
            SizedBox(height: 10,),
            Text("Achat:",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 10,),
            Text("Kinder Bueno",
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10,),
            Text("10 points",
            style: GoogleFonts.montserrat(
              fontSize: 16,
            ),
          ),
          SizedBox(height: 30,),
            ElevatedButton(
            onPressed: () {
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