Feature: renameFolders

	Scenario Outline: Rename a folder using special characters
		Given a regular user exists
		And I am logged in as a regular user
		And I am on the files page
		When I rename the folder "simple-folder" to <to_folder_name>
		Then the folder <to_folder_name> should be listed
		Examples:
		|to_folder_name|
		|'सिमप्ले फोल्देर'    |
		|'"quotes1"'   |
		|"'quotes2'"   |		

	Scenario Outline: Rename a folder that has special characters in its name
		Given a regular user exists
		And I am logged in as a regular user
		And I am on the files page
		When I rename the folder <from_name> to <to_name>
		Then the folder <to_name> should be listed
		Examples:
		|from_name           |to_name               |
		|"strängé नेपाली folder"|"strängé नेपाली folder-2"|
		|"'single'quotes"    |"single-quotes"       |
		|'"double"quotes'    |'double-quotes'       |

	Scenario: Rename a folder using forbidden characters
		Given a regular user exists
		And I am logged in as a regular user
		And I am on the files page
		When I rename the folder "simple-folder" to one of these names
		|simple/folder   |
		|.htaccess       |
		|simple\folder   |
		|\\simple/folder |
		|../simple-folder|
		Then notifications should be displayed with the text
		|Could not rename "simple-folder"|
		|Could not rename "simple-folder"|
		|Could not rename "simple-folder"|
		|Could not rename "simple-folder"|
		|Could not rename "simple-folder"|
		And the folder "simple-folder" should be listed

	Scenario: Rename a folder putting a name of a file which already exists
		Given a regular user exists
		And I am logged in as a regular user
		And I am on the files page
		When I rename the folder "simple-folder" to "lorem.txt"
		Then near the folder "simple-folder" a tooltip with the text 'lorem.txt already exists' should be displayed