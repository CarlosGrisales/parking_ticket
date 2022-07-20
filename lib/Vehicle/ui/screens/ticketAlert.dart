import 'package:flutter/material.dart';
import 'package:parking_ticket/Vehicle/model/vehiculos.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.vehicle,
  }) : super(key: key);

  final String title, description;
  final Vehicle vehicle;

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 159, 189, 241),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          Text(
            "${widget.title}",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text("${widget.description}"),
          SizedBox(height: 20),
          Divider(
            height: 1,
          ),
          Text('placa: ${widget.vehicle.placa}'),
          Text('Conductor: ${widget.vehicle.cedulaConductor}'),
          Text('Hora de Entrada: ${widget.vehicle.horaIngreso}'),
          Text('Hora de salida: ${widget.vehicle.horaSalida}'),
          Text(
              'Minutos totales: ${calcularMinutos(widget.vehicle.horaIngreso, widget.vehicle.horaSalida)}'),
          Text(
              'total a pagar: ${0.01666666666 * calcularMinutos(widget.vehicle.horaIngreso, widget.vehicle.horaSalida)}'),
          Divider(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 80,
                height: 40,
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        "volver",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 80,
                height: 40,
                child: InkWell(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        "generar",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }

  int calcularMinutos(horaIngreso, horaSalida) {
    // Variables auxiliares
    int minutos = 0;
    int ingreso = 0, salida = 0;
    var aux1 = [], aux2 = [];

    //Se hace un split según el patrón "." para obtener horas y minutos
    aux1 = horaIngreso.split(".");
    aux2 = horaSalida.split(".");

    //Se multiplican las horas por 60 para pasarlas a minutos
    ingreso = int.parse(aux1[0]) * 60;
    salida = int.parse(aux2[0]) * 60;

    //Se suman los minutos
    ingreso = ingreso + (int.parse(aux1[1]));
    salida = salida + (int.parse(aux2[1]));

    //Se calcula el tiempo de instancia restando el valor número de la hora de ingreso al de la hora de salida
    minutos = salida - ingreso;

    return minutos;
  }
}
