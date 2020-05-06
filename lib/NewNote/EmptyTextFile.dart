import 'package:flutter/material.dart';
import 'package:flutternoteapp/SQLDatabase/database_helper.dart';
import 'package:flutternoteapp/SQLDatabase/NoteSQL.dart';
import 'package:flutternoteapp/Misc/ThemeList.dart';

enum NoteMode { Editing, Adding }



class EmptyTextFile extends StatefulWidget {
  static const id = "empty_text_file";
  final int parentId;
  final NoteMode _noteMode;
  final Note noteReceived;
  final Function() refreshParent;
  EmptyTextFile(this._noteMode, [this.parentId, this.refreshParent, this.noteReceived]);
  EmptyTextFile.toEdit(this._noteMode, this.noteReceived, this.refreshParent, this.parentId);

  @override
  _EmptyTextFileState createState() => _EmptyTextFileState();
}

class _EmptyTextFileState extends State<EmptyTextFile> {
  SQLDataBaseHelper helper = SQLDataBaseHelper();

  String newNoteName;
  String newNoteText;
  TextEditingController textEditorText;
  TextEditingController textEditorName;


  @override
  void initState() {

    if(widget.noteReceived == null){
      print('it is null');
    } else{
      newNoteName = widget.noteReceived.noteName;
      newNoteText = widget.noteReceived.noteText;
    }
    if(newNoteText ==null){
      newNoteText = '';
    }
    if(newNoteName ==null){
      newNoteName = '';
    }
    print(newNoteName);
    print(newNoteText);
    textEditorText = TextEditingController(text: newNoteText);
    textEditorName = TextEditingController(text: newNoteName);
    super.initState();
  }

  void saveCheck()async{
    int result;
    int value =0;
    if (widget._noteMode == NoteMode.Adding) {
      if(value == helper.checkNoteName(newNoteName) || newNoteName.isEmpty){
        //TODO: PRINT AN ERROR
        print('got an error in Adding');
      }else{
        result = await helper.insertNote(Note(newNoteName, newNoteText, widget.parentId));
        if(widget.parentId != null){
          widget.refreshParent();
        }
        Navigator.pop(context);
      }
    } else if(widget._noteMode == NoteMode.Editing){
      if(value == helper.checkNoteName(newNoteName) || newNoteName.isEmpty){
        //TODO: PRINT AN ERROR
        //print('got an error in Editing');
      }
      else{
        result = await helper.updateNote(Note.withId(widget.noteReceived.id,newNoteName, newNoteText, widget.parentId));
        print(newNoteName);
        print("note updated");
        print(result);
        widget.refreshParent();
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget._noteMode == NoteMode.Editing
            ? Text('Edit Note')
            : Text('Add note'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.save,
            ),
            label: Text('save'),
            onPressed: () {
              saveCheck();
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: TextField(
              controller: textEditorName,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Title',
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                )),
              ),
              onChanged: (value) {
                setState(() {
                  //textEditorName.text = value;
                  newNoteName = value;
                  print(newNoteName);
                });
              },
            ),
          ),
          TextField(
              controller: textEditorText,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Note',
                //focusedBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  //textEditorText.text = value;
                  newNoteText = value;
                });
              }),
        ],
      ),
    );
  }
}
