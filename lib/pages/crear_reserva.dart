import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CommonThings {
  static Size size;
}

class CrearProductos extends StatefulWidget {
  final String id;
  const CrearProductos({this.id});

  @override
  _CrearProductosState createState() => _CrearProductosState();
}

enum SelectSource { camara, galeria }

class _CrearProductosState extends State<CrearProductos> {
  File _foto;
  String urlFoto;
  bool _isInAsyncCall = false;
  int price;
  String descripcion;
  String numerotel;
  String correo;
  String ubicacion;
  //Auth auth = Auth();

  TextEditingController priceInputController;
  TextEditingController nameInputController;
  TextEditingController imageInputController;
  TextEditingController descripcionInputController;
  TextEditingController numerotelInputController;
  TextEditingController correoInputController;
  TextEditingController ubicacionInputController;

  String id;
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  String name;
  String uid;

  Future captureImage() async {
    File image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      image = File(pickedFile.path);
      _foto = image;
    });
  }

  Future getImage() async {
    AlertDialog alerta = new AlertDialog(
      content: Text('Seleccione Galeria'),
      title: Text('Seleccione Imagen'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            captureImage();
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Column(
            children: <Widget>[Text('Galeria'), Icon(Icons.image)],
          ),
        )
      ],
    );
    showDialog(context: context, builder: (_) => alerta);
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Container(
        width: 0.8,
        color: Colors.black,
      ),
    );
  }

  bool _validarlo() {
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future _enviar() async {
    if (_validarlo()) {
      setState(() {
        _isInAsyncCall = true;
      });

      if (_foto != null) {
        final Reference fireStoreRef = FirebaseStorage.instance
            .ref()
            .child('productos')
            .child('$name.jpg');
        await fireStoreRef.putFile(_foto).whenComplete(() async {
          await fireStoreRef.getDownloadURL().then((onValue) {
            setState(() {
              urlFoto = onValue.toString();
              FirebaseFirestore.instance
                  .collection('productos')
                  .add({
                    'name': name,
                    'image': urlFoto,
                    'price': price,
                    'descripcion': descripcion,
                    'numerotel': numerotel,
                    'correo': correo,
                    'ubicacion': ubicacion,
                  })
                  .then((value) => Navigator.of(context).pop())
                  .catchError((onError) =>
                      print('Error al registrar su departamento bd'));
              _isInAsyncCall = false;
            });
          });
        });
      } else {
        FirebaseFirestore.instance
            .collection('productos')
            .add({
              'name': name,
              'image': urlFoto,
              'price': price,
              'descripcion': descripcion,
              'numerotel': numerotel,
              'correo': correo,
              'ubicacion': ubicacion,
            })
            .then((value) => Navigator.of(context).pop())
            .catchError(
                (onError) => print('Error al registrar su departamento bd'));
        _isInAsyncCall = false;
      }
    } else {
      print('objeto no validado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[700],
          title: Text('Reserva'),
        ),
        body: ModalProgressHUD(
          inAsyncCall: _isInAsyncCall,
          opacity: 0.5,
          dismissible: false,
          progressIndicator: CircularProgressIndicator(),
          color: Colors.blueGrey,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, right: 15),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        child: GestureDetector(
                          onTap: getImage,
                        ),
                        margin: const EdgeInsets.only(top: 10),
                        height: 180,
                        width: 180,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2.0, color: Colors.black),
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: _foto == null
                                    ? AssetImage(
                                        'assets/images/departamentos/img1.jpg')
                                    : FileImage(_foto))),
                      )
                    ],
                  ),
                  Text('Inserte una Imagen'),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Titulo',
                        hintText: 'Ingrese un Titulo',
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[600]))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por Favor Ingrese un Titulo';
                      }
                    },
                    onSaved: (value) => name = value.trim(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Precio',
                        hintText: 'Ingrese un Precio',
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[600]))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por Favor Ingrese un Precio';
                      }
                    },
                    onSaved: (value) => price = int.parse(value),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  TextFormField(
                    maxLines: 5,
                    decoration: InputDecoration(
                        labelText: 'Descripcion',
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        hintText: 'Ingrese una Descripción',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[600]))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por Favor Ingrese Una Descripcion';
                      }
                    },
                    onSaved: (value) => descripcion = value.trim(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: ('Telefono'),
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        hintText: 'Ingrese un Numero de Telefono',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[600]))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por Favor Ingrese un Numero de Telefono';
                      }
                    },
                    onSaved: (value) => numerotel = value.trim(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: ('Correo'),
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        hintText: 'Ingrese un Mail',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[600]))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por Favor Ingrese un Mail';
                      }
                    },
                    onSaved: (value) => correo = value.trim(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: ('Direccion'),
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        hintText: 'Ingrese una Direccion',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 0,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey[600]))),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Por Favor Ingrese una Direccion';
                      }
                    },
                    onSaved: (value) => ubicacion = value.trim(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: _enviar,
                        child: Text('Crear',
                            style: TextStyle(color: Colors.white)),
                        color: Colors.green,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
