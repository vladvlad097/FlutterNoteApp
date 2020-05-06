import 'package:flutter/material.dart';
import 'EmptyTextFile.dart';

class NewNote extends StatefulWidget {
  static const id = "new_note";
  @override
  _NewNoteState createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('New Note',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),),
            SizedBox(height: 15.0,),
            FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.add,
                color: Colors.black,
                size: 40.0,
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>EmptyTextFile(NoteMode.Adding)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
