

class Note {
  int _noteId;
  String _noteName;
  String _noteText;
  int _noteParentId;
  String _tag = 'N';

  Note(this._noteName, this._noteText, this._noteParentId);

  Note.withId(this._noteId, this._noteName, this._noteText, this._noteParentId);

  int get id =>_noteId;
  String get noteName => _noteName;
  String get noteText =>_noteText;
  int get noteParentId => _noteParentId;
  String get tag => _tag;


  set name(String nameValue){
    this.name = nameValue;
  }

  set text(String textValue){
    this.text = textValue;
  }

  set noteParentId(int parentValue){
    this._noteParentId = parentValue;
  }

  Map<String, dynamic>toMap(){
    var map = Map<String, dynamic>();
    if(id !=null){
      map['id'] = _noteId;
    }
    map['noteName'] = _noteName;
    map['noteText'] = _noteText;
    map['noteParentId'] = _noteParentId;
    map['tagNote'] = _tag;
    return map;
  }

  Note.fromMapObject(Map<String,dynamic>map)
  {
    this._noteId = map['id'];
    this._noteName = map['noteName'];
    this._noteText = map['noteText'];
    this._noteParentId = map['noteParentId'];
    this._tag = map['tagNote'];

  }

}