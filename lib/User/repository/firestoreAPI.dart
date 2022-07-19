import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_ticket/User/model/userVP.dart';
import 'package:parking_ticket/User/model/vehiculos.dart';

class CloudFirestoreAPI {
  final String USERS = "users";
  final String LSONS = "stLsons";

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> generalUpdate(String collection, String id, String field, dynamic content) async { 
    DocumentReference ref = _db.collection(collection).doc(id);
    print("Llega a update de $field");
    return await ref.set({
      field: content,
    }, SetOptions(merge: true));
  }

  Future<void> updateVehicleData(Vehicle vehicle) async {
    DocumentReference refLson = _db.collection("vehicles").doc(vehicle.placa);
    await refLson.update(
      {
        'horaIngreso': vehicle.horaIngreso,
        'horaSalida': vehicle.horaSalida,
        'fechaSalida': vehicle.fechaSalida,
      },
    );
  }

 /*  UserVP buildUserData(List<DocumentSnapshot> profileSnapshot) {
    //print(profileSnapshot.length);
    UserVP userVP = UserVP(
      apellidos: "example",
      nombres: "example",
      cedula: "000000",
    );
    profileSnapshot.forEach(
      (data) {
        //print(data['cash']);
        Map<String, dynamic> json = data.data() as Map<String, dynamic>;
        userVP.cedula = json["cedula"] ?? false;
        userVP.apellidos = json["apellidos"] ?? false;
        userVP.nombres = json["nombres"] ?? false;
      },
    );
    //print(profileData.name);
    return userVP;
  }
 */
  
  Future<void> createVehicle(Vehicle vehicle) async {
    DocumentReference refLsons = _db.collection("vehicles").doc(vehicle.placa);
    refLsons.set({
      'placa': vehicle.placa,
      'cedulasConductor': vehicle.cedulasConductor,
      "horaIngreso": vehicle.horaIngreso,
      "horaSalida": vehicle.horaSalida,
      "fechaSalida": vehicle.fechaSalida,
    });
  }

  List<Vehicle> buildVehicles(List<DocumentSnapshot> losnsListSnapshot) {
    List<Vehicle> vehicleList = [];

    //var lsonList = getSongs();
    losnsListSnapshot.forEach(
      (l) {
        Vehicle vehicle = Vehicle(
          placa: (l.data() as dynamic)['placa'],
          cedulasConductor: (l.data() as dynamic)['cedulasConductor'],
          horaIngreso: (l.data() as dynamic)['horaIngreso'],
          horaSalida: (l.data() as dynamic)['horaSalida'],
          fechaSalida: (l.data() as dynamic)['fechaSalida'],
        );
        vehicleList.add(vehicle);
      },
    );
    //vehicleList.shuffle();
    return vehicleList;
  }
}
