import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:parking_ticket/User/bloc/bloc_user.dart';
import 'package:parking_ticket/User/ui/screens/homePage.dart';
import 'package:parking_ticket/User/ui/screens/registrarVehiculo.dart';
import 'package:parking_ticket/User/ui/screens/salidaVehiculo.dart';
import 'package:parking_ticket/User/ui/screens/sign_in_screen.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        child:  MaterialApp(
          title: 'Flutter Demo',
          home:  SignInScreen(),
        ),
        bloc: UserBloc(),);
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 1;
  final screen = [
    RegistarVehiculo(),
    Homepage(),
    SalidaVehiculo(),
  ];
  // ignore: deprecated_member_use

  @override
  Widget build(BuildContext context) => Scaffold(
    body: screen[index],
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            indicatorColor: Colors.blue,
          ),
          child:  NavigationBar(
            height: 60,
            backgroundColor: Colors.deepOrange,
            selectedIndex: index,
            onDestinationSelected: (index)=> setState(()=>
              this.index = index
            ),
            destinations: const [
               NavigationDestination(
                icon: Icon(Icons.car_rental),
                label: 'Ingreso',
              ),
              NavigationDestination(
                icon: Icon(Icons.house),
                label: 'Home',
              ),
              NavigationDestination(
                  icon: Icon(
                    Icons.car_crash,
                  ),
                  label: 'Salida')
            ],
          ),
        ),
      );
}
