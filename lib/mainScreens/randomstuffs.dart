import 'dart:convert';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RandomStuffs extends StatefulWidget {
  const RandomStuffs({Key? key}) : super(key: key);

  @override
  State<RandomStuffs> createState() => _RandomStuffsState();
}

var randomInt = 0;
Random random = Random();

var randomStuffsArray = [];

class _RandomStuffsState extends State<RandomStuffs> {
  @override
  void initState() {
    readJson();
    setState(() {
      randomInt = random.nextInt(28);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const  int cardColor = 0xFFFFD3D3;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Headline
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Boredom",
                style: GoogleFonts.aBeeZee(fontSize: 25),
              ),
            ),

            ///Color Card
            Expanded(
              child: FlipCard(
                  front: colorCard(
                    width: width,
                    height: height,
                    cardColor: cardColor,
                  ),
                  back: colorCard(
                    height: height,
                    width: width,
                    cardColor: 0xFFD3FFDD,
                  )),
            ),

            ///refresh button
            GestureDetector(
              onTap: () {
                setState(() {
                  randomInt = random.nextInt(28);
                });
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(cardColor),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(5, 5),
                        color: Colors.black.withOpacity(.2),
                        blurRadius: 20.0),
                    const BoxShadow(
                        offset: Offset(-5, -5),
                        color: Colors.white,
                        blurRadius: 20.0)
                  ],
                ),
                child: const Icon(Icons.autorenew),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('asset/stufs.json');
    final data = await json.decode(response);
    setState(() {
      randomStuffsArray = data["randomStuffs"];
    });
  }
}

class colorCard extends StatelessWidget {
  const colorCard({
    Key? key,
    required this.width,
    required this.height,
    required this.cardColor,
  }) : super(key: key);

  final double width;
  final double height;
  final int cardColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          left: width * .15,
          right: width * .15,
          bottom: height * .15,
          top: height * .12),
      decoration: BoxDecoration(
        color: Color(cardColor),
        boxShadow: [
          BoxShadow(
              offset: const Offset(5, 5),
              color: Colors.black.withOpacity(.2),
              blurRadius: 20.0),
          const BoxShadow(
              offset: Offset(-10, -10), color: Colors.white, blurRadius: 20.0)
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          randomStuffsArray[randomInt]["stuf"],
          textAlign: TextAlign.center,
          style: GoogleFonts.aBeeZee(fontSize: 25),
        ),
      ),
    );
  }
}
