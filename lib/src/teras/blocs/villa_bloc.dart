import 'dart:async';
import '../resources/repository.dart';
import '../models/villa_model.dart';

class VillaBloc {
  final _repository = Repository();
  final _villasFetcher = StreamController<List<Villa>>();
  final _favVillasFetcher = StreamController<List<Villa>>.broadcast();

  Stream<List<Villa>> get allVillas => _villasFetcher.stream;
  Stream<List<Villa>> get favVillas => _favVillasFetcher.stream;

  StreamController<Villa> _villaDetailsFetcher =
      StreamController<Villa>.broadcast();

  Stream<Villa> get villaDetails => _villaDetailsFetcher.stream;

  fetchAllVillas() async {
    List<Villa> villas = await _repository.fetchAllVillas();

    _villasFetcher.sink.add(villas);
  }

  fetchFav(Set<String> villasIds) async {
    List<Villa> villas = await _repository.fetchVillaFavroutes(villasIds);
    _favVillasFetcher.sink.add(villas);
  }

  fetchVillaDetail(String villaId) async {
    Villa villa = await _repository.fetchAllVillaDetails(villaId);

    _villaDetailsFetcher.sink.add(villa);
  }

  dispose() {
    _villasFetcher.close();
    _villaDetailsFetcher.close();
  }
}

final villaBloc = VillaBloc();
