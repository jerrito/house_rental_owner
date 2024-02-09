import 'package:house_rental_admin/src/home/domain/entities/house.dart';

class HouseDetailModel extends HouseDetail {
  const HouseDetailModel(
      {required super.houseName,
      required super.description,
      required super.amount,
      required super.images,
      required super.bedRoomCount,
      required super.bathRoomCount,
      required super.owner,
      required super.phoneNumber,
      required super.isAvailable,
      required super.category,
      required super.lng,
      required super.formatedAddress,
      required super.lat,
      });

  factory HouseDetailModel.fromJson(Map<String, dynamic>? json) =>
      HouseDetailModel(
        houseName: json?["house_name"],
        description: json?["description"],
        amount: json?["amount"],
        images: List<String>.from(json?["images"].map((e) => e)),
        bedRoomCount: json?["bed_room_count"],
        bathRoomCount: json?["bath_room_count"],
        phoneNumber: json?["phone_number"],
        owner: json?["owner"],
        isAvailable: json?["is_available"],
        category: json?["category"],
        lat: json?["lat"],
        lng: json?["lng"],
        formatedAddress: json?["formatted_address"],
        // houseLocation: HouseLocationModel.fromJson(json?["house_details"]),
      );

  Map<String, dynamic> toMap() {
    return {
      "house_name": houseName,
      "description": description,
      "owner": owner,
      "phone_number": phoneNumber,
      "amount": amount,
      "bed_room_count": bedRoomCount,
      "bath_room_count": bathRoomCount,
      "images": images,
      "category": category,
      "is_available": isAvailable,
      "lng": lng,
      "formatted_address": formatedAddress,
      "lat": lat,
    };
  }
}

class HouseLocationModel extends HouseLocation {
  const HouseLocationModel(
      {required super.formatedAddress, required super.lat, required super.lng});

  factory HouseLocationModel.fromJson(Map<String, dynamic>? json) =>
      HouseLocationModel(
          formatedAddress: json?["formatted_address"],
          lat: json?["lat"],
          lng: json?["lng"]);

  Map<String, dynamic> toMap() {
    return {
      "formatted_address": formatedAddress,
      "lat": lat,
      "lng": lng,
    };
  }
}
