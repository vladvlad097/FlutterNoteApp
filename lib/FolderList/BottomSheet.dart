import 'package:flutter/material.dart';
import 'package:flutternoteapp/SQLDatabase/FolderSQL.dart';
import 'package:flutternoteapp/SQLDatabase/database_helper.dart';
import 'package:flutternoteapp/Misc/ThemeList.dart';

//TODO: The problem is definetly in bottomsheet, seems like parts of the code are not executes correctly, ex checkState() doesn't seem to execute at all

enum FolderMode{Editing, Adding}
enum hadPassword{yes, no}

class BuildBottomSheet extends StatefulWidget {
  final FolderMode _folderMode;

  final List sqList;
  final Function() refreshParent;
  final Folder currentFolder;
  final int index;
  BuildBottomSheet(this._folderMode, this.sqList, this.refreshParent, this.currentFolder, [this.index]);
  @override
  _BuildBottomSheetState createState() =>
      _BuildBottomSheetState(this.sqList,this.refreshParent, this.currentFolder);
}

class _BuildBottomSheetState extends State<BuildBottomSheet> {
  SQLDataBaseHelper helper = SQLDataBaseHelper();

  List sqList;
  Function() refreshParent;

  Folder currentFolder;
  _BuildBottomSheetState(this.sqList, this.refreshParent, this.currentFolder);

  bool isLocked = false;
  bool enableTextField = false;
  bool isNameErrorVisible = false;
  bool isPasswordErrorVisible = false;

  String passwordInserted = '';
  String nameInserted = "";

  Icon icon = Icon(Icons.memory);
  Icon lockIcon = Icon(Icons.lock_open);
  Icon holderIcon = Icon(Icons.lock_open);

  int lockToInt;
  int parentId = 0;
  int numberOfElements;
  TextEditingController textEditorName;
  TextEditingController textEditingPassword;

  FolderColorOptions initValueColor;
  hadPassword _hadPassword;

 void initState(){
   initValueColor = folderColor[0];
   checkState();
   super.initState();
 }

 void checkState(){
   if(widget._folderMode == FolderMode.Editing){
     nameInserted = currentFolder.folderName;
     passwordInserted = currentFolder.password;
     initValueColor = folderColor[currentFolder.colorTheme];
     isLocked = currentFolder.isLocked ==0 ? false : true;
     parentId = currentFolder.folderParentId;

     numberOfElements = currentFolder.numberOfElements;
     textEditorName = TextEditingController(text: nameInserted);
     textEditingPassword = TextEditingController(text: passwordInserted);
     isCheckedIcon(isLocked);
     if(isLocked == true){
       _hadPassword = hadPassword.yes;
     }else{
       _hadPassword = hadPassword.no;
     }
   }else{
     parentId = currentFolder.folderParentId;
   }
 }

