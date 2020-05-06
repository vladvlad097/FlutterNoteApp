# flutternoteapp

Implemented functionalites so far: 

-SQLite database: can update, delete, add, folders and notes
The user is able to edit files, place them inside folders, lock them behind a password, and even customise the color of the folder.

-Firebase: authentication
So far authentication is done only via email and password

-Design: Custom theme, Draggable objects, Custom Floating Action Button
Mostily visual stuff to help the user fell more confortable with using the app

-Shared Prefs: 
App Theme, changes the way the app looks from a wide range of custom colors

KNOWN BUGS:
-shared preferences does not load properly on reopening the app
-pop up error messages for some cases have not been implemented yet
-User is not able to pull the folders or notes to a higher level in the herarchy. (Create an area on the top of the screen where the user can drag the objects and push them up the heirarchy)
-on delete folder with heirarchy the rest of the files are not deleted and are stuck in the database to never be accesed again 
(must make call to database with same parentID to delete all)


Future implementation:
-Connect cloud with local database
-Populate the other pages under the drawer with the necesary functionalities


