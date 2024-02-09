import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:house_rental_admin/core/apis/api_key.dart';
import 'package:house_rental_admin/src/home/data/models/house_model.dart';
import 'package:house_rental_admin/src/home/data/models/place_search_model.dart';
import "package:http/http.dart" as http;

abstract class HomeRemoteDataSource {
  Future<DocumentReference<HouseDetailModel>?> addHouse(
      Map<String, dynamic> params);

  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(
      Map<String, dynamic> params);

  Future<List<String>> upLoadMultipleImages(Map<String, dynamic> params);

  Future<void> updateHouse(Map<String, dynamic> params);

  Future<PlaceSearchModel> placeSearch(Map<String, dynamic> params);

  Future<PlaceSearchModel> getPlaceByLatLng(Map<String, dynamic> params);
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final usersRef = FirebaseFirestore.instance
      .collection('houseRentalAdminAccount')
      .doc()
      .withConverter<HouseDetailModel>(
        fromFirestore: (snapshot, _) =>
            HouseDetailModel.fromJson(snapshot.data()!),
        toFirestore: (houseDetail, _) => houseDetail.toMap(),
      );
  @override
  Future<DocumentReference<HouseDetailModel>> addHouse(
      Map<String, dynamic> params) async {
    final response = await FirebaseFirestore.instance
        // .collection('houseRentalAdminAccount')
        // .doc(params["id"])
        .collection("houses")
        .withConverter<HouseDetailModel>(
          fromFirestore: (snapshot, _) =>
              HouseDetailModel.fromJson(snapshot.data()!),
          toFirestore: (house, _) => house.toMap(),
        )
        .add(HouseDetailModel.fromJson(params));
    return response;
  }

  @override
  Future<QuerySnapshot<HouseDetailModel>> getAllHouses(
      Map<String, dynamic> params) async {
    final response = await FirebaseFirestore.instance
        .collection("houses")
        .where("phone_number", isEqualTo: params["phone_number"])
        .withConverter<HouseDetailModel>(
          fromFirestore: (snapshot, _) =>
              HouseDetailModel.fromJson(snapshot.data()!),
          toFirestore: (houseDetail, _) => houseDetail.toMap(),
        )
        .get();

    return response;
  }

  @override
  Future<List<String>> upLoadMultipleImages(Map<String, dynamic> params) async {
    //Upload file
    final upLoadPath = FirebaseStorage.instance
        .ref()
        .child(
          params["phone_number"],
        )
        .child("houses");
    List<String> returnURL = [];

    for (int i = 0; i < params["images"]; i++) {
      final upLoadTask = upLoadPath.child(params["path"][i]).putFile(
        File(params["path"][i]),
      );

      await upLoadTask.whenComplete(
        () => upLoadPath.child(params["path"][i]).getDownloadURL().then((value) => returnURL.add(value)),
      );
    }

    //print(returnURL);

    return returnURL;
  }

  @override
  Future<void> updateHouse(Map<String, dynamic> params) async {
    final response = await FirebaseFirestore.instance
        //.collection('houseRentalAdminAccount')
        
        .collection("houses")
        .doc(params["id"])
        // .withConverter<HouseDetailModel>(
        //   fromFirestore: (snapshot, _) =>
        //       HouseDetailModel.fromJson(snapshot.data()!),
        //   toFirestore: (house, _) => house.toMap(),
        // )
        
        .update(params);
    return response;
  }

  @override
  Future<PlaceSearchModel> placeSearch(Map<String, dynamic> params) async {
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/place/textsearch/json?location=7.9465%2C1.0232°&query=${params["place"]}&region=gh&radius=10000&key=$api"));

    return PlaceSearchModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<PlaceSearchModel> getPlaceByLatLng(Map<String, dynamic> params) async {
    final response = await http.get(Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${params["lat"]}%2C${params["lng"]}&region=gh&key=$api"));
    print(response.body);
    print(jsonDecode(response.body));
    return PlaceSearchModel.fromJson(jsonDecode(response.body));
  }
  
  
}
