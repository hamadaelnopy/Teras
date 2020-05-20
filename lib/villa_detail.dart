import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:real_state/common.dart';
import 'package:real_state/src/teras/blocs/villa_bloc.dart';
import 'package:real_state/src/teras/models/villa_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'hex_color.dart';

class VillaDetail extends StatefulWidget {
  String villaId;
  VillaDetail(this.villaId);

  @override
  _VillaDetailState createState() => _VillaDetailState();
}

class _VillaDetailState extends State<VillaDetail> {
  final _key = new GlobalKey();
  GoogleMapController _controller;
  launchMap({String lat = "47.6", String lng = "-122.3"}) async {
    final String googleMapsUrl = "comgooglemaps://?center=$lat,$lng";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$lng";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    }
    if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      throw "Couldn't launch URL";
    }
  }

  _launchCaller() async {
    const url = "tel:0533261877";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchTeras() async {
    const url = "https://teras.ecloud.sa/#/register";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


_shareImage() async {
    try {
     RenderRepaintBoundary boundary = _key.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final tempDir = await getTemporaryDirectory();
      final file = await new File('${tempDir.path}/image.jpg').create();
      file.writeAsBytesSync(pngBytes);

      final channel = const MethodChannel('channel:me.albie.share/share');
      channel.invokeMethod('shareFile', 'image.jpg');

    } catch (e) {
      print('Share error: $e');
    }
  }
Rect rect(BuildContext context) {
    final RenderBox box = context.findRenderObject();
     box.localToGlobal(Offset.zero) & box.size;
  }
  void _getWidgetImage(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary = _key.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage();
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final RenderBox box = _key.currentContext.findRenderObject();
     Rect rect = box.localToGlobal(Offset.zero) & box.size;
      
      await Share.file('look to this villa', 'villa.png', pngBytes, 'image/png', text: 'Share with people you care',sharePositionOrigin:rect);

      //return pngBytes;
Navigator.pop(context);
    } catch (exception) {
      print(exception.toString());
    }
  }

  @override
  void initState() {
    villaBloc.fetchVillaDetail(widget.villaId);

    super.initState();
  }


addStringToSF(String preference) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String value = prefs.getString(preference);
  if(value==null){
    prefs.setString(preference, preference);
  }
  Flushbar(
  message: "Villa added to dream list ",
  //backgroundColor: HexColor("5dbcd2"),
  icon: Icon(
    Icons.favorite,
    size: 28.0,
    color: Colors.blue[300],
    ),
  duration: Duration(seconds: 3),
  leftBarIndicatorColor: Colors.blue[300],
)..show(context);
  print(prefs.getKeys());
}
  @override
  Widget build(BuildContext context) { 
      final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
        


    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FabCircularMenu(
            key: fabKey,
            fabColor: HexColor("5dbcd2"),
            ringColor: HexColor("5dbcd2"),
            fabSize: 44,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.monetization_on,
                    color: red,
                  ),
                  onPressed: () {
                    _launchTeras();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.share,
                    //color: red,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      
                        context: context,
                        builder: (BuildContext bc) {
                          return Center(
                            child: Container(
                                child: InkWell(
                              onTap: () {
                                _getWidgetImage(context);

                               //_shareImage();
                              },
                              child: RepaintBoundary(
                                  key: _key,
                                child: QrImage(
                                
                                  data:
                                      'https://teras.ecloud.sa/#/${widget.villaId}/2551/view',
                                  version: QrVersions.auto,
                                  size: 320,
                                  gapless: false,
                                  embeddedImage: AssetImage(
                                      'assets/images/teras-logo-icon.ico'),
                                  embeddedImageStyle: QrEmbeddedImageStyle(
                                    size: Size(80, 80),
                                  ),
                                ),
                              ),
                            )),
                          );
                        });

                    //_launchTeras();
                  fabKey.currentState.close();
                  }),
              IconButton(
                  icon: Icon(Icons.call),
                  onPressed: () {
                    _launchCaller();
                    _launchTeras();
                  }),
              IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                   addStringToSF(widget.villaId);
                  }),
              IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () {
                   addStringToSF(widget.villaId);
                   // print('Favorite');
                   launchMap();
                  })
            ]),
        appBar: AppBar(
          //     title: SvgPicture.asset(
          //   "assets/images/teras-logo.svg",
          //   fit: BoxFit.contain,
          // )
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/teras-logo.svg",
                fit: BoxFit.cover,
                height: 35.0,
              ),
            ],
          ),
        ),
        body: StreamBuilder<Villa>(
            stream: villaBloc.villaDetails,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                Villa villa = snapshot.data;
                return ListView(children: <Widget>[
                  Container(
                    height: 280,
                    width: 500,
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Hero(
                            tag: "cocowawa",
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 5),
                              height: 200,
                              width: 400,
                              decoration: BoxDecoration(
                                // image: DecorationImage(
                                //   image:  AssetImage('assets/images/image3.JPG'),
                                //   fit: BoxFit.fill,
                                // ),
                                borderRadius: BorderRadius.circular(10),
                                //color: Colors.redAccent,
                              ),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  height: 200,
                                  //  aspectRatio: 2.0,
                                  enlargeCenterPage: true,
                                  enableInfiniteScroll: false,
                                  // initialPage: 1,
                                  autoPlay: true,
                                ),
                                items: villa.property.attachments
                                    .map(
                                      (item) => Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: MemoryImage(
                                                base64Decode(item.fileContent)),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),

                                // items: <Widget>[
                                //   Container(
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image:
                                //             new AssetImage('assets/images/image3.JPG'),
                                //         fit: BoxFit.fill,
                                //       ),
                                //       borderRadius: BorderRadius.circular(10),
                                //       //color: Colors.grey.shade300,
                                //     ),
                                //   ),
                                //   Container(
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image:
                                //             new AssetImage('assets/images/image1.JPG'),
                                //         fit: BoxFit.fill,
                                //       ),
                                //       borderRadius: BorderRadius.circular(10),
                                //       //color: Colors.grey.shade300,
                                //     ),
                                //   ),
                                //   Container(
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image:
                                //             new AssetImage('assets/images/image2.JPG'),
                                //         fit: BoxFit.fill,
                                //       ),
                                //       borderRadius: BorderRadius.circular(10),
                                //       //color: Colors.grey.shade300,
                                //     ),
                                //   ),
                                //   Container(
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image:
                                //             new AssetImage('assets/images/image3.JPG'),
                                //         fit: BoxFit.fill,
                                //       ),
                                //       borderRadius: BorderRadius.circular(10),
                                //       //color: Colors.grey.shade300,
                                //     ),
                                //   ),
                                //   Container(
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image:
                                //             new AssetImage('assets/images/image4.JPG'),
                                //         fit: BoxFit.fill,
                                //       ),
                                //       borderRadius: BorderRadius.circular(10),
                                //       //color: Colors.grey.shade300,
                                //     ),
                                //   ),
                                // ],
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5),
                            height: 30,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor("5dbcd2"),
                              boxShadow: [
                                BoxShadow(
                                    color: HexColor("5dbcd2"), spreadRadius: 1),
                              ],
                            ),
                            child: Center(
                                child: Text(
                              "SR 7,290,000",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                  fontSize: 22),
                            ))),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 25,
                        padding: const EdgeInsets.all(1.0),
                        margin:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, //HexColor("5dbcd2"),
                          boxShadow: [
                            BoxShadow(
                                color: HexColor("5dbcd2"), spreadRadius: 1),
                          ],
                        ),
                        child: Text(
                          "مواصفات الفيلا",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 400,
                    height: 80,
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white, //HexColor("5dbcd2"),
                      boxShadow: [
                        BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Flat : 7",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Flat : 7",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    // BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Hall :3",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    // BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Kitchen :1",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //   color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //    BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "North",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "668.57  SM",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 25,
                        padding: const EdgeInsets.all(1.0),
                        margin:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, //HexColor("5dbcd2"),
                          boxShadow: [
                            BoxShadow(
                                color: HexColor("5dbcd2"), spreadRadius: 1),
                          ],
                        ),
                        child: Text(
                          "مواصفات العقار",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 400,
                    height: 80,
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white, //HexColor("5dbcd2"),
                      boxShadow: [
                        BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Flat : 7",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Flat : 7",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    // BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Hall :3",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    // BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Kitchen :1",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //   color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //    BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "North",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "668.57  SM",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 25,
                        padding: const EdgeInsets.all(1.0),
                        margin:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, //HexColor("5dbcd2"),
                          boxShadow: [
                            BoxShadow(
                                color: HexColor("5dbcd2"), spreadRadius: 1),
                          ],
                        ),
                        child: Text(
                          "مرافق إضافية أخرى",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 400,
                    height: 80,
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white, //HexColor("5dbcd2"),
                      boxShadow: [
                        BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Flat : 7",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Flat : 7",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    // BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Hall :3",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    // BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Kitchen :1",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //   color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //    BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "North",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "668.57  SM",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 25,
                        padding: const EdgeInsets.all(1.0),
                        margin:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, //HexColor("5dbcd2"),
                          boxShadow: [
                            BoxShadow(
                                color: HexColor("5dbcd2"), spreadRadius: 1),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "الموقع",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 150,
                    width: 300,
                    margin: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                    padding: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: HexColor(
                            "5dbcd2"), //                   <--- border color
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      //color: HexColor("5dbcd2"),
                      boxShadow: [
                        //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                      ],
                    ),
                    child: GoogleMap(
                      onMapCreated: ((GoogleMapController controller) {
                        _controller = controller;
                      }),
                      initialCameraPosition: CameraPosition(
                        target: const LatLng(24.635471, 46.747138),
                        zoom: 11.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 200,
                        height: 25,
                        padding: const EdgeInsets.all(1.0),
                        margin:
                            EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white, //HexColor("5dbcd2"),
                          boxShadow: [
                            BoxShadow(
                                color: HexColor("5dbcd2"), spreadRadius: 1),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "تواريخ الإكتمال والتشغيل",
                            style: TextStyle(fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 400,
                    height: 80,
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white, //HexColor("5dbcd2"),
                      boxShadow: [
                        BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Flat : 7",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Flat : 7",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    // BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Hall :3",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    // BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "Kitchen :1",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //   color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //    BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "North",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                ))),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.0, vertical: 5),
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: HexColor(
                                        "5dbcd2"), //                   <--- border color
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                  //color: HexColor("5dbcd2"),
                                  boxShadow: [
                                    //BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  "668.57  SM",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black),
                                )))
                          ],
                        ),
                      ],
                    ),
                  )
                ]);
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
