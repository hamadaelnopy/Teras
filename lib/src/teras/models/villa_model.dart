import 'property_model.dart';

class Villa {
  int _id;
  String _villaInterface;
  int _numberOfFlats;
  int _numberOfHalls;
  int _numberOfBaths;
  int _numberOfKitchens;
  int _area;
  double _streetWidth;
  int _floorNumber;
  bool _hasElevator;
  bool _hasGarage;
  bool _furnished;
  bool _swimmingPool;
  bool _maidRoom;
  bool _driverRoom;
  int _buildingAge;
  Property _property;
  String _stairType;
  int _mostViewed;
  int get id => _id;

  set id(int value) => _id = value;

  String get villaInterface => _villaInterface;

  set villaInterface(String value) => _villaInterface = value;

  int get numberOfFlats => _numberOfFlats;

  set numberOfFlats(int value) => _numberOfFlats = value;

  int get numberOfHalls => _numberOfHalls;

  set numberOfHalls(int value) => _numberOfHalls = value;

  int get numberOfBaths => _numberOfBaths;

  set numberOfBaths(int value) => _numberOfBaths = value;

  int get numberOfKitchens => _numberOfKitchens;

  set numberOfKitchens(int value) => _numberOfKitchens = value;

  int get area => _area;

  set area(int value) => _area = value;

  double get streetWidth => _streetWidth;

  set streetWidth(double value) => _streetWidth = value;

  int get floorNumber => _floorNumber;

  set floorNumber(int value) => _floorNumber = value;

  bool get hasElevator => _hasElevator;

  set hasElevator(bool value) => _hasElevator = value;

  bool get hasGarage => _hasGarage;

  set hasGarage(bool value) => _hasGarage = value;

  bool get furnished => _furnished;

  set furnished(bool value) => _furnished = value;

  bool get swimmingPool => _swimmingPool;

  set swimmingPool(bool value) => _swimmingPool = value;

  bool get maidRoom => _maidRoom;

  set maidRoom(bool value) => _maidRoom = value;

  bool get driverRoom => _driverRoom;

  set driverRoom(bool value) => _driverRoom = value;

  int get buildingAge => _buildingAge;

  set buildingAge(int value) => _buildingAge = value;

  Property get property => _property;

  set property(Property value) => _property = value;

  String get stairType => _stairType;

  set stairType(String value) => _stairType = value;

  int get mostViewed => _mostViewed;

  set mostViewed(int value) => _mostViewed = value;

  Villa(
      this._id,
      this._villaInterface,
      this._numberOfFlats,
      this._numberOfHalls,
      this._numberOfBaths,
      this._numberOfKitchens,
      this._area,
      this._streetWidth,
      this._floorNumber,
      this._hasElevator,
      this._hasGarage,
      this._furnished,
      this._swimmingPool,
      this._maidRoom,
      this._driverRoom,
      this._buildingAge,
      this._property,
      this._stairType,
      this._mostViewed);

  Villa.fromJson(Map<String, dynamic> json) {
    _id = json["id"] ?? null;
    _villaInterface = json["villaInterface"] ?? null;
    _numberOfFlats = json["numberOfFlats"] ?? null;
    _numberOfHalls = json["numberOfHalls"] ?? null;
    _numberOfBaths = json["numberOfBaths"] ?? null;
    _numberOfKitchens = json["numberOfKitchens"] ?? null;
    _area = json["area"] ?? null;
    _streetWidth = json["streetWidth"] ?? null;
    _floorNumber = json["floorNumber"] ?? null;
    _hasElevator = json["hasElevator"] ?? null;
    _hasGarage = json["hasGarage"] ?? null;
    _furnished = json["furnished"] ?? null;
    _swimmingPool = json["swimmingPool"] ?? null;
    _maidRoom = json["maidRoom"] ?? null;
    _driverRoom = json["driverRoom"] ?? null;
    _buildingAge = json["buildingAge"] ?? null;
    _property = Property.fromJson(json["property"]) ?? null;
    _stairType = json["stairType"] ?? null;
    _mostViewed = json["mostViewed"] ?? null;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": _id ?? null,
        "villaInterface": _villaInterface ?? null,
        "numberOfFlats": _numberOfFlats ?? null,
        "numberOfHalls": _numberOfHalls ?? null,
        "numberOfBaths": _numberOfBaths ?? null,
        "numberOfKitchens": _numberOfKitchens ?? null,
        "area": _area ?? null,
        "streetWidth": _streetWidth ?? null,
        "floorNumber": _floorNumber ?? null,
        "hasElevator": _hasElevator ?? null,
        "hasGarage": _hasGarage ?? null,
        "furnished": _furnished ?? null,
        "swimmingPool": _swimmingPool ?? null,
        "maidRoom": _maidRoom ?? null,
        "driverRoom": _driverRoom ?? null,
        "buildingAge": _buildingAge ?? null,
        "property": _property ?? null,
        "stairType": _stairType ?? null,
        "mostViewed": _mostViewed ?? null,
      };

  @override
  String toString() {
    // TODO: implement toString
    return '''{
              "id":"${this._id ?? null}",
              "villaInterface":"${this._villaInterface ?? null}",
              "numberOfFlats":"${this._numberOfFlats ?? null}",
              "numberOfHalls":"${this._numberOfHalls ?? null}",
              "numberOfBaths":"${this._numberOfBaths ?? null}",
              "numberOfKitchens":"${this._numberOfKitchens ?? null}",
              "area":"${this._area ?? null}",
              "streetWidth":"${this._streetWidth ?? null}",
              "floorNumber":"${this._floorNumber ?? null}",
              "hasElevator":"${this._hasElevator ?? null}",
              "hasGarage":"${this._hasGarage ?? null}",
              "furnished":"${this._furnished ?? null}",
              "swimmingPool":"${this._swimmingPool ?? null}",
              "maidRoom":"${this._maidRoom ?? null}",
              "driverRoom":"${this._driverRoom ?? null}",
              "buildingAge":"${this._buildingAge ?? null}",
              "property":"${this._property.toString() ?? null}",
              "stairType":"${this._stairType ?? null}",
              "mostViewed":"${this._mostViewed ?? null}",
            }''';
  }
}
