import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/vehiculos.dart';

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
      'cedulasConductor': vehicle.cedulaConductor,
      "horaIngreso": vehicle.horaIngreso,
      "horaSalida": vehicle.horaSalida,
      "fechaSalida": vehicle.fechaSalida,
    });
  }

  Future<Vehicle> buildVehicle(String placa) async {
    ///Este método trae el vehiculo de la base de datos.
    ///Pide como parámetro la placa del carro, para saber qué carro traer
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    Query query = _firestore
        .collection("vehicles")
        .where("placa", isEqualTo: placa);
    QuerySnapshot querySnapshot = await query.get();
     Vehicle _vehicle = Vehicle(
      cedulaConductor: "NONSET",
      fechaSalida: "NONSET",
      horaIngreso: "NONSET",
      horaSalida: "NONSET",
      placa: "NONSET",
     );
    if (querySnapshot.docs.length > 0) {
      var element = querySnapshot.docs[0];
       _vehicle = Vehicle(
        cedulaConductor: (element.data() as dynamic)['cedulaConductor'],
        fechaSalida: (element.data() as dynamic)['fechaSalida'],
        horaIngreso: (element.data() as dynamic)['horaIngreso'],
        horaSalida:(element.data() as dynamic)['horaSalida'] ,
        placa: (element.data() as dynamic)['placa'],
      );
      
    } else print("NO ENCONTRO NADA");
    return _vehicle;
  }

  
}
