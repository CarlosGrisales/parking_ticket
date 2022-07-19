import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:parking_ticket/User/model/userVP.dart';
import 'package:parking_ticket/User/model/vehiculos.dart';

import '../repository/auth_repository.dart';
import '../repository/cloudFRepository.dart';
import '../repository/firestoreAPI.dart';

class UserBloc implements Bloc{
 final _cloudFirestoreRepository = CloudFirestoreRepository();

  //Actualizando datos
  Future<void> generalUpdate(String collection, String id, String field, dynamic content) =>
      _cloudFirestoreRepository.generalUpdate(collection, id, field, content);
  Future<void> updateVehicleData(Vehicle vehicle) =>
      _cloudFirestoreRepository.updateVehicleData(vehicle);

  //Leer los datos de las cards
  List<Vehicle> buildVehicles(
          List<DocumentSnapshot> losnsListSnapshot
          ) =>
      _cloudFirestoreRepository.buildVehicles(
          losnsListSnapshot);

  
  //Añade un nuevo Lson a la base de datos
  Future<void> createVehicle(Vehicle vehicle) async =>
      _cloudFirestoreRepository.createVehicle(vehicle);

  @override
  void dispose() {}
}