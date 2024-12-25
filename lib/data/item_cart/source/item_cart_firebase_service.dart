import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/item_cart_add_req.dart';


abstract class ItemCartFirebaseService{
  Future<Either> addItemToCart(ItemCartAddReq item);
}

class ItemCartFirebaseServiceImp extends ItemCartFirebaseService{
  @override
  Future<Either> addItemToCart(ItemCartAddReq item) async {
    try {
      DocumentReference docRef = FirebaseFirestore.instance.collection('itemCart').doc();
      String itemCartId = docRef.id;

      await docRef.set({
        'itemCartId': itemCartId,
        'userId': FirebaseAuth.instance.currentUser!.uid,
        'productId': item.productId,
        'quantity': item.quantity,
      });

      return Right('add success');
    } catch (e) {
      return Left(e.toString());
    }
  }
}