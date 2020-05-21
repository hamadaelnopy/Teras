import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:real_state/hex_color.dart';
import 'package:real_state/src/teras/blocs/villa_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common.dart';
import 'src/teras/models/villa_model.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  void initState() {
    getPreferences().then((Set<String> preferences) {
      villaBloc.fetchFav(preferences);
    });
    super.initState();
  }

  Future<Set<String>> getPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys();
  }


InkWell buildInkWell(Villa villa) {
    return InkWell(
      onTap: () {
        print("tap detect");
        //navigateToSubPage(context, villa.id.toString());
      },
      child: Slidable(
        
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
                      height: 75,
                      width: 340,
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
    
              
            ],
          ),
        ), actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
 actions: <Widget>[
  
    IconSlideAction(
      caption: 'Share',
      color: Colors.indigo,
      icon: Icons.share,
      //onTap: () => _showSnackBar('Share'),
    ),
  ],
  secondaryActions: <Widget>[
    
    IconSlideAction(
      caption: 'Delete',
      color: Colors.red,
      icon: Icons.delete,
      //onTap: () => _showSnackBar('Delete'),
    ),
  ],
      ),
    );
  }


Center buildMostViewd() {
    return Center(
      
      child: SizedBox(
        //height: 800.0,
        child: StreamBuilder(
          stream: villaBloc.favVillas,
          builder: (context, AsyncSnapshot<List<Villa>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, index) {
                    print(snapshot.data[index].numberOfFlats.toString());
                    return buildInkWell(snapshot.data[index]);
                  });
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );}
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(body: buildMostViewd());
}
}