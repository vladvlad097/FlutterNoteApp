import 'package:flutter/material.dart';
import 'package:flutternoteapp/SQLDatabase/NoteSQL.dart';
import 'FolderSQL.dart';
import 'database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';


class SQList extends StatefulWidget {
  final parentId;
  SQList(this.parentId);
  @override
  _SQListState createState() => _SQListState();
}

class _SQListState extends State<SQList> {

  SQLDataBaseHelper databaseHelper = SQLDataBaseHelper();
  List<dynamic> sqList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if(sqList == null){
      sqList = List<Folder>();
      updateListView(widget.parentId);
    }
    return Scaffold();
  }

  void updateListView(int parentId) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database){
      Future<List<dynamic>> sqListFuture = databaseHelper.getSQList(parentId);
      sqListFuture.then((sqList){
        setState(() async{
          this.sqList= sqList;
          this.count = await databaseHelper.getLevelCount(parentId);
        });
      });
    });
  }


  void _deleteFolder(BuildContext context, Folder folder) async {
    int result = await databaseHelper.deleteFolder(folder.id);
    if(result !=0){
      _showSnackBar(context, 'Folder Deleted Successfully');
      updateListView(widget.parentId);
    }
  }

  void _deleteNote(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);
    if(result !=0){
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView(widget.parentId);
    }
  }

  void _showSnackBar(BuildContext context, String message){
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar((snackBar));
  }

  Icon getIsLockedIcon(bool isLocked)
  {
    if(isLocked ==true){
      return Icon(
        Icons.lock_outline,
        color: Colors.black,
      );
    }else{
      return Icon(
        Icons.lock_open,
        color: Colors.black,
      );
    }
  }


}
