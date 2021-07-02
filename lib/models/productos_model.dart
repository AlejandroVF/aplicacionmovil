import 'package:flutter/material.dart';

class ProductosModel {
  var id;
  String name;
  String image;
  int price;
  String descripcion;
  String numerotel;
  String correo;
  String ubicacion;


  ProductosModel(
      String documentID,
      String name,
      String image,
      int price,
      String descripcion,
      String numerotel,
      String correo,
      String ubicacion,

      );

  ProductosModel.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.image = obj['image'];
    this.price = obj['price'];
    this.descripcion = obj['descripcion'];
    this.numerotel = obj['numerotel'];
    this.correo = obj['correo'];
    this.ubicacion = obj['ubicacion'];

  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['price'] = price;
    map['descripcion'] = descripcion;
    map['numerotel'] = numerotel;
    map['correo'] = correo;
    map['ubicacion'] = ubicacion;

    return map;
  }

  ProductosModel.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.id = map['id'];
    this.image = map['image'];
    this.price = map['price'];
    this.descripcion = map['descripcion'];
    this.numerotel = map['numerotel'];
    this.correo = map['correo'];
    this.ubicacion = map['ubicacion'];

  }
}