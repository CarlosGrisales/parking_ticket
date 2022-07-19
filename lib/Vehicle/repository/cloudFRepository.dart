import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/vehiculos.dart';
import 'firestoreAPI.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  //Añadiendo el vehículo a la database
  void createVehicle(Vehicle vehicle) =>
      _cloudFirestoreAPI.createVehicle(vehicle);

  //Actualizando undato específico
  Future<void> generalUpdate(
      String collection, String id, String field, dynamic content) =>
      _cloudFirestoreAPI.generalUpdate(collection, id, field, content);
  Future<void> updateVehicleData(Vehicle vehicle) =>
      _cloudFirestoreAPI.updateVehicleData(vehicle);

  //Leyendo datos de los vehículos
  Future<Vehicle> buildVehicle(
          String placa) =>
      _cloudFirestoreAPI.buildVehicle(
          placa);
  
}
