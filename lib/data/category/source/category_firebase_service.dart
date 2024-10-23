import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryFireBaseService {
  Future<Either> getCategories();
}

class CategoryFireBaseServiceImp extends CategoryFireBaseService {
  @override
  Future<Either> getCategories() async {
    try {
      var returnedData =
          await FirebaseFirestore.instance.collection('Categories').get();
      return Right(returnedData.docs.map((value)=>value.data()).toList());
    } catch (e) {
      return Left("Pls try again");
    }
  }
}
