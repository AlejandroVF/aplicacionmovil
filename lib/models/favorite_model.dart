import 'package:flutter/material.dart';

class FavoritosModel {
  var id;
  String name;
  String image;
  String addfav;


  FavoritosModel(
      String documentID,
      String name,
      String image,
      String addfav,
      );

  FavoritosModel.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.image = obj['image'];
    this.addfav = obj['addfav'];


  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['addfav'] = addfav;
    return map;
  }

  FavoritosModel.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.id = map['id'];
    this.image = map['image'];
    this.addfav = map['addfav'];


  }
}