import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/foundation.dart';
import 'package:house_rental_admin/src/authentication/data/datasources/local_ds.dart';
import 'package:house_rental_admin/src/authentication/data/models/owner_model.dart';
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';

abstract class AuthenticationRemoteDatasource {
  Future<OwnerModel?> signin(Map<String, dynamic> params);
  Future<DocumentReference<OwnerModel>?> signup(Map<String, dynamic> params);
  Future<auth.User> verifyOTP(auth.PhoneAuthCredential credential);
  Future<void> updateUser(Map<String, dynamic> params);
  Future<void> addId(Map<String, dynamic> params);
}

class AuthenticationRemoteDatasourceImpl
    implements AuthenticationRemoteDatasource {
  final auth.FirebaseAuth firebaseAuth;
  final AuthenticationLocalDatasource localDatasource;
  AuthenticationRemoteDatasourceImpl(
      {required this.localDatasource, required this.firebaseAuth});
  final usersRef = FirebaseFirestore.instance
      .collection('houseRentalAdminAccount')
      .withConverter<OwnerModel>(
        fromFirestore: (snapshot, _) => OwnerModel.fromJson(snapshot.data()!),
        toFirestore: (owner, _) => owner.toMap(),
      );
  @override
  Future<OwnerModel> signin(Map<String, dynamic> params) async {
    // UserModel result;

    return await usersRef
        .where("email", isEqualTo: params["email"])
        .where("password", isEqualTo: params["password"])
        .get()
        .then((snapshot) {
      var userSnapShot = snapshot.docs;
      return userSnapShot.first.data();
    });
  }

  @override
  Future<DocumentReference<OwnerModel>?> signup(
      Map<String, dynamic> params) async {
    final response = usersRef.add(OwnerModel.fromJson(params));
    localDatasource.cacheUserData(OwnerModel.fromJson(params));
    return response;
  }

  @override
  Future<auth.User> verifyOTP(auth.PhoneAuthCredential credential) async {
    final response = await firebaseAuth.signInWithCredential(credential);

    if (kDebugMode) {
      print(response.user?.uid);
    }

    return response.user!;
  }

  @override
  Future<void> updateUser(Map<String, dynamic> params) async {
    await usersRef.doc(params["id"]).update(params);
    await localDatasource.cacheUserData(OwnerModel.fromJson(params));
  }

  @override
  Future<void> addId(Map<String, dynamic> params) async {
    await usersRef
        .where("phone_number", isEqualTo: params["phone_number"])
        .get()
        .then((value) async {
      var userData = value.docs.first;

      Owner? data;

      data = userData.data();
      data.id = userData.id;
      data.uid ??= params["uid"];
     
      //localDatasource.cacheUserData(UserModel.fromJson(data.toMap()));

      await usersRef.doc(userData.id).update({"id": userData.id,"uid":data.uid ?? params["uid"]});
      await localDatasource.cacheUserData(OwnerModel.fromJson(data.toMap()));
     

     
      //return userData.data();
      //return value;
    });
  }
}
