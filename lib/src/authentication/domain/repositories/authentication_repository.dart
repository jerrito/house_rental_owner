import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
// data/repository/authentication_repository.dart
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:house_rental_admin/src/authentication/domain/entities/owner.dart';

abstract class AuthenticationRepository {
  Future<Either<String, Owner?>> signIn(Map<String, dynamic> params);

  Future<Either<String, DocumentReference<Owner>?>> signUp(
      Map<String, dynamic> params);

  Future<Either<String, void>> verifyPhoneNumber(
      String phoneNumber,
      Function(String verificationId, int? resendToken) onCodeSent,
      Function(auth.PhoneAuthCredential phoneAuthCredential) onCompleted,
      Function(auth.FirebaseAuthException) onFailed);

  Future<Either<String, void>> verifyPhoneNumberLogin(
      String phoneNumber,
      Function(String verificationId, int? resendToken) onCodeSent,
      Function(auth.PhoneAuthCredential phoneAuthCredential) onCompleted,
      Function(auth.FirebaseAuthException) onFailed);

  Future<Either<String, auth.User>> verifyOTP(
      auth.PhoneAuthCredential credential);

  Future<Either<String, Owner>> getOwnerCacheData();

  Future<Either<String, void>> updateUser(Map<String, dynamic> params);

  Future<Either<String, void>> addId(Map<String, dynamic> params);

  Future<Either<String, String>> upLoadImage(Map<String, dynamic> params);
  Future<Either<String, bool>> checkPhoneNumberChange(Map<String, dynamic> params);
  Future<Either<String, Owner?>> getUser(Map<String, dynamic> params);
  
}
