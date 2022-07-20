import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:parking_ticket/Vehicle/ui/screens/homePage.dart';

import '../../../main.dart';
import '../../bloc/bloc_user.dart';
import '../../model/vehiculos.dart';

class ParqueoVehiculo extends StatelessWidget {
  double screenHeight = 0, screenWidth = 0;

  String _placa = "",
      _conductor = "",
      _horaIngreso = "",
      _horaSalida = "",
      _fecha = "";
  UserBloc _userBloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    _userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Stack(
          children: [
            Center(
              child: Container(
                height: screenHeight * 0.4,
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
                    textTitle('Parqueo de vehiculo'),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    _placaTextField(),
                    _conductorTextField(),
                    _horaIngresoTextField(),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: screenHeight * 0.05,
        ),
        TextButton(
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
            print(_conductor + " ES " + _horaIngreso);
            Vehicle vehicle = Vehicle(
              placa: _placa,
              cedulaConductor: _conductor,
              horaIngreso: _horaIngreso,
              horaSalida: _horaSalida,
              fechaSalida: _fecha,
            );
            _userBloc.createVehicle(vehicle);
            if (_placa == ""){
               showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text('No Agregado'),
                content: Text(
                    'Debes ingresar una placa para poder registrar correctamente'),
                actions: [
                  TextButton(
                    child: Text('ok'),
                    onPressed: () {
                      Navigator.of(context,
                      ).pop('ok');
                    },
                  )
                ],
              ),
            ).then((result) {
              print(result);
            });

            }else{
                showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text('Agregado'),
                content: Text(
                    'vehiculo agregrado correctamente a la base de datos.'),
                actions: [
                  TextButton(
                    child: Text('ok'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => MyHomePage()),
                        ),
                      );
                    },
                  )
                ],
              ),
            ).then((result) {
              print(result);
            });
            }
           
          },
        )
      ]),
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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: TextField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          icon: Icon(Icons.time_to_leave),
          /* hintText: 'Nombre', */
          labelText: 'Placa',
        ),
        onChanged: (value) {
          _placa = value;
        },
      ),
    );
  }

  _conductorTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.person),
          /* hintText: 'Nombre', */
          labelText: 'Cedula Conductor',
        ),
        onChanged: (value) {
          _conductor = value;
        },
      ),
    );
  }

  _horaIngresoTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: TextField(
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          icon: Icon(Icons.timelapse),
          /* hintText: 'Nombre', */
          labelText: 'Hora ingreso',
        ),
        onChanged: (value) {
          _horaIngreso = value;
        },
      ),
    );
  }

  _horaSalidaTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: TextField(
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          icon: Icon(Icons.timelapse),
          labelText: 'hora salida',
        ),
        onChanged: (value) {
          _horaSalida = value;
        },
      ),
    );
  }

  _fechaTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
      ),
      child: TextField(
        keyboardType: TextInputType.datetime,
        decoration: InputDecoration(
          icon: Icon(Icons.timelapse),
          labelText: 'Fecha de salida',
        ),
        onChanged: (value) {
          _fecha = value;
        },
      ),
    );
  }

  /*  Widget registar() {
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
        print(_conductor + " ES " + _horaIngreso);
        Vehicle vehicle = Vehicle(
          placa: _placa,
          cedulaConductor: _conductor,
          horaIngreso: _horaIngreso,
          horaSalida: _horaSalida,
          fechaSalida: _fecha,
        );
        _userBloc.createVehicle(vehicle);
        showDialog(context: context, builder: (context)=>
        AlertDialog(
          title: Text('agregado'),
          content: Text('vehiculo agregrado correctamente'),
          actions: [TextButton(child: Text('ok'), onPressed: (){},)],
        ));
      },

    );
  } */

}
