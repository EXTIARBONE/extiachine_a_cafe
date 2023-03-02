import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_extiachine_a_cafe/widget/pay.dart';
import 'package:google_fonts/google_fonts.dart';

class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBottomSheet(context);
        print("ok");
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // couleur de l'ombre
                    spreadRadius: 3, // rayon de dispersion
                    blurRadius: 7, // flou de l'ombre
                    offset: const Offset(
                        0, 3), // position de l'ombre par rapport au container
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://www.cafes-storme.be/Uploads/Produits/Candy-Bar/kinder-bueno.jpg?maxwidth=600&maxheight=430&quality=90&mode=pad&scale=both',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                  Container(
                    height: 1,
                    width: 200,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                      child: Text(
                    "Kinder",
                    style: GoogleFonts.montserrat(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  SizedBox(
                    height: 4,
                  ),
                  Center(
                      child: Text(
                    "10 points",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                    ),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

void _showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Pay();
    },
  );
}
