import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:souvenir_shop/data/auth/models/user_creation_req.dart';
import 'package:souvenir_shop/data/auth/models/user_signin_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signUp(UserCreationReq user);

  Future<Either> getAges();

  Future<Either> signIn(UserSignInReq user);
}

class AuthFirebaserServiceImp extends AuthFirebaseService {
  @override
  Future<Either> signUp(UserCreationReq user) async {
    try {
      var returnedData = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user.email!, password: user.password!);
      await FirebaseFirestore.instance
          .collection('User')
          .doc(returnedData.user!.uid)
          .set({
        'name': user.name,
        'email': user.email,
        'gender': user.gender,
        'age': user.age
      });
      print(returnedData.user!.email);

      return Right('Sign up was successfull');
    } on FirebaseAuthException catch (e) {
      String message = '';
      message = e.code;

      return Left(message);
    }
  }

  @override
  Future<Either> getAges() async {
    try {
      var returnedData =
          await FirebaseFirestore.instance.collection("Ages").get();
      return Right(returnedData.docs);
    } catch (e) {
      return const Left('Error');
    }
  }

  @override
  Future<Either> signIn(UserSignInReq user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: user.email!, password: user.password!);
      return const Right('Sign In success');
    } on FirebaseAuthException catch (e) {
      return Left(e.code);
    }

  }
}
