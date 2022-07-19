import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientBack extends StatelessWidget {
  String title = "Popular";
  double height;
  GradientBack({Key? key, required this.height}); //heigth = null full screen

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    if (height == null) {
      height = screenHeight;
    }

    return Container(
        width: screenWidth,
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 76, 169, 245), Color.fromARGB(255, 37, 175, 230)],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp)),
        child: FittedBox(
          fit: BoxFit.none,
          alignment: Alignment(-1.5, -0.8),
          child: Container(
            width: screenHeight,
            height: screenHeight,
            decoration: BoxDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              borderRadius: BorderRadius.circular(screenHeight / 2),
            ),
          ),
        )
        /*Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontFamily: "lato",
          fontWeight: FontWeight.bold,
        ),
      ),
      alignment: Alignment(-0.9, -0.6),*/
        );
  }
}
