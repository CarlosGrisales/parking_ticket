import 'dart:io';

import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:parking_ticket/Vehicle/model/vehiculos.dart';

import '../../../Vehicle/ui/screens/ticketAlert.dart';
import '../../bloc/bloc_user.dart';

class SalidaVehiculo extends StatelessWidget {
  double screenHeight = 0, screenWidth = 0;
  String _placa = "", _horaSalida = "";
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
                      textTitle('SALIDA DE VEHICULO'),
                      SizedBox(
                        height: screenHeight * 0.03,
                      ),
                      _placaTextField(),
                      _horaSalidaTextField(),
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
            child: validar(),
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

  Widget validar() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return TextButton(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Color(0xFF005148),
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
            horaIngreso: "00.00",
            horaSalida: "00.00",
            placa: "UNSET",
          );
          await _userBloc.buildVehicle(_placa).then((value) {
            // ESTE ES ¨PARA TRAER EL VEHICULO DE LA DB
            _vehiculoValidado = value;
            var aux = "SE GENERAR TICKET";
            var auxdescription = "Informacion vehiculo y cobro";
            if (_vehiculoValidado.horaIngreso == "00.00") {
              aux = "NO PUEDE GENERAR TICKET";
              auxdescription = "Placa registrada no encontrada";
            }
            ;

            ///Esto es para actualizar el valor
            ///Lo podrías utilizar para generar el ticket de salida
            ///Es decir, actualizar el valor de horaIngreso y horaSalida
            ///PERO debes enviar un objeto Vehicle con todos los datos instanciados
            
            _vehiculoValidado.horaSalida = _horaSalida;
            _userBloc.updateVehicleData(_vehiculoValidado);

            ///FIN DE ACTUALIZAR DATO

            ///color(0xFF 000B0D)

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: ((context) => CustomAlertDialog(
                      title: aux,
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
