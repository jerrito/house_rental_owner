import 'package:equatable/equatable.dart';
import 'package:house_rental_admin/src/home/domain/entities/place_search.dart';

class HouseDetail extends Equatable {
  final String? houseName, owner, phoneNumber, description, category;
  final num? amount, bedRoomCount, bathRoomCount, lat, lng;
  final bool? isAvailable;
   final String? formatedAddress;
  final List<String>? images;

  const HouseDetail({
    required this.category,
    required this.owner,
    required this.phoneNumber,
    required this.houseName,
    required this.description,
    required this.amount,
    required this.images,
    required this.bedRoomCount,
    required this.isAvailable,
    required this.bathRoomCount,
    required this.formatedAddress,
    required this.lat,
    required this.lng,

  });

  @override
  List<Object?> get props => [
        houseName,
        description,
        owner,
        amount,
        phoneNumber,
        bedRoomCount,
        bathRoomCount,
        images,
        isAvailable,
        lat,
        lng,
        formatedAddress,
        category
      ];
}

class HouseLocation extends Equatable {
  final String? formatedAddress;
  final num? lat, lng;

  const HouseLocation({required this.formatedAddress, required this.lat, required this.lng});

  @override
  List<Object?> get props => [formatedAddress, lat,lng];
}
