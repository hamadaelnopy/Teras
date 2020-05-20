import 'attachments_model.dart';
import 'bankLogos_model.dart';
import 'nationalAddress_model.dart';

class Property {
  int _id;
  String _propertyType;
  double _price;
  String _notes;
  NationalAddress _nationalAddress;
  int _sellerId;
  List<Attachment> _attachments;
  List<BankLogo> _bankLogos;
  String _sellerName;
  String _completionDate;
  String _lucnhElectricityDate;
  double _landArea;
  Attachment _sellerLogo;
  String _sellerMobile;
  double _area;
  String _propertyStatus;
  String _removedFiles;
  int _publishedCount;
  String _firstPublishedDate;
  String _recentPublishedDate;

  int get id => _id;

  set id(int value) => _id = value;

  String get propertyType => _propertyType;

  set propertyType(String value) => _propertyType = value;

  double get price => _price;

  set price(double value) => _price = value;

  String get notes => _notes;

  set notes(String value) => _notes = value;

  NationalAddress get nationalAddress => _nationalAddress;

  set nationalAddress(NationalAddress value) => _nationalAddress = value;

  int get sellerId => _sellerId;

  set sellerId(int value) => _sellerId = value;

  List<Attachment> get attachments => _attachments;

  set attachments(List<Attachment> value) => _attachments = value;

  List<BankLogo> get bankLogos => _bankLogos;

  set bankLogos(List<BankLogo> value) => _bankLogos = value;

  String get sellerName => _sellerName;

  set sellerName(String value) => _sellerName = value;

  String get completionDate => _completionDate;

  set completionDate(String value) => _completionDate = value;

  String get lucnhElectricityDate => _lucnhElectricityDate;

  set lucnhElectricityDate(String value) => _lucnhElectricityDate = value;

  double get landArea => _landArea;

  set landArea(double value) => _landArea = value;

  Attachment get sellerLogo => _sellerLogo;

  set sellerLogo(Attachment value) => _sellerLogo = value;

  String get sellerMobile => _sellerMobile;

  set sellerMobile(String value) => _sellerMobile = value;

  double get area => _area;

  set area(double value) => _area = value;

  String get propertyStatus => _propertyStatus;

  set propertyStatus(String value) => _propertyStatus = value;

  String get removedFiles => _removedFiles;

  set removedFiles(String value) => _removedFiles = value;

  int get publishedCount => _publishedCount;

  set publishedCount(int value) => _publishedCount = value;

  String get firstPublishedDate => _firstPublishedDate;

  set firstPublishedDate(String value) => _firstPublishedDate = value;

  String get recentPublishedDate => _recentPublishedDate;

  set recentPublishedDate(String value) => _recentPublishedDate = value;

  Property(
    this._id,
    this._propertyType,
    this._price,
    this._notes,
    this._nationalAddress,
    this._sellerId,
    this._attachments,
    this._bankLogos,
    this._sellerName,
    this._completionDate,
    this._lucnhElectricityDate,
    this._landArea,
    this._sellerLogo,
    this._sellerMobile,
    this._area,
    this._propertyStatus,
    this._removedFiles,
    this._publishedCount,
    this._firstPublishedDate,
    this._recentPublishedDate,
  );

  Property.fromJson(Map<String, dynamic> json) {
    _id = json["id"] ?? null;
    _propertyType = json["propertyType"] ?? null;
    _price = json["price"] ?? null;
    _notes = json["notes"] ?? null;
    _nationalAddress =
        NationalAddress.fromJson(json["nationalAddress"]) ?? null;
    _sellerId = json["sellerId"] ?? null;
    //building list of attachemnts
    List<Attachment> tempAttachements = [];
    for (int i = 0; i < json['attachments'].length; i++) {
      Attachment attachment = Attachment.fromJson(json['attachments'][i]);
      tempAttachements.add(attachment);
    }
    _attachments = tempAttachements ?? null;
    //building list of BankLogos
    List<BankLogo> tempLogo = [];
    for (int i = 0; i < json['bankLogos'].length; i++) {
      BankLogo logo = BankLogo.fromJson(json['bankLogos'][i]);
      tempLogo.add(logo);
    }
    _bankLogos = tempLogo ?? null;
    _sellerName = json["sellerName"] ?? null;
    _completionDate = json["completionDate"] ?? null;
    _lucnhElectricityDate = json["lucnhElectricityDate"] ?? null;
    _landArea = json["landArea"] ?? null;
    _sellerLogo = Attachment.fromJson(json['sellerLogo']) ?? null;
    _sellerMobile = json["sellerMobile"] ?? null;
    _area = json["area"] ?? null;
    _propertyStatus = json["propertyStatus"] ?? null;
    _removedFiles = json["removedFiles"] ?? null;
    _publishedCount = json["publishedCount"] ?? null;
    _firstPublishedDate = json["firstPublishedDate"] ?? null;
    _recentPublishedDate = json["recentPublishedDate"] ?? null;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        "id": _id ?? null,
        "propertyType": _propertyType ?? null,
        "price": _price ?? null,
        "notes": _notes ?? null,
        "nationalAddress": _nationalAddress.toJson() ?? null,
        "sellerId": _sellerId ?? null,
        "attachments": _attachments.map((e) => e.toJson()).toList() ?? null,
        "bankLogos": _bankLogos.map((e) => e.toJson()).toList() ?? null,
        "sellerName": _sellerName ?? null,
        "completionDate": _completionDate ?? null,
        "lucnhElectricityDate": _lucnhElectricityDate ?? null,
        "landArea": _landArea ?? null,
        "sellerLogo": _sellerLogo.toJson() ?? null,
        "sellerMobile": _sellerMobile ?? null,
        "area": _area ?? null,
        "propertyStatus": _propertyStatus ?? null,
        "removedFiles": _removedFiles ?? null,
        "publishedCount": _publishedCount ?? null,
        "firstPublishedDate": _firstPublishedDate ?? null,
        "recentPublishedDate": _recentPublishedDate ?? null,
      };

  @override
  String toString() {
    // TODO: implement toString
    return '''{
              "id":"${this._id ?? null}",
              "propertyType":"${this._propertyType ?? null}",
              "price":"${this._price ?? null}",
              "notes":"${this._notes ?? null}",
              "nationalAddress":"${this._nationalAddress ?? null}",
              "sellerId":"${this._sellerId ?? null}",
              "attachments":"${this._attachments.map((e) => e.toString()).toList() ?? null}",
              "bankLogos":"${this._bankLogos.map((e) => e.toString()).toList() ?? null}",
              "sellerName":"${this._sellerName ?? null}",
              "completionDate":"${this._completionDate ?? null}",
              "lucnhElectricityDate":"${this._lucnhElectricityDate ?? null}",
              "landArea":"${this._landArea ?? null}",
              "sellerLogo":"${this._sellerLogo.toString() ?? null}",
              "sellerMobile":"${this._sellerMobile ?? null}",
              "area":"${this._area ?? null}",
              "propertyStatus":"${this._propertyStatus ?? null}",
              "removedFiles":"${this._removedFiles ?? null}",
              "publishedCount":"${this._publishedCount ?? null}",
              "firstPublishedDate":"${this._firstPublishedDate ?? null}",
              "recentPublishedDate":"${this._recentPublishedDate ?? null}",
            }''';
  }
}
