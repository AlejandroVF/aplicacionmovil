import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:proyecto/controllers/login_controller.dart';
import 'package:proyecto/models/favorite_model.dart';
import 'package:proyecto/models/productos_model.dart';
import 'package:proyecto/pages/info_page.dart';
import 'package:proyecto/pages/reserva_departamento.dart';
import 'package:proyecto/pages/reserva_lista.dart';
import 'package:proyecto/services/firebase_services.dart';
import 'package:proyecto/widgets/header.dart';

import 'crear_reserva.dart';
import 'home_page.dart';

class DeptoPage extends StatefulWidget {
  DeptoPage({Key key}) : super(key: key);

  @override
  _DeptoPageState createState() => _DeptoPageState();
}

class _DeptoPageState extends State<DeptoPage> {

/*  String id;

  final _formKey = GlobalKey<FormState>();
  String name;
  String uid;*/

  //
  List<ProductosModel> _productosModel = List<ProductosModel>();
  final controller = Get.put(LoginController());
  List<ProductosModel> _listaCarro = [];
  List<ProductosModel> _reservadepto = [];
  FirebaseService db = new FirebaseService();
  var i = 1;
  StreamSubscription<QuerySnapshot> productSub;
  //

  @override
  void initState() {
    super.initState();
//-------------------------------------------------------------------------
    _productosModel = new List();

    productSub?.cancel();
    productSub = db.getProductList().listen((QuerySnapshot snapshot) {
      final List<ProductosModel> products = snapshot.docs
          .map((documentSnapshot) =>
              ProductosModel.fromMap(documentSnapshot.data()))
          .toList();

      setState(() {
        this._productosModel = products;
      });
    });
  }



  @override
  void dispose() {
    productSub?.cancel();
    super.dispose();
  }

  deleteData(String name) async{
    CollectionReference favoritosReference = FirebaseFirestore.instance.collection("favoritos");
    QuerySnapshot favoritosSnapshot = await favoritosReference.get();
    for (var i=0; i<=favoritosSnapshot.docs.length;i++){
      if(favoritosSnapshot.docs[i].get("name")==name){
        favoritosSnapshot.docs[i].reference.delete();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[700],
          title: Text('FVAlquileres'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      size: 38,
                    ),

                    if ( _listaCarro.length > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            _listaCarro.length.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (_listaCarro.isNotEmpty)
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CartPage(_listaCarro),
                      ),
                    );
                },
              ),
            ),
          ],
        ),
        drawer: Container(
          width: 170.0,
          child: Drawer(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              color: Colors.red[700],
              child:
                  new ListView(padding: EdgeInsets.only(top: 30.0), children: <
                      Widget>[
                Container(
                  height: 120,
                  child: new UserAccountsDrawerHeader(
                    accountName: new Text(''),
                    accountEmail: new Text(''),
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage(
                          'assets/images/iconodepto.png',
                        ),
                      ),
                    ),
                  ),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Inicio',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.home,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Get.toNamed("/deptopage"),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Publicar',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.apartment,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => CrearProductos(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Favoritos',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.whatshot,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => CartPage(_listaCarro),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Información',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new Icon(
                    Icons.info,
                    size: 30.0,
                    color: Colors.white,
                  ),
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => infoPage(),
                  )),
                ),
                new Divider(),
                new ListTile(
                  title: new Text(
                    'Cerrar Sesion',
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: new FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onTap: () async {
                    await controller.signOut();
                  },
                ),
                new Divider(),
              ]),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    WaveClip(),
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 0, top: 20),
                      height: 150,
                      child: ListView.builder(
                        itemCount: _productosModel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Container(
                                height: 300,
                                padding: new EdgeInsets.only(
                                    left: 10.0, bottom: 10.0),
                                child: Card(
                                  elevation: 7.0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            '${_productosModel[index].image}' +
                                                '?alt=media',
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) {}),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Container(height: 1.0, color: Colors.grey),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                    color: Colors.grey[300],
                    height: MediaQuery.of(context).size.height / 1.6,
                    child: GridView.builder(
                      padding: const EdgeInsets.all(5.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      itemCount: i,
                      itemBuilder: (context, index) {
                        final String imagen = _productosModel[index].image;
                        var item = _productosModel[index];

                        return GestureDetector(
                          child: Card(
                            elevation: 5.0,
                            child: Stack(
                              fit: StackFit.loose,
                              alignment: Alignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${_productosModel[index].image}' +
                                                '?alt=media',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      '${_productosModel[index].name}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Text(
                                      '${_productosModel[index].ubicacion}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          '\$' +
                                              '${_productosModel[index].price.toString()}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0,
                                              color: Colors.black),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                            bottom: 8.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              child:
                                                  (!_listaCarro.contains(item))
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: Colors.black,
                                                          size: 30,
                                                        )
                                                      : Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                          size: 30,
                                                        ),
                                              onTap: () {
                                                setState(() {
                                                  if (!_listaCarro
                                                      .contains(item)) {
                                                    _listaCarro.add(item);
                                                    FirebaseFirestore.instance
                                                        .collection("favoritos")
                                                        .add({
                                                      'name':
                                                          item.name,
                                                      'image':
                                                          item.image
                                                    }
                                                    );

                                                  } else {
                                                    deleteData(_productosModel[index].name);
                                                    _listaCarro.remove(item);

                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              _reservadepto = [];
                              if (!_reservadepto.contains(item))
                                _reservadepto.add(item);
                            });
                            Navigator.of(context).push(new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ReservaDepto(_reservadepto)));
                            // print('${_productosModel[index].name}');
                          },
                        );
                      },
                    )),
                Container(
                    child: FlatButton(
                  onPressed: () => setState(() {
                    if (i < _productosModel.length) {
                      i = i + 1;
                      print(i);
                    }
                    ;
                  }),
                  child: Text("Mostras Mas",
                      style: TextStyle(color: Colors.white)),
                  color: Colors.red[700],
                ))
              ],
            ),
          )),
        ));
  }
}
