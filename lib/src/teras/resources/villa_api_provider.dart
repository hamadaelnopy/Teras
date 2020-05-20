import 'dart:async';
import 'package:flutter/services.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';
import '../models/villa_model.dart';

class TerasApiProvider {
  Client client = Client();
  final _apiKey = 'your_api_key';

  // Future<String> _loadData(String dataKey) async {
  //   final file = new File(dataKey);
  //   // Read the file.
  //   String contents = await file.readAsString();
  //   return contents;
  // }

  Future<String> _loadData(String dataKey) async {
    return await rootBundle.loadString(dataKey);
  }

  Future<List<Villa>> fetchVillaList() async {
    print("entered");
    final response = await client.get(
        "https://teras.ecloud.sa/api/search/villas?page=0&size=10&price.greaterOrEqualThan=0&sort=id,desc");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var collection = await jsonDecode(response.body);
      List<Villa> _villas =
          await collection.map<Villa>((json) => Villa.fromJson(json)).toList();
      return _villas;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Villas');
    }

    // Local dat json file

    print("entered");

    //   final String data = await _loadData('data/teras.json');

    //  // print(data);

    //   var collection = await jsonDecode(data);

    //   List<Villa> _villas =
    //       await collection.map<Villa>((json) => Villa.fromJson(json)).toList();

    //   return _villas;
  }

  Future<List<Villa>> fetchVillaFavroutes(Set<String> villasIds) async {
    List<Villa> villas = [];
    List<String> ids = villasIds.toList();


     for(String villaId in ids){
      Villa  villaFromList = await fetchVillaDetails(villaId);
      villas.add(villaFromList);
    }
    return villas;
  
  }

  Future<Villa> fetchVillaDetails(String villaId) async {
    print("entered");
    final response =
        await client.get("https://teras.ecloud.sa/api/villas/${villaId}");
    //print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var json = await jsonDecode(response.body);
      Villa _villa = Villa.fromJson(json);
      //await collection.map<Villa>((json) => Villa.fromJson(json));
      return _villa;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load Villas');
    }

    // Local dat json file

    print("entered");

    //   final String data = await _loadData('data/teras.json');

    //  // print(data);

    //   var collection = await jsonDecode(data);

    //   List<Villa> _villas =
    //       await collection.map<Villa>((json) => Villa.fromJson(json)).toList();

    //   return _villas;
  }
}
