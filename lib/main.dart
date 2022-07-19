import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:parking_ticket/User/bloc/bloc_user.dart';
import 'package:parking_ticket/User/ui/screens/homePage.dart';
import 'package:parking_ticket/User/ui/screens/sign_in_screen.dart';
import 'package:parking_ticket/parking/bloc/bloc_parking.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(child: MaterialApp(title:  'Flutter Demo', home: SignInScreen(),), bloc: UserBloc());
  }
}

class MyHomePage extends StatefulWidget {
 
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  // ignore: deprecated_member_use

  @override
  Widget build(BuildContext context) {

  return Scaffold(
     
     body:Homepage() ,
     bottomNavigationBar: BottomNavigationBar(
       currentIndex: currentIndex, onTap: (index)=> setState(()=> currentIndex = index) ,

       // this will be set when a new tab is tapped
       items: [
         BottomNavigationBarItem(
           icon:  Icon(Icons.car_rental),
           label:'Ingreso',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.house),
           label:'Home',
         ),
         BottomNavigationBarItem(
           icon: Icon(Icons.car_crash,),
           label:
           'Salida'
         )
       ],
       backgroundColor: Colors.deepOrange,
     ),
   );
 }
}