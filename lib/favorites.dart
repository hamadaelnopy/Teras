import 'package:flutter/material.dart';
import 'package:real_state/src/teras/blocs/villa_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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



Center buildMostViewd() {
    return Center(
      
      child: SizedBox(
        height: 300.0,
        child: StreamBuilder(
          stream: villaBloc.favVillas,
          builder: (context, AsyncSnapshot<List<Villa>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    print(snapshot.data[index].numberOfFlats.toString());
                    return Text(snapshot.data[index].numberOfFlats.toString());
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