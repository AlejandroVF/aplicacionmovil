import 'package:cached_network_image/cached_network_image.dart';
import 'package:proyecto/models/productos_model.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/models/productos_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ReservaDepto extends StatefulWidget {
  final List<ProductosModel> _depto;
  ReservaDepto(this._depto);

  @override
  _ReservaDeptoState createState() => _ReservaDeptoState(this._depto);
}

class _ReservaDeptoState extends State<ReservaDepto> {
  _ReservaDeptoState(this._depto);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  List<ProductosModel> _depto;

  Container pagoTotal(List<ProductosModel> _cart) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        title: Text('Reserva'),
      ),
      body: GestureDetector(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _depto.length,
            itemBuilder: (context, index) {
              final String imagen = _depto[index].image;
              var item = _depto[index];
              return Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    child: Column(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Expanded(
                              child: Container(
                            width: 150,
                            height: 200,
                            child: CachedNetworkImage(
                              imageUrl: '${item.image}' + '?alt=media',
                              fit: BoxFit.cover,
                            ),
                          ))
                        ]),
                        Padding(padding: const EdgeInsets.only(top: 16.0)),
                        Column(
                          children: <Widget>[
                            Text(item.name,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.0,
                                    color: Colors.black)),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.only(top: 16.0)),
                        Text(item.ubicacion,
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.black)),
                        Padding(padding: const EdgeInsets.only(top: 16.0)),
                        Text(item.descripcion,textAlign: TextAlign.center,
                            style: new TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.0,
                                color: Colors.black)),
                        Padding(padding: const EdgeInsets.only(top: 16.0)),
                        Text('\$' + item.price.toString() + ' x Mes',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black)),
                        Padding(padding: const EdgeInsets.only(top: 16.0)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () =>
                                  launch("tel://" + '${item.numerotel}'),
                              child: Text(
                                "Telefono",
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.red[700],
                            ),
                            FlatButton(
                                onPressed: () =>
                                    launch("mailto://" + '${item.correo}'),
                                child: Text("Correo",
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.red[700])
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ))),
    );
  }
}
