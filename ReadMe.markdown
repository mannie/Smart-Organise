#Smart-Organise

**Smart-Organise** is a suite of Automator Actions to help clean up cluttered, untidy folders;  the basic concept being that files are organised by their extensions in the top level of the selected directories.

**Important**: After installing Smart-Organise, you may need to configure your *Folder Actions* to ensure that only one Smart-Organise *Folder Action* is active per folder.  The *Folder Actions* work in different ways; the order in which the *Folder Actions* are run is indeterminate.
 
 *Folder Actions*, default to your Downloads folder (`~/Downloads`).

Thank you for choosing Smart-Organise;  I hope you enjoy using it! 😄

[]()

[]()

[]()

[]()

[]()

[]()

[]()

[]()

[]()

[]()

[]()

[]()


##What New Options Do I Have In Finder?

* **Finder ⇒ Services ⇒ Organise Files with Extension**: Invoking this action on a file in Finder, will create a folder (at the same level as the file) with the same name as the file's extension; the file is then moved into this folder.

  * **Finder ⇒ Services ⇒ Organise Folders by Extension**: Invoking this action on a folder in Finder, will create subfolders whose names are based on the extensions of the files in the folder.  Each file in the folder is moved into a subfolder corresponding to the file's extension.

* **Finder ⇒ Services ⇒ Organise Items by Date > Today > Today**: Invoking this action on a file or folder in Finder, will create a folder at the same level as the file; the file is then moved into this folder.  The folder's name is based on the current date `yyyy-MM-dd`.


##What New Folder Actions Do I Have?

* **Organise Files with Extension**: Moves the file into a folder with the same name as the extension; parent directory relationships are maintained, so other files of the same extension in the directory are moved as well.

* **Organise Items by Date**: Creates a folder with the current date, and moves the selected files into the folder.


##What Should I See In Automator?

* **Organise Files with Extension**: Moves each file into a folder with the same name as the extension; parent directory relationships are maintained so other files of the same extension in the directory are moved as well.

  * **Organise Folders by Extension**: Organise each folder such that each file in the folder is moved to a subfolder with a name matching its extension.

* **Organise Items by Date > Today**: Creates a folder with the current date, and moves the selected files into the folder; a new folder is created for each unique parent directory.


