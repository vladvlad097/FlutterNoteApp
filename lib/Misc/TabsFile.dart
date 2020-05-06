import 'package:flutter/material.dart';
import 'package:flutternoteapp/Firebase/authentication.dart';
import '../NewNote/NewNote.dart' ;
import '../FolderList/Notes.dart';
import '../Options/SettingsPage.dart';

class TabsFile extends StatefulWidget {
  static const id = 'tabs_file';
  @override
  _TabsFileState createState() => _TabsFileState();

  final int folderParentId;

  TabsFile([this.folderParentId]);
}

class _TabsFileState extends State<TabsFile> with TickerProviderStateMixin{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();
  TabController tabController;
  int parentId;
  void initState() {
    if(widget.folderParentId == null){
      parentId =0;
    }else{
      parentId = widget.folderParentId;
    }
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.list,
            size: 32.0,),
          onPressed: () {_scaffoldKey.currentState.openDrawer();},
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: Colors.white,),
            label: Text('Log out', style: TextStyle(color: Colors.white,),),
            onPressed: () async{
              await _auth.signOut();
            },
          ),
//TODO: tooltip disables, useless so far and was ruining format
//          Tooltip(
//            message: 'Quick Tutorial',
//            child: FlatButton(
//              child: Icon(
//                Icons.help,
//                color: Colors.white,
//              ),
//              onPressed: (){
//
//              },
//            ),
//          ),
        ],
        centerTitle: true,
        title: Text('NoteApp'),
        bottom: TabBar(
          // Colors.green.shade600,
          tabs: <Widget>[
            Tab(
              text: 'Notes',
              icon: Icon(Icons.description),
            ),
            Tab(
              text: 'New Note',
              icon: Icon(Icons.content_paste),
            ),
          ],
          controller: tabController,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            ListTile(
              title: Text('logo+nameofApp'),
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: 1.0,
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security'),
            ),
            ListTile(
              leading: Icon(Icons.archive),
              title: Text('Archive'),
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: 1.0,
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
            ),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pushNamed(context, SettingsPage.id);
                }
            ),
            Divider(
              color: Colors.grey.shade400,
              thickness: 1.0,
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Recycle Bin'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Notes(parentId),
          NewNote(),
        ],
        controller: tabController,
      ),
    );
  }
}
