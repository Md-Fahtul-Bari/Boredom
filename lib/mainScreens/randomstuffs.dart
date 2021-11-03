import 'package:flutter/material.dart';

class RandomStuffs extends StatelessWidget {
  const RandomStuffs({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const color = 0xFFEEF4F4;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(color),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            // #regoon cool
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  left: width * .15,
                  right: width * .15,
                  bottom: height * .2,
                  top: height * .2),
              decoration: BoxDecoration(
                color: const Color(color),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(5, 5),
                      color: Colors.black.withOpacity(.2),
                      blurRadius: 20.0),
                  const BoxShadow(
                      offset: Offset(-10, -10),
                      color: Colors.white,
                      blurRadius: 20.0)
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("If you are bored...Play this game"),
            ),
            // #endregion
          ),
        ],
      ),
    );
  }
}
