import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:flutternoteapp/SQLDatabase/NoteSQL.dart';
import 'FolderSQL.dart';
import 'package:path/path.dart';

class SQLDataBaseHelper {
  static SQLDataBaseHelper _databaseHelper;
  static Database _dataBase;

  ///FOLDER TABLE
  String folderTable = 'folder_table';
  String folderId = 'id';
  String folderName = 'folderName';
  String isLocked = 'isLocked';
  String password = 'password';
  String folderTheme = 'colorTheme';
  String numberOfElements = 'numberOfElements';
  String folderParentId = 'folderParentId';
  String tagFolder = 'tagFolder';

  ///NOTE NOTE
  String noteTable = 'note_table';
  String noteId = 'id';
  String noteName = 'noteName';
  String noteText = 'noteText';
  String noteParentId = 'noteParentId';
  String tagNote = 'tagNote';



  SQLDataBaseHelper._createInstance();

  factory SQLDataBaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = SQLDataBaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if(_dataBase == null) {
      _dataBase = await initializeDatabase();
    }
    return _dataBase;
  }

  Future<Database> initializeDatabase() async{
    //await _dataBase.rawQuery("DROP TABLE  $folderTable" );
    //await _dataBase.rawQuery("DROP TABLE  $noteTable" );
    var appDatabase = await openDatabase(join(await getDatabasesPath(), 'app_database.db'), version: 1, onCreate: _createDB);
    return appDatabase;
  }
  void _createDB(Database db, int newVersion) async{
    await db.execute('CREATE TABLE $folderTable ( $folderId INTEGER PRIMARY KEY, $folderName TEXT, $isLocked INTEGER, $password TEXT, $folderTheme INTEGER, $numberOfElements INTEGER, $folderParentId INTEGER, $tagFolder TEXT,  UNIQUE ($folderName) )');
    await db.execute('CREATE TABLE $noteTable ( $noteId INTEGER PRIMARY KEY, $noteName TEXT, $noteText TEXT, $noteParentId INTEGER, $tagNote TEXT, UNIQUE ($noteName) )');
  }


  Future<List<Map<String, dynamic>>> getFolderMapList(int idNeeded) async {
    Database db = await this.database;
    var folderTableResult = await db.rawQuery("SELECT * FROM $folderTable WHERE $folderParentId = $idNeeded");
    return folderTableResult;
  }

  Future<List<Map<String, dynamic>>> getNoteMapList(int idNeeded) async {
    Database db = await this.database;
    var noteTableResult = await db.rawQuery("SELECT * FROM $noteTable WHERE $noteParentId = $idNeeded");
    return noteTableResult;
  }


  Future<List<dynamic>> getSQList(int idNeeded) async {
    var sqFolderMapList = await getFolderMapList(idNeeded);
    var sqNoteMapList = await getNoteMapList(idNeeded);
    int countFolder = sqFolderMapList.length;
    int countNote = sqNoteMapList.length;

    List<dynamic> sqList = List<dynamic>();

    for(int i=0; i<countNote;i++){
      sqList.add(Note.fromMapObject(sqNoteMapList[i] ));
    }
    for(int i=0; i<countFolder;i++){
      sqList.add(Folder.fromMapObject(sqFolderMapList[i] ));
    }


    return sqList;
  }


  Future<int> insertFolder(Folder folder) async{
    Database db = await this.database;
    var result = await db.insert(folderTable, folder.toMap());
    return result;
  }


  Future<int> updateFolder(Folder folder) async{
    Database db = await this.database;
    var result = await db.update(folderTable, folder.toMap(), where: '$folderId = ?', whereArgs:  [folder.id]);
    return result;
  }

  //Delete Operation: Delete a note object from database
  Future<int> deleteFolder(int id) async{
    print('$id');
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $folderTable WHERE $folderId = $id');
    print('folder deleted');
    return result;
  }


  Future<int> insertNote(Note note) async{
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }


  Future<int> updateNote(Note note) async{
    Database db = await this.database;
    //var result = await db.update(noteTable, note.toMap(), where: '$noteId = ?', whereArgs:  [note.id]);
    var result = await db.rawUpdate('UPDATE $noteTable SET $noteName = \'${note.noteName}\', $noteText = \'${note.noteText}\', $noteParentId = \'${note.noteParentId}\' WHERE $noteId = ${note.id}');
    return result;
  }


  Future<int> deleteNote(int id) async{
    print('$id');
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $noteId = $id');
    print('note deleted');
    return result;
  }


  Future<int> getLevelCount(int idNeeded) async{
    Database db = await this.database;
    List<Map<String, dynamic>> folderCount  = await db.rawQuery("SELECT * FROM $folderTable WHERE $folderParentId = $idNeeded ");
    List<Map<String, dynamic>> noteCount  = await db.rawQuery("SELECT * FROM $noteTable WHERE $noteParentId = $idNeeded ");
    int result1 = Sqflite.firstIntValue(folderCount);
    int result2 = Sqflite.firstIntValue(noteCount);
    int result = result1+ result2;
    return result;
  }

  Future<int> checkFolderName(String nameToCheck) async{
    Database db = await this.database;
    List<Map<String, dynamic>> listOfFoldersWithName = await db.rawQuery("SELECT * FROM $folderTable WHERE $folderName = $nameToCheck");
   return listOfFoldersWithName.length;
  }

  Future<int> checkNoteName(String nameToCheck) async{
    Database db = await this.database;
    List<Map<String, dynamic>> listOfNotesWithName = await db.rawQuery("SELECT * FROM $folderTable WHERE $folderName = $nameToCheck");
    return listOfNotesWithName.length;
  }

  Future<void> changeElementNumber(int idNeeded) async{
    Database db = await this.database;
    List<Map<String, dynamic>> folderCount  = await db.rawQuery("SELECT * FROM $folderTable WHERE $folderParentId = $idNeeded ");
    List<Map<String, dynamic>> noteCount  = await db.rawQuery("SELECT * FROM $noteTable WHERE $noteParentId = $idNeeded ");
    int result1 = Sqflite.firstIntValue(folderCount);
    int result2 = Sqflite.firstIntValue(noteCount);
    int resultElementsNumber = result1+ result2;

    await db.rawUpdate('UPDATE $folderTable SET $numberOfElements = \'$resultElementsNumber\' WHERE $noteId = $idNeeded');
  }

}