class Attachment {
  int _id;

  String _name;

  String _fileContent;

  String _fileType;

  String _fileUrl;
  int get id => _id;

  set id(int value) => _id = value;

  String get name => _name;

  set name(String value) => _name = value;

  String get fileContent => _fileContent;

  set fileContent(String value) => _fileContent = value;

  String get fileType => _fileType;

  set fileType(String value) => _fileType = value;

  String get fileUrl => _fileUrl;

  set fileUrl(String value) => _fileUrl = value;

  Attachment(
      this._id, this._name, this._fileContent, this._fileType, this._fileUrl);

  Attachment.fromJson(Map<String, dynamic> json) {
    _id = json["id"] ?? null;
    _name = json["name"] ?? null;
    _fileContent = json["fileContent"] ?? null;
    _fileType = json["fileType"] ?? null;
    _fileUrl = json["fileUrl"] ?? null;
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this._id ?? null,
        'name': this._name ?? null,
        'fileContent': this._fileContent ?? null,
        'fileType': this._fileType ?? null,
        'fileUrl': this._fileUrl ?? null,
      };

  @override
  String toString() {
    // TODO: implement toString
    return '''{
               "id":"${this._id}",
               "name":"${this._name}",
               "fileContent":"${this._fileContent}",
               "fileType":"${this._fileType}",
               "fileUrl":"${this._fileUrl}"
            }''';
  }
}
