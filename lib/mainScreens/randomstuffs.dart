import 'dart:convert';
import 'dart:math';
import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class RandomStuffs extends StatefulWidget {
  const RandomStuffs({Key? key}) : super(key: key);

  @override
  State<RandomStuffs> createState() => _RandomStuffsState();
}

var randomInt = 0;
var randomColor = 0xFFFFD3D3;
Random random = Random();
List<int> colorArray = [
  0xFFD3F5FF,
  0xFFFFF3D3,
  0xFFD3FFDD,
  0xFFFFD3D3,
];
var randomStuffsArray = [];

class _RandomStuffsState extends State<RandomStuffs> {
  @override
  void initState() {
    readJson();
    setState(() {
      randomInt = random.nextInt(28);
      randomColor = random.nextInt(3);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const int cardColor = 0xFFFFD3D3;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var flipCardController = FlipCardController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Headline
            Padding(
              padding: const EdgeInsets.only(top: 70, bottom: 25),
              child: Text(
                "Boredom",
                style: GoogleFonts.aBeeZee(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  
                ),
              ),
            ),

            ///Color Card
            Expanded(
              child: FlipCard(
                  controller: flipCardController,
                  front: colorCard(
                    width: width,
                    height: height,
                    cardColor: colorArray[randomColor],
                  ),
                  back: colorCard(
                    height: height,
                    width: width,
                    cardColor: colorArray[randomColor],
                  )),
            ),

            ///refresh button
            GestureDetector(
              onTap: () {
                setState(() {
                  randomInt = random.nextInt(28);
                  randomColor = random.nextInt(3);
                });
              },
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: Color(colorArray[randomColor]),
                  borderRadius: BorderRadius.circular(100),
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
              height: 65,
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
          left: width * .11,
          right: width * .11,
          bottom: height * .030,
          top: height * .025),
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
