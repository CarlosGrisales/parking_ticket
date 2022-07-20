import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:parking_ticket/Vehicle/model/vehiculos.dart';

import '../../../Vehicle/ui/screens/ticketAlert.dart';
import '../../bloc/bloc_user.dart';

class SalidaVehiculo extends StatelessWidget {
  double screenHeight = 0, screenWidth = 0;
  String _placa = "";
  UserBloc _userBloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    _userBloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
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
            ],
          ),
          SizedBox(
            height: screenHeight * 0.05,
          ),
          Container(
            child: bottonLogin(),
          )
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
          onChanged: (value) {
            _placa = value;
          },
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
            'Validar Placa',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Lato",
            ),
          ),
        ),
        onPressed: () async {
          Vehicle _vehiculoValidado = Vehicle(
            cedulaConductor: "UNSET",
            fechaSalida: "UNSET",
            horaIngreso: "UNSET",
            horaSalida: "UNSET",
            placa: "UNSET",
          );
          await _userBloc.buildVehicle(_placa).then((value) { // ESTE ES ¨PARA TRAER EL VEHICULO DE LA DB
            _vehiculoValidado = value;
            var aux= "PUEDE GENERAR TICKET";
            var auxdescription = "Informacion vehiculo y cobro";
            if(_vehiculoValidado.horaIngreso=="NONSET"){
              aux= "NO PUEDE GENERAR TICKET";
              auxdescription = "Placa registrada no encontrada";
            }; 


           
            



            ///Esto es para actualizar el valor
            ///Lo podrías utilizar para generar el ticket de salida
            ///Es decir, actualizar el valor de horaIngreso y horaSalida
            ///PERO debes enviar un objeto Vehicle con todos los datos instanciados
            Vehicle _nuevoVehiculo = Vehicle(
              cedulaConductor: _vehiculoValidado.cedulaConductor,
            fechaSalida: "20221025",
            horaIngreso: "NONSET", //6000
            horaSalida: "12.30", //6150
            placa: _vehiculoValidado.placa,
            );
            _userBloc.updateVehicleData(_nuevoVehiculo);
            ///FIN DE ACTUALIZAR DATO
       
            ///color(0xFF 000B0D)


            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CustomAlertDialog(
                      title:
                          aux,
                      description: auxdescription,
                      vehicle: _vehiculoValidado,
                    )),
              ),
            );
          });
        },
      );
    });
  }
}
