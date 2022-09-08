#Smart-Organize

**Smart-Organize** is a suite of Automator Actions to help clean up cluttered, untidy folders;  the basic concept being that files are Organized by a specifiect in the top level of the selected directories: 
  * file extension
  * creation date
  * current date

**Important**: After installing Smart-Organize, you may need to configure your *Folder Actions* to ensure that only one Smart-Organize *Folder Action* is active per folder.  The *Folder Actions* work in different ways; the order in which the *Folder Actions* are run is indeterminate.
 
 *Folder Actions*, default to your Downloads folder (`~/Downloads`).

Thank you for choosing Smart-Organize. Enjoy! 😄

---

##What New Options Do I Have In Finder?

Invoking any of the following actions on a file in Finder will create a new folder at the same level, and then move the file into this new folder. The folder's name depends on the selected action:
* **Finder ⇒ Quick Actions ⇒ Organize by Extension**: the file's extension.
* **Finder ⇒ Quick Actions ⇒ Organize by Creation Date**: the file's creation date using format `yyyy-MM-dd`.
* **Finder ⇒ Quick Actions ⇒ Organize by Current Date**: the current date using format `yyyy-MM-dd`.


##What New Folder Actions Do I Have?

* **Organize by Extension**: Creates a folder using the file's extension, and moves the selected file into the folder.
* **Organize by Creation Date**: Creates a folder using the current date, and moves the selected file into the folder.
* **Organize by Current Date**: Creates a folder using the file's creation date, and moves the selected file into the folder.


##What Should I See In Automator?

* **Organize Files with Extension**: Moves each file into a folder with the same name as the extension; parent directory relationships are maintained so other files of the same extension in the directory are moved as well.

  * **Organize Folders by Extension**: Organize each folder such that each file in the folder is moved to a subfolder with a name matching its extension.

* **Organize Items by Date > Today**: Creates a folder with the current date, and moves the selected files into the folder; a new folder is created for each unique parent directory.