  void _unlockPasswordChangeAlert(context) {
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
                    if (passwordInserted == _holderPassword) {
                      setState(() {
                        this.sqList[widget.index].isLocked = boolToInt(false);
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

  int boolToInt(bool isLocked) {
    if (isLocked == true) {
      return lockToInt = 1;
    } else {
      return lockToInt = 0;
    }
  }

  bool checkNameInserted(String newName, bool isLocked) {
   int value =0;
      if ( value == helper.checkFolderName(newName) || newName.isEmpty) {
        isNameErrorVisible = true;
        return false; //invalid
      }

    //check passed
    isNameErrorVisible = false;
    return true; //valid
  }

  void isCheckedIcon(bool isLocked) {
    if (isLocked == true) {
      holderIcon = Icon(
        Icons.lock_outline,
        color: Colors.black,
      );
    } else {
      holderIcon = Icon(
        Icons.lock_open,
        color: Colors.black,
      );
    }
  }

  void activatePasswordTextField() {
    if (isLocked == true) {
      lockIcon = Icon(
        Icons.lock_outline,
        color: Colors.green.shade700,
      );
      enableTextField = true;
    } else {
      lockIcon = Icon(Icons.lock_open);
      enableTextField = false;
      textEditingPassword = TextEditingController(text:'');
    }
  }

  void updateItem(nameInserted)  async{
    if(isLocked == false)
    {
      passwordInserted ="";
      lockToInt =0;
    }else{
      lockToInt =1;
    }

    int result;
    result = await helper.updateFolder(Folder.withId(widget.currentFolder.id,lockToInt, nameInserted, passwordInserted, numberOfElements, initValueColor.objectId, parentId));
    if(result !=0)
    {
      print('was success');
    }
    else{
      print('failure');
    }
  }


  //TODO: it seems that the list gets always printed on the main screen instead of getting printed by number
  void addNewItem(nameInserted)  async{
    if(isLocked == false)
    {
      passwordInserted ="";
      lockToInt =0;
    }else{
      lockToInt =1;
    }
    int result;
    result = await helper.insertFolder(Folder(lockToInt, nameInserted, passwordInserted, 0, initValueColor.objectId, parentId));
    if(result !=0)
    {
      print('was success');
    }
    else{
      print('failure');
    }
     await helper.changeElementNumber(parentId);

  }


  bool checkPasswordInserted(String password) {
    if (isLocked == true) {
      if (password.isEmpty) {
        isPasswordErrorVisible = true;
        return false;
      } else {
        isPasswordErrorVisible = false;
        return true;
      }
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF747474),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0)),
            color: Colors.white,
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.0),


            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Text(
                    'Create Folder',
                    textAlign: TextAlign.center,
                    style:
                    TextStyle(fontSize: 24, color: Colors.green.shade700),
                  ),
                ),


                Container(
                  child: Visibility(
                    visible: isNameErrorVisible,
                    child: Text(
                      'Folder already exits. Insert a different name.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),


                Container(
                  child: Visibility(
                    visible: isPasswordErrorVisible,
                    child: Text(
                      'Please insert a password or uncheck the box below.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
                TextField(
                  controller: textEditorName,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.green.shade700,
                  onChanged: (newText) {
                    nameInserted = newText;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),


                FlatButton(
                  //CREATE BUTTON
                  onPressed: () {
                    bool nameValid = checkNameInserted(nameInserted, isLocked);
                    bool passwordValid =
                    checkPasswordInserted(passwordInserted);
                    if (nameValid && passwordValid) {
                      isCheckedIcon(isLocked);
                      if(widget._folderMode == FolderMode.Adding){
                        addNewItem(nameInserted);
                      }else{
                        updateItem(nameInserted);
                      }
                      refreshParent();
                      Navigator.pop(context);
                    } else {
                      setState(() {});
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Create',
                    ),
                  ),
                  color: Colors.green.shade700,
                ),
                SizedBox(
                  height: 15.0,
                ),


                Container(
                  child: Row(
                    children: <Widget>[
                      icon,
                      Text('Password'),
                      Checkbox(
                        value: isLocked,
                        onChanged: (newValue) {
                          if(_hadPassword == hadPassword.yes && isLocked == true){
                            _unlockPasswordChangeAlert(context);

                          }else{
                            setState(() {
                              isLocked = newValue;
                              activatePasswordTextField();
                            });
                          }
                        },
                      ),
                      Visibility(
                        visible: isLocked,
                        child: Flexible(
                          flex: 1,
                          child: TextField(
                            controller: textEditingPassword,
                            obscureText: true,
                            enabled: enableTextField,
                            textAlign: TextAlign.center,
                            cursorColor: Colors.blue.shade700,
                            onChanged: (newValue) {
                              passwordInserted = newValue;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: lockIcon,
                      ),


                      Container(
                        child: DropdownButton<FolderColorOptions>(
                          value: initValueColor,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 22,
                          elevation: 16,
                          style: TextStyle(
                              color: Colors.deepPurple
                          ),
                          underline: Container(
                            height: 0.0,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (FolderColorOptions newValue) {
                            setState(() {
                              initValueColor = newValue;
                            });
                          },
                          items: folderColor.map((FolderColorOptions colorThemeInstance) {
                            return DropdownMenuItem<FolderColorOptions>(
                              value: colorThemeInstance,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: colorThemeInstance.color,
                                ),
                              ),
                            );
                          })
                              .toList(),
                        ),
                      ),

                      Tooltip(
                        verticalOffset: -250.0,
                        waitDuration: Duration(milliseconds: 100),
                        showDuration: Duration(seconds: 4),
                        message:
                        'Check the box if you want to set up a password for your folder',
                        padding: EdgeInsets.all(5.0),
                        child: Icon(
                          Icons.info_outline,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}