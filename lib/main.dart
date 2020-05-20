import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_state/MapPage.dart';
import 'package:real_state/favorites.dart';
import 'package:real_state/hex_color.dart';
import 'package:real_state/search.dart';
import 'package:real_state/src/teras/blocs/villa_bloc.dart';
import 'package:real_state/src/teras/models/villa_model.dart';
import 'package:real_state/villa_detail.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:splashscreen/splashscreen.dart';

import 'common.dart';

void main() {
  runApp(new MaterialApp(
    home: new MySplashScreen(),
  ));
}

class MySplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => new _SplashScreen();
}

class _SplashScreen extends State<MySplashScreen> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new MyApp(),
        title: new Text(
          'Loading Famliy Dream',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        image: new Image.asset("assets/images/teras-logo.jpg"),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        //onClick: ()=>print("Flutter Egypt"),
        loaderColor: Colors.red);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future navigateToSubPage(context, String villaId) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => VillaDetail(villaId)));
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  List<Villa> villas = new List<Villa>();

  @override
  void initState() {
    villaBloc.fetchAllVillas();
    super.initState();
  }

  @override
  void dispose() {
    villaBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
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
      ), //Image.asset('assets/images/image1.JPG', fit: BoxFit.cover)),

      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 300,
              height: 20,
              margin: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              child: Text(
                "Most Viewed",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            buildMostViewd(),
            SizedBox(
              height: 20,
            ),
            buildApproved(),
            Container(
              width: 300,
              height: 20,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Text(
                "Reently Added",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
            ),
            buildInkWell2(),
            buildInkWell2(),
            buildInkWell2(),
            buildInkWell2(),
            buildInkWell2(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text('Map Search'),
                backgroundColor: red),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('search'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favorite'),
            ),
          ],
          //currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: (index) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) {
                  if(index==1){
                    return MapPage();
                  }
                  if(index==3){
                    return Favorites();
                  }
                  return Search();
                }));
          }),
    );
  }

  Container buildApproved() {
    return Container(
      width: 400,
      height: 280,
      color: grey.shade100,
      child: Column(
        children: <Widget>[
          Container(
            margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            height: 150,
            width: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage('assets/images/evaluated.png'),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
              //color: Colors.grey.shade300,
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
              width: 350,
              height: 120,
              color: Colors.grey.shade300,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: RichText(
                  text: TextSpan(
                    text: '',
                    //  style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'ماذا تعني علامة مُقيّم وموافق عليه؟\n',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      TextSpan(
                          text: ' جميع الوحدات المعروضة قد تم تقييمها من:\n'),
                      TextSpan(text: ' -مقيم معتمد من جهة التمويل\n'),
                      TextSpan(
                          text:
                              ' -الوحدة العقارية قد حصلت على شهادة التقييم\n'),
                      TextSpan(
                          text:
                              ' -شهادة التقييم للوحدة العقارية قد استوفت جميع الشروط التي تطلبها الجهة التمويلية'),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  SizedBox buildMostViewd() {
    return SizedBox(
      height: 300.0,
      child: StreamBuilder(
        stream: villaBloc.allVillas,
        builder: (context, AsyncSnapshot<List<Villa>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, index) {
                  return buildInkWell(snapshot.data[index]);
                });
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  InkWell buildInkWell(Villa villa) {
    return InkWell(
      onTap: () {
        print("tap detect");
        navigateToSubPage(context, villa.id.toString());
      },
      child: Container(
        //  height: 10,
        width: 300,

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
              tag: "${villa.id}",
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  SizedBox(
                    width: 30,
                    height: 30,
                  ),
                  Container(
                    //margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                    height: 150,
                    width: 300,
                    //padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(base64Decode(villa
                            .property
                            .attachments[0]
                            .fileContent)), //Image.memory(base64Decode(villa.property.attachments[0].fileContent)),
                        fit: BoxFit.fill,
                      ),

                      borderRadius: BorderRadius.circular(10),
                      //color: Colors.redAccent,
                    ),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    height: 40,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/images/approved.PNG"), //Image.memory(base64Decode(villa.property.attachments[0].fileContent)),
                          fit: BoxFit.fill,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.redAccent,
                      ),
                      // width: 100,
                      // height: 50,
                    ),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                height: 30,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColor("5dbcd2"),
                  boxShadow: [
                    BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                  ],
                ),
                child: Center(
                    child: Text(
                  "${villa.property.price}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: white, fontSize: 22),
                ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    )))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    )))
              ],
            ),
          ],
        ),
      ),
    );
  }

  InkWell buildInkWell2() {
    return InkWell(
      onTap: () {
        print("tap detect");
        //navigateToSubPage(context);
      },
      child: Container(
        height: 300,
        width: 300,
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
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
              height: 150,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: new AssetImage('assets/images/image3.JPG'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
                //color: Colors.redAccent,
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                height: 30,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: HexColor("5dbcd2"),
                  boxShadow: [
                    BoxShadow(color: HexColor("5dbcd2"), spreadRadius: 1),
                  ],
                ),
                child: Center(
                    child: Text(
                  "SR 7,290,000",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: white, fontSize: 22),
                ))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    )))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    ))),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.0, vertical: 5),
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
                          fontWeight: FontWeight.normal, color: Colors.black),
                    )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
