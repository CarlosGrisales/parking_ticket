import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:parking_ticket/User/ui/screens/registrarVehiculo.dart';
import 'package:parking_ticket/User/ui/screens/salidaVehiculo.dart';
import 'package:parking_ticket/main.dart';
import '../../../widgets/button_green.dart';
import '../../../widgets/gradient_black.dart';
import '../../bloc/bloc_user.dart';
import 'homePage.dart';

///Estas clase realiza la validacion del usuario en el login(asdfkjaklsjdf).

class SignInScreen extends StatefulWidget {
  @override
  State createState() {
    return _SignInScreen();
  }
}

class _SignInScreen extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late UserBloc userBloc;
  double screenHeight = 0, screenWidth = 0;

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    userBloc = BlocProvider.of(context);
    return signInGoogleUI();
  }

  Widget signInGoogleUI() {
    return Material(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            GradientBack(height: screenHeight * 1),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      width: screenWidth * 0.5,
                      child: Text(
                        "Bienvenido",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontFamily: "Lato",
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  _userTextField(),
                  SizedBox(height: screenHeight * 0.05),
                  _passwoerTextField(),
                  SizedBox(height: screenHeight * 0.05),
                  _bottonLogin(),
                  SizedBox(height: screenHeight * 0.05),
                  /*    ButtonGreen(
                       text: "Login",
                      onPressed: () {},
                      width: screenWidth * 0.4,
                      height: screenHeight * 0.05) */
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: TextField(
          controller: emailController,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            /* hintText: 'Nombre', */
            labelText: 'Correo',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _passwoerTextField() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: TextField(
          controller: passwordController,
          keyboardType: TextInputType.name,
          obscureText: true,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            /*    hintText: 'Contraseña', */
            labelText: 'Contraseña',
          ),
          onChanged: (value) {},
        ),
      );
    });
  }

  Widget _bottonLogin() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 241, 145, 20),
                  Color.fromARGB(255, 255, 124, 1)
                ],
                begin: FractionalOffset(0.2, 0.0),
                end: FractionalOffset(1.0, 0.6),
                stops: [0.0, 0.6],
                tileMode: TileMode.clamp),
          ),
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15.0),
          child: Text(
            'Iniciar sesion',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Lato",
            ),
          ),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Homepage()));
        },
      );
    });
  }
}
