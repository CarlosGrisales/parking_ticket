import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parking_ticket/Vehicle/ui/screens/sign_in_screen.dart';

import '../../../main.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class Homepage extends StatelessWidget {
  double screenHeight = 0, screenWidth = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Material(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.15,
                  /* color: Colors.yellow, */
                  child: Image.asset(
                    'assets/img/mpos.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Center(
                  child: Container(
                    height: screenHeight * 0.4,
                    width: screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: Color(0xFF019587),
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
                        textTitle('App Para Valet Parking'),
                        SizedBox(
                          height: screenHeight * 0.05,
                        ),
                        textinfo(
                            'Descripción del rol operativo Usuario habilitado para gestionar el ingreso y salida de vehículos, recaudando y facturando a los clientes.')
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
           
          ],
        ),
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

  Container textinfo(String info) {
    return Container(
      height: screenHeight * 0.1,
      width: screenWidth * 0.6,
      child: Text(
        info,
        style: TextStyle(
            color: Colors.white,
            fontSize: screenHeight * 0.015,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}
