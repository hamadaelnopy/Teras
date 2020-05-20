import 'package:flutter/material.dart';
import '../models/villa_model.dart';
import '../blocs/villa_bloc.dart';

class VillaList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VillaListState();
  }
}

class VillaListState extends State<VillaList> {
  @override
  void initState() {
    super.initState();
    villaBloc.fetchAllVillas();
  }

  @override
  void dispose() {
    villaBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teras'),
      ),
      // // body: StreamBuilder(
      // //   stream: villaBloc.allVillas,
      // //   builder: (context, AsyncSnapshot<Villa> snapshot) {
      // //     if (snapshot.hasData) {
      // //       return buildList(snapshot);
      // //     } else if (snapshot.hasError) {
      // //       return Text(snapshot.error.toString());
      // //     }
      // //     return Center(child: CircularProgressIndicator());
      // //   },
      // ),
    );
  }

  Widget buildList(AsyncSnapshot<Villa> snapshot) {
    // return GridView.builder(
    //     itemCount: snapshot.data.results.length,
    //     gridDelegate:
    //         new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    //     itemBuilder: (BuildContext context, int index) {
    //       return Image.network(
    //         'https://image.tmdb.org/t/p/w185${snapshot.data
    //             .results[index].poster_path}',
    //         fit: BoxFit.cover,
    //       );
    //     });
    return ListView.separated(
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            title: Text(snapshot.data.villaInterface),
            isThreeLine: true,
            leading: CircleAvatar(
              child: Text(snapshot.data.floorNumber.toString()),
            ),
            subtitle: Text(
              snapshot.data.buildingAge.toString(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: 2);
  }
}
