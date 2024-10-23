import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class ProductFirebaseService {
  Future<Either> getTopSellingProducts();
  Future<Either> getNewInProducts();
}

class ProductFirebaseServiceImp extends ProductFirebaseService {
  @override
  Future<Either> getTopSellingProducts() async {
    try {
      var returnedData = await FirebaseFirestore.instance
          .collection('Products')
          .orderBy('saledNumber', descending: true)
          .limit(5)
          .get();

      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left("Please try again");
    }
  }

  @override
  Future<Either> getNewInProducts() async {
    try {
      var returnedData = await FirebaseFirestore.instance
          .collection('Products')
          .orderBy('createdDate', descending: true)
          .limit(5)
          .get();

      return Right(returnedData.docs.map((e) => e.data()).toList());
    } catch (e) {
      return const Left("Please try again");
    }
  }
}
