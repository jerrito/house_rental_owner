import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/src/home/domain/entities/house.dart';
import 'package:house_rental_admin/src/home/domain/repository/home_repository.dart';

class GetAllHouses
    extends UseCases<QuerySnapshot<HouseDetail>, Map<String, dynamic>> {
  final HomeRepository repository;
  GetAllHouses({required this.repository});
  @override
  Future<Either<String, QuerySnapshot<HouseDetail>>> call(
      Map<String, dynamic> params) async {
    return await repository.getAllHouses(params);
  }
}
