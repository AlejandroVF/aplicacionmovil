import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyecto/models/favorite_model.dart';
import 'package:proyecto/models/productos_model.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/models/productos_model.dart';
import 'package:proyecto/services/firebase_services.dart';
import 'package:url_launcher/url_launcher.dart';

class CartPage extends StatefulWidget {
  final List<ProductosModel> _cart;

  CartPage(this._cart);

  @override
  _CartPageState createState() => _CartPageState(this._cart);
}

class _CartPageState extends State<CartPage> {
  _CartPageState(this._cart);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  List<ProductosModel> _cart;

  //---------------------------------------------------------------------------------
  List<FavoritosModel> _favoritosModel = List<FavoritosModel>();
  FirebaseService db = new FirebaseService();
  StreamSubscription<QuerySnapshot> favoritosSub;

  @override
  void initState() {
    super.initState();
//-------------------------------------------------------------------------
    _favoritosModel = new List();

    favoritosSub?.cancel();
    favoritosSub = db.getFavoriteList().listen((QuerySnapshot snapshot) {
      final List<FavoritosModel> favorites = snapshot.docs
          .map((documentSnapshot) =>
          FavoritosModel.fromMap(documentSnapshot.data()))
          .toList();

      setState(() {
        this._favoritosModel = favorites;
      });
    });
  }

  @override
  void dispose() {
    favoritosSub?.cancel();
    super.dispose();
  }
  //---------------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text('Favoritos'),
      ),
      body: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (_enabled && _firstScroll) {
              _scrollController
                  .jumpTo(_scrollController.position.pixels - details.delta.dy);
            }
          },
          onVerticalDragEnd: (_) {
            if (_enabled) _firstScroll = false;
          },
          child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _favoritosModel.length,
                    itemBuilder: (context, index) {
                      final String imagen = _favoritosModel[index].image;
                      var item = _favoritosModel[index];
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 2.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                          height: 150,
                                          child: CachedNetworkImage(
                                              imageUrl: '${item.image}' + '?alt=media',
                                              fit: BoxFit.cover,
                                          ),
                                        ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(item.name,
                                        style: new TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.purple,
                          )
                        ],
                      );
                    },
                  ),

                ],
              ))),
    );
  }


}