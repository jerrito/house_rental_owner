import 'package:dartz/dartz.dart';
import 'package:house_rental_admin/core/usecase/usecase.dart';
import 'package:house_rental_admin/src/home/data/models/house_model.dart';
import 'package:house_rental_admin/src/home/domain/repository/home_repository.dart';

class AddLocation extends UseCases<HouseLocationModel, Map<String, dynamic>> {
  final HomeRepository repository;

  AddLocation({required this.repository});
  @override
  Future<Either<String, HouseLocationModel>> call(
      Map<String, dynamic> params) async {
    return await repository.addLocation(params);
  }
}
