import 'package:flutternoteapp/FloatingActionButton/FAB_action.dart';
import 'package:flutternoteapp/SQLDatabase/NoteSQL.dart';
import 'package:flutternoteapp/NewNote/EmptyTextFile.dart';
import 'package:flutternoteapp/SQLDatabase/FolderSQL.dart';
import 'package:flutternoteapp/SQLDatabase/database_helper.dart';
import 'package:flutternoteapp/Misc/ThemeList.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'BottomSheet.dart';
import 'package:flutternoteapp/Misc/TabsFile.dart';
//import 'package:thisismylastattempt/FloatingActionButton/FAB_action.dart';


//TODO: Change design of folder to be nice, and the note to be in Card widgets and have part of the text show before you open it
//TODO: overflow: TextOverflow.ellipsis ; maxLines: 3

class Notes extends StatefulWidget {
  static const id = "notes";

  final int parentId;
  Notes(this.parentId);
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  SQLDataBaseHelper databaseHelper = SQLDataBaseHelper();
  List<dynamic> sqList;
  int count = 0;
  int lockToInt;
  int currentLevelId;
  int numberOfElements;

  FancyFab fancyFab;

  dynamic registeredUnitToMove;

  @override
  void initState() {
    databaseHelper.initializeDatabase();
    currentLevelId = widget.parentId;
    super.initState();
  }

