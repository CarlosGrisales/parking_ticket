import 'dart:io';

import 'package:flutter/material.dart';
import 'package:parking_ticket/User/ui/screens/homePage.dart';
import 'package:parking_ticket/User/ui/screens/ticketAlert.dart';

class SalidaVehiculo extends StatelessWidget {
   double screenHeight = 0, screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(children: [
            Center(
              child: Container(
                height: screenHeight * 0.3,
                width: screenWidth * 0.8,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  border: Border.all(color: Colors.white54, width: (2)),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 03,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textTitle('SALIDA DE VEHICULO'),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                   _placaTextField(),
   
                  ],
                ),
              ),
            )
          ],),
           SizedBox(
                      height: screenHeight * 0.05,),
          Container (child: bottonLogin() ,)
        ],
      ),
      
      
    );
  }

  Container textTitle(String title) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.020,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

 Widget _placaTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: TextField(
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            icon: Icon(Icons.time_to_leave),
            /* hintText: 'Nombre', */
            labelText: 'Placa',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  
  Widget bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 38, 65, 218),
                  Color.fromARGB(255, 5, 1, 255)
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp),
          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15.0),
          child: Text(
            'Registrar Ingreso',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Lato",
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => CustomAlertDialog( title: "Ticket",
                  description: "Informacion vehiculo y cobro",)),
            ),
          );
        },
      );
    });
  }
}