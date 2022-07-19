import 'package:parking_ticket/User/model/userVP.dart';

class Vehicle{
  String placa;
  List<String> cedulasConductor;
  String horaIngreso;
  String horaSalida;
  String fechaSalida;

  Vehicle({
    required this.placa,
    required this.cedulasConductor,
    required this.horaIngreso,
    required this.horaSalida,
    required this.fechaSalida,
  });

}