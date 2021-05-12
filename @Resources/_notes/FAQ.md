# So many Files which one do i really need?
You need only two:

- "SearchBar.cfg.lua"     --> edit for technical things  
- "Searchbar<flavor>.ini" --> edit for appearance of the skin  

You can reach the ini file for appearance easily with right clicking on the
active skin and choose "Edit skin".

You can reach the .cfg file for technical things easily with right clicking
on the active skin, and choose the bold name. Then you should see the file and
you should open it with an editor.



# How can I change the color of the Skin?
Open the ini file and search for: 

    "BackgroundColorShape=255,255,255,255"
    "BackgroundColorInput=255,255,255,255"  

This are RGBA values, google it if you don't know what it is.

 - BackgroundColorShape is for the the background of the entire skin  
 - BackgroundColorInput is the background when you are typing

For green for example set "BackgroundColorShape=0,255,0,255".
Save the file and Renew the skin! Renew is important
(Right-click on the skin --> "Refresh skin")!



# How can I add my drives?
Open cfg file and search for "`drives=`"
Just delete or add the one you need.

Save the file and renew the skin! Renew is important
(Right-click on the skin--> "Refresh skin")!



# How can I change the icons?
Here a small example on the amazon plugin:

    1. Right click on the skin and select the bold skin name

    2. Go to \@Resources\plugins\amazon\icon\png

    3. Inside that folder replace the png files (16x16.png; 32x32.png; 48x48.png 24x24.png; 256x256.png) with your png files. The scale of the images should be according to the name eg. 16x16 (use gimp or other image editor)

    4. Refresh the skin and it should work. (Don't forget that, i forgot it so often myself xD)



# totalcommander or doublecommander plugin is not working, a weird dialogue opens?
You need [Autohotkey](https://www.autohotkey.com/) installed to get it to work.

Also you need the required program [Total Commander](https://www.ghisler.com/) or [Double Commander ](https://doublecmd.sourceforge.io/)
installed!

Also the Path must be correct, look in section "Everything" if it is not working for the path adjustment.



# Everything is not working?
Be sure [Everything](https://www.voidtools.com/) is installed.

Also the path to the program have to be correct, if it's not the default path. 

To adjust the path: 

1. Open "SearchBar.cfg.lua"
2. go to plugin override section
3. remove "--" to uncomment and edit the everything table like shown below, with your path:

        everything = {
        name = 'everything',
        size = 1,
        icon = SKIN:GetVariable('@')..'plugins\\Everything\\icon\\png\\',
        field1 = drives,
        field2 = { 'ALL' , 'FOLDER', 'FILE' },
        text = 'Search Everything',
        field1_cmd = {},
        field2_cmd = { '', 'folder:', 'file:' },
        cmd = SKIN:ReplaceVariables('C:\\Program Files (x86)\\Everything\\Everything.exe'),
        additional = {drive = {}}
        }

Don't forget the Refresh the skin! Try it.



# Can I change the the websearch plugin to search with DuckDuckGo?
Yes, use the plugin override in the cfg file "SearchBar.cfg.lua".

1. Open "SearchBar.cfg.lua"
2. go to plugin override section
3. remove "--" to uncomment and edit the websearch_google table like shown below (adjust text and cmd):

        websearch_google = {
        name = 'websearch_google',
        size = 2,
        icon = SKIN:GetVariable('@')..'plugins\\websearch_google\\icon\\png\\',
        field1 = {''},
        field2 = {''},
        text = 'Search DuckDuckGo',
        field1_cmd = {''},
        field2_cmd = {''},
        cmd = 'https://duckduckgo.com/?q=',
        additional = {''}
        }