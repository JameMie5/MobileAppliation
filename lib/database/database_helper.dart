import 'package:cloud_firestore/cloud_firestore.dart';
import 'model.dart';

class DatabaseHelper {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection(Product.collestionName);
  //insert
  Future<DocumentReference> insertProduct(Product product) {
    return collection.add(product.toJson());
 }

  //update
  Future updateProduct(Product product)  async {
    await collection.doc(product.referenceId).update(product.toJson());
 }

  //delete
  Future deleteProduct(Product product) async {
    await collection.doc(product.referenceId).delete();
 }

  //get
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
 }

  //search
  Future<QuerySnapshot> searchProduct(String keyValue)  {
    return collection.where(Product.colName, isEqualTo: keyValue).get();
        
  }

  readProducts() {}
}