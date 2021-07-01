
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto/models/favorite_model.dart';
import 'package:proyecto/models/productos_model.dart';
import 'dart:async';

final CollectionReference productCollection =
FirebaseFirestore.instance.collection("productos");
final CollectionReference favoriteCollection =
FirebaseFirestore.instance.collection("favoritos");

class FirebaseService {
  static final FirebaseService _instance = new FirebaseService.internal();
  factory FirebaseService() => _instance;

  FirebaseService.internal();
//------------------------------------------------------------------------------------------------------------------
  Future<ProductosModel> createProduct(
      String name, String image, int price, String descripcion, String numerotel, String correo,String ubicacion) {
    final TransactionHandler createTransaction = (Transaction tx) async {
    final DocumentSnapshot docs = await tx.get(productCollection.doc());

      final ProductosModel producto = new ProductosModel(docs.id,name,image,price,descripcion,numerotel,correo,ubicacion);
      final Map<String, dynamic> data = producto.toMap();

      await tx.set(docs.reference, data);

      return data;
    };

    return FirebaseFirestore.instance.runTransaction(createTransaction).then((mapData) {
      return ProductosModel.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getProductList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshot = productCollection.snapshots();

    if (offset != null) {
      snapshot = snapshot.skip(offset);
    }

    if (limit != null) {
      snapshot = snapshot.skip(limit);
    }

    return snapshot;
  }
//------------------------------------------------------------------------------------------------------------------
  Future<FavoritosModel> createFavorite(
      String name, String image, String addfav) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot docs = await tx.get(productCollection.doc());

      final FavoritosModel favorito = new FavoritosModel(docs.id,name,image,addfav);
      final Map<String, dynamic> data = favorito.toMap();

      await tx.set(docs.reference, data);

      return data;
    };

    return FirebaseFirestore.instance.runTransaction(createTransaction).then((mapData) {
      return FavoritosModel.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getFavoriteList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshotfav = favoriteCollection.snapshots();

    if (offset != null) {
      snapshotfav = snapshotfav.skip(offset);
    }

    if (limit != null) {
      snapshotfav = snapshotfav.skip(limit);
    }

    return snapshotfav;
  }


}