  Widget addFolder(
      List<dynamic> sqList, Function updateListView, int currentLevelId) {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: BuildBottomSheet(FolderMode.Adding, sqList,
                    updateListView, Folder(1, '', '', 0, 0, currentLevelId)),
              ),
            ),
          );
        },
        tooltip: 'AddFolder',
        child: Icon(Icons.create_new_folder),
      ),
    );
  }

  Widget addNote(int currentLevelId) {
    return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmptyTextFile(
                        NoteMode.Adding, currentLevelId, updateListView)))
            .then((value) {
          setState(() {});
        }),
        tooltip: 'AddNote',
        child: Icon(Icons.assignment),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //print('i am in notes');
    if (sqList == null) {
      sqList = List<dynamic>();

      updateListView();
    }
    fancyFab = FancyFab(
        addFolder: addFolder(sqList, updateListView, currentLevelId),
        addNote: addNote(currentLevelId));
    return Scaffold(
      floatingActionButton: fancyFab,
      body: getFolderListView(),
    );
  }

  Widget folderToShow(int index) {
    return Material(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: Container(
          color: folderColor[sqList[index].colorTheme].color,
          child: ListTile(
            onTap: () {
              setState(() {
                if (sqList[index].isLocked == 1) {
                  print(sqList[index].folderName);
                  _checkPasswordChangeAlert(index);
                } else if (sqList[index].isLocked == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TabsFile(sqList[index].id)));
                }
              });
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  child: Icon(
                    Icons.create,
                    color: Colors.black,
                    size: 22.0,
                  ),
                  onTap: () {
                    print('edit folder');
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: BuildBottomSheet(FolderMode.Editing, sqList,
                                updateListView, sqList[index], index)),
                      ),
                    );
                  },
                ),
                SizedBox(width: 4.0),
                Icon(Icons.folder, color: Colors.black, size: 26.0),
                SizedBox(width: 4.0,),
                Text(sqList[index].folderName),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(width: 5.0),
                GestureDetector(
                  child: getIsLockedIcon(intToBool(sqList[index].isLocked)),
                  onTap: () => unlockingLock(index),
                ),
                SizedBox(width: 4.0),
                GestureDetector(
                  child: Icon(
                    Icons.delete,
                    color: Colors.black,
                    size: 25.0,
                  ),
                  onTap: () {
                    if (intToBool(sqList[index].isLocked) == true) {
                      _deleteFolderChangeAlert(index);
                    } else {
                      _deleteFolder(context, sqList[index]);
                    }
                    setState(() {
                      print("deleted");
                    });
                  },
                ),
                SizedBox(width: 4.0),
                //Text('${sqList[index].numberOfElements} elements'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget noteToShow(int index) {
    return Material(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        child: Container(
          color: Colors.grey.shade400,
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmptyTextFile.toEdit(NoteMode.Editing,
                        sqList[index], updateListView, currentLevelId),
                  )).then((value) {
                setState(() {});
              });
            },
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.assignment),
                SizedBox(width: 5.0),
                Text(sqList[index].noteName),
              ],
            ),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.black,
                size: 25.0,
              ),
              onTap: () {
                _deleteNote(context, sqList[index]);
                setState(() {
                  print("deleted");
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  ListView getFolderListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        return sqList[index].tag == 'N'
            ? LongPressDraggable(
                axis: Axis.vertical,
                child: noteToShow(index),
                feedback: noteToShow(index),
                childWhenDragging: Container(
                  color: Colors.grey.shade400,
                ),
                data: sqList[index],
                onDragStarted: () {
                  registeredUnitToMove = this.sqList[index];
                  print('drag has begun $registeredUnitToMove');
                  print('drag note');
                },
                // onDragCompleated:
              )
            : DragTarget(
                builder: (context, dynamic candidateData, rejectedData) {
                  return Container(
                    color: Colors.grey.shade400,
                    child: LongPressDraggable(
                      axis: Axis.vertical,
                      child: folderToShow(index),
                      feedback: folderToShow(index),
                      childWhenDragging: Container(color: Colors.white),
                      data: sqList[index],
                      onDragStarted: () {
                        registeredUnitToMove = this.sqList[index];
                        print('drag has begun $registeredUnitToMove');
                        print('drag folder');
                      },
                    ),
                  );
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  setState(() {
                    objectMovedToFolder(sqList[index].id, registeredUnitToMove);
                    updateListView();
                  });
                },
              );
      },
    );
  }

  void objectMovedToFolder(int newFolderParentId, dynamic data) async {
    print('this should be the data: $data');
    print(registeredUnitToMove);
    if (data.tag == 'N') {
      await databaseHelper.updateNote(Note.withId(
          data.id, data.noteName, data.noteText, newFolderParentId));
    } else {
      await databaseHelper.updateFolder(Folder.withId(
          data.id,
          data.isLocked,
          data.folderName,
          data.password,
          data.numberOfElements,
          data.colorTheme,
          newFolderParentId));
    }

    await databaseHelper.changeElementNumber(newFolderParentId);
    updateListView();
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<dynamic>> sqListFuture =
          databaseHelper.getSQList(currentLevelId);
      sqListFuture.then((sqList) {
        setState(() {
          this.sqList = sqList;
          this.count = sqList.length;
        });
      });
    });
  }

  void _deleteFolder(BuildContext context, Folder folder) async {
    if (folder.id == null) {
      _showAlertDialog("Status", "No Folder was deleted");
    } else {
      int result = await databaseHelper.deleteFolder(folder.id);
      updateListView();
      if (result != 0) {
        _showAlertDialog('Status', 'Note Deleted Successfully');
      } else {
        _showAlertDialog('Status', 'Error Occured while Deleting Note');
      }
    }
  }

  void _deleteNote(BuildContext context, Note note) async {
    if (note.id == null) {
      _showAlertDialog("Status", "No Folder was deleted");
    } else {
      int result = await databaseHelper.deleteNote(note.id);
      updateListView();
      if (result != 0) {
        _showAlertDialog('Status', 'Note Deleted Successfully');
      } else {
        _showAlertDialog('Status', 'Error Occured while Deleting Note');
      }
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar((snackBar));
  }

  void navigateToDetailOfFolder(Folder folder, String folderName) {
    //push the new page with Navigator
    //return FolderDetails(parameters) -> the params inside the folder passed over to the subtree
  }

  Icon getIsLockedIcon(bool isLocked) {
    if (isLocked == true) {
      return Icon(
        Icons.lock_outline,
        color: Colors.black,
      );
    } else {
      return Icon(
        Icons.lock_open,
        color: Colors.black,
      );
    }
  }

  void _updatePasswordChangeAlert(int index) {
    String _holderPassword;
    AlertDialog updatePasswordAlert = AlertDialog(
      title: Text('Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              _holderPassword = newText;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                  child: Text('Add Password'),
                  onPressed: () {
                    setState(() {
                      sqList[index].password = _holderPassword;
                      databaseHelper.updateFolder(sqList[index]);
                      this.sqList[index].isLocked = boolToInt(true);
                      print('now locked');
                      Navigator.pop(context);
                    });
                  }),
            ],
          ),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return updatePasswordAlert;
      },
    );
  }

  void _checkPasswordChangeAlert(int index) {
    bool result;
    String _holderPassword;
    AlertDialog updatePasswordAlert = AlertDialog(
      title: Text('Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            autofocus: true,
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              _holderPassword = newText;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                  child: Text('Enter Password'),
                  onPressed: () {
                      if (sqList[index].password == _holderPassword) {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabsFile(sqList[index].id)));

                      } else {
                        //TODO: add alert here and a while loop
                            print('wrong password');
                      }

                  }),
            ],
          ),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return updatePasswordAlert;
      },
    );
    print(result);
  }

  void _unlockPasswordChangeAlert(int index) {
    String _holderPassword;
    AlertDialog removePasswordAlert = AlertDialog(
      title: Text('Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              _holderPassword = newText;
            },
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                  child: Text('Unlock'),
                  onPressed: () {
                    if (sqList[index].password.toString() == _holderPassword) {
                      setState(() {
                        this.sqList[index].isLocked = boolToInt(false);
                        Navigator.pop(context);
                      });
                    } else {
                      print("password inserted is not the same");
                    }
                  }),
            ],
          ),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return removePasswordAlert;
      },
    );
  }

  void _deleteFolderChangeAlert(int index) {
    String _holderPassword;
    AlertDialog removePasswordAlert = AlertDialog(
      title: Text('Password'),
      content: TextField(
        autofocus: true,
        textAlign: TextAlign.center,
        onChanged: (newText) {
          _holderPassword = newText;
        },
      ),
      actions: <Widget>[
        FlatButton(
            child: Text('Remove'),
            onPressed: () {
              if (sqList[index].password.toString() == _holderPassword) {
                _deleteFolder(context, sqList[index]);
                Navigator.pop(context);
              } else {
                print("password inserted is not the same");
              }
            }),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return removePasswordAlert;
      },
    );
  }

  void unlockingLock(int index) {
    setState(() {
      if (intToBool(this.sqList[index].isLocked) == false) {
        _updatePasswordChangeAlert(index);
        // print('now locked');
        // this.sqList[index].isLocked = boolToInt(true);
      } else {
        _unlockPasswordChangeAlert(index);
        // print('now unlocked');
        // this.sqList[index].isLocked = boolToInt(false);
      }
    });
  }

  void refresh() {
    setState(() {});
  }

  int boolToInt(bool isLocked) {
    if (isLocked == true) {
      return lockToInt = 1;
    } else {
      return lockToInt = 0;
    }
  }

  bool intToBool(int lockValue) {
    if (lockValue == 1) {
      return true;
    } else {
      return false;
    }
  }
}
