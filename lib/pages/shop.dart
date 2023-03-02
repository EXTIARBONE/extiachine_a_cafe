import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_extiachine_a_cafe/widget/product.dart';
import 'package:google_fonts/google_fonts.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Row(
          children: [
            const SizedBox(width: 25),
            Column(
              children: [
                const SizedBox(height: 70),
                Text("EXTIARBONE",
                style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Text("Bonjour Nicolas",
                style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Text("Vous avez 2 points",
                style: GoogleFonts.montserrat(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
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
                          const SizedBox(width: 15,),
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
