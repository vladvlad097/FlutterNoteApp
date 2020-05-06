
class Folder{
  int _id;
  int _isLocked;
  String _folderName;
  String _password = '';
  int _numberOfElements =0;
  int _colorTheme =1;
  int _folderParentId;
  String _tag = 'F';

  Folder(this._isLocked, this._folderName, this._password, this._numberOfElements, this._colorTheme, this._folderParentId);

  Folder.withId(this._id, this._isLocked, this._folderName, this._password, this._numberOfElements, this._colorTheme, [this._folderParentId]);

  int get id =>_id;
  int get isLocked => _isLocked;
  String get folderName => _folderName;
  String get password => _password;
  int get colorTheme => _colorTheme;
  int get numberOfElements => _numberOfElements;
  int get folderParentId => _folderParentId;
  String get tag => _tag;

  set isLocked(int valueIsLocked){
    this._isLocked = valueIsLocked;
  }

  set folderName(String newFolderName){
    this._folderName = newFolderName;
  }

  set password(String  newPassword){
    this._password = newPassword;
  }

  set colorTheme(int newColorTheme){
    this._colorTheme = newColorTheme;
  }

  set numberOfElements(int newValueElements){
    this._numberOfElements = newValueElements;
  }

  set folderParentId(int newParentValue){
    this._folderParentId = newParentValue;
  }

  //add to the database
  Map<String, dynamic>toMap(){
    var map = Map<String, dynamic>();
    if(id != null)
    {
      map['id'] = _id;
    }
    map['folderName'] = _folderName;
    map['isLocked'] = _isLocked;
    map['password'] = _password;
    map['colorTheme'] = _colorTheme;
    map['numberOfElements'] = _numberOfElements;
    map['folderParentId'] = _folderParentId;
    map['tagFolder'] = _tag;
    return map;
  }

  //extract from database / parameter as instance
  Folder.fromMapObject(Map<String, dynamic>map)
  {
    this._id = map["id"];
    this._folderName = map["folderName"];
    this._isLocked = map["isLocked"];
    this._password = map["password"];
    this._colorTheme = map["colorTheme"];
    this._numberOfElements = map['numberOfElements'];
    this._folderParentId = map['folderParentId'];
    this._tag =  map['tagFolder'];

  }
}