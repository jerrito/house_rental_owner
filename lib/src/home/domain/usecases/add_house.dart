import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/src/home/data/models/house_model.dart';
import 'package:house_rental_admin/src/home/domain/repository/home_repository.dart';

class AddHouse extends UseCases<DocumentReference<HouseDetailModel>?,
    Map<String, dynamic>> {
  final HomeRepository repository;

  AddHouse({required this.repository});
  @override
  Future<Either<String, DocumentReference<HouseDetailModel>?>> call(
      Map<String, dynamic> params) async {
    return await repository.addHouse(params);
  }
}
