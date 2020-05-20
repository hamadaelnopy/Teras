import 'dart:async';

import 'villa_api_provider.dart';
import '../models/villa_model.dart';

class Repository {
  final terasApiProvider = TerasApiProvider();

  Future<List<Villa>> fetchAllVillas() => terasApiProvider.fetchVillaList();
  Future<Villa> fetchAllVillaDetails(String villaId) =>
      terasApiProvider.fetchVillaDetails(villaId);


      Future<List<Villa>> fetchVillaFavroutes(Set<String> villasIds) => terasApiProvider.fetchVillaFavroutes(villasIds);
}
