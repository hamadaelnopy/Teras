class NationalAddress {
  int _id;
  String _buildingNumber;
  String _streetName;
  String _streetNameEn;
  String _city;
  String _cityEn;
  String _postalCode;
  String _additionalNumbers;
  String _niehborhood;
  String _niehborhoodEn;
  String _unitNumber;
  String _longitude;
  String _latitude;
  String _region;
  String _regionEn;

  int get id => _id;

  set id(int value) => _id = value;

  String get buildingNumber => _buildingNumber;

  set buildingNumber(String value) => _buildingNumber = value;

  String get streetName => _streetName;

  set streetName(String value) => _streetName = value;

  String get streetNameEn => _streetNameEn;

  set streetNameEn(String value) => _streetNameEn = value;

  String get city => _city;

  set city(String value) => _city = value;

  String get cityEn => _cityEn;

  set cityEn(String value) => _cityEn = value;

  String get postalCode => _postalCode;

  set postalCode(String value) => _postalCode = value;

  String get additionalNumbers => _additionalNumbers;

  set additionalNumbers(String value) => _additionalNumbers = value;

  String get niehborhood => _niehborhood;

  set niehborhood(String value) => _niehborhood = value;

  String get niehborhoodEn => _niehborhoodEn;

  set niehborhoodEn(String value) => _niehborhoodEn = value;

  String get unitNumber => _unitNumber;

  set unitNumber(String value) => _unitNumber = value;

  String get longitude => _longitude;

  set longitude(String value) => _longitude = value;

  String get latitude => _latitude;

  set latitude(String value) => _latitude = value;

  String get region => _region;

  set region(String value) => _region = value;

  String get regionEn => _regionEn;

  set regionEn(String value) => _regionEn = value;

  NationalAddress(
      this._id,
      this._buildingNumber,
      this._streetName,
      this._streetNameEn,
      this._city,
      this._cityEn,
      this._postalCode,
      this._additionalNumbers,
      this._niehborhood,
      this._niehborhoodEn,
      this._unitNumber,
      this._longitude,
      this._latitude,
      this._region,
      this._regionEn);

  NationalAddress.fromJson(Map<String, dynamic> json) {
    _id = json["id"] ?? null;
    _buildingNumber = json["buildingNumber"] ?? null;
    _streetName = json["streetName"] ?? null;
    _streetNameEn = json["streetNameEn"] ?? null;
    _city = json["city"] ?? null;
    _cityEn = json["cityEn"] ?? null;
    _postalCode = json["postalCode"] ?? null;
    _additionalNumbers = json["additionalNumbers"] ?? null;
    _niehborhood = json["niehborhood"] ?? null;
    _niehborhoodEn = json["niehborhoodEn"] ?? null;
    _unitNumber = json["unitNumber"] ?? null;
    _longitude = json["longitude"] ?? null;
    _latitude = json["latitude"] ?? null;
    _region = json["region"] ?? null;
    _regionEn = json["regionEn"] ?? null;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': _id ?? null,
        'buildingNumber': _buildingNumber ?? null,
        'streetName': _streetName ?? null,
        'streetNameEn': _streetNameEn ?? null,
        'city': _city ?? null,
        'cityEn': _cityEn ?? null,
        'postalCode': _postalCode ?? null,
        'additionalNumbers': _additionalNumbers ?? null,
        'niehborhood': _niehborhood ?? null,
        'niehborhoodEn': _niehborhoodEn ?? null,
        'unitNumber': _unitNumber ?? null,
        'longitude': _longitude ?? null,
        'latitude': _latitude ?? null,
        'region': _region ?? null,
        'regionEn': _regionEn ?? null
      };

  @override
  String toString() {
    // TODO: implement toString
    return '''{
               "id":"${this._id ?? null}",
                "buildingNumber":"${this._buildingNumber ?? null}",
                "streetName":"${this._streetName ?? null}",
                "streetNameEn":"${this._streetNameEn ?? null}",
                "city":"${this._city ?? null}",
                "cityEn":"${this._cityEn ?? null}",
                "postalCode":"${this._postalCode ?? null}",
                "additionalNumbers":"${this._additionalNumbers ?? null}",
                "niehborhood":"${this._niehborhood ?? null}",
                "niehborhoodEn":"${this._niehborhoodEn ?? null}",
                "unitNumber":"${this._unitNumber ?? null}",
                "longitude":"${this._longitude ?? null}",
                "latitude":"${this._latitude ?? null}",
                "region":"${this._region ?? null}",
                "regionEn":"${this._regionEn ?? null}",
            }''';
  }
}
