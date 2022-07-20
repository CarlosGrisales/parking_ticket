import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

import 'Vehicle/bloc/bloc_user.dart';
import 'Vehicle/ui/screens/homePage.dart';
import 'Vehicle/ui/screens/parqueoVehiculo.dart';
import 'Vehicle/ui/screens/salidaVehiculo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
      bloc: UserBloc( ) ,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 1;
  final screen = [
    ParqueoVehiculo(),
    Homepage(),
    SalidaVehiculo(),
  ];
  // ignore: deprecated_member_use

  @override
  Widget build(BuildContext context) => Scaffold(
        body: screen[index],
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            indicatorColor: Colors.white,
          ),
          child: NavigationBar(
            height: 60,
            backgroundColor: Color(0xFF01415B),
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
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
                label: 'Salida',
              )
            ],
          ),
        ),
      );
}
