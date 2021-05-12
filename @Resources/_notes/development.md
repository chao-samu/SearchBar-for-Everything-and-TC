**The plugin system is not in final state, there could be changes!**

# Writing a new plugin
##  Example: DuckDuckGo search engine

1. Go to "@Resources\plugins" and
copy "websearch_google" folder for a short searchbar and "everything" for a long
searchbar with fields.
We now only need a short searchbar. So copy "websearch_google" folder.
2. Rename your copied folder to "ducksearch"
3. Open config.lua in the copied folder, which should look like this

## FILE: config.lua (in folder ducksearch, unmodified copied file)

    -- This is the table that should be copied to "current" table and can then be accessed
    -- by the main script. If set in "Searchbar.cfg.lua" this table not taking place,
    -- instead it will use the settings provided there.
    if not websearch_google then
    websearch_google = {
    name = 'websearch_google',
    size = 2,
    icon = SKIN:GetVariable('@')..'plugins\\websearch_google\\icon\\png\\',
    field1 = {''},
    field2 = {''},
    text = 'Search Google',
    field1_cmd = {''},
    field2_cmd = {''},
    cmd = 'https://www.google.com/#q=',
    additional = {''}
    }
    end

    -- This are the functions that are called from the main script
    -- if this plugin got activated. The main script calls "fplugin.websearch_init"
    -- set "current = deepcopy(websearch)" in this function!
    fplugin.websearch_google_init = function(current)

        current = deepcopy(websearch_google)
        
        return current
    end

    -- If someone gives an input in this bar, the input is stored in "UserInput"
    -- and the function is called "fplugin.websearch_cmd(UserInput)" from the main
    -- script
    fplugin.websearch_google_cmd = function(current, UserInput)

        SKIN:Bang('["'..current.cmd..UserInput..'"]')
        
    end

    -- If someone changes the bar to another bar, this function is called from the
    -- main script. Nothing to do here for this plugin.
    fplugin.websearch_google_terminate = function()

        
    end


now edit the file like this:
## FILE: config.lua (in folder ducksearch, modified copied file)

    if not ducksearch then
    ducksearch = {
    name = 'ducksearch',
    size = 2,
    icon = SKIN:GetVariable('@')..'plugins\\ducksearch\\icon\\png\\',
    field1 = {''},
    field2 = {''},
    text = 'DuckDuckGo',
    field1_cmd = {''},
    field2_cmd = {''},
    cmd = 'https://duckduckgo.com/?q=',
    additional = {''}
    }
    end

    fplugin.ducksearch_init = function(current)

        current = deepcopy(ducksearch)
        
        return current
    end

    fplugin.ducksearch_cmd = function(current, UserInput)

        SKIN:Bang('["'..current.cmd..UserInput..'"]')
        
    end

    fplugin.ducksearch_terminate = function()
        
    end

5. Be sure the encoding of the config.lua file is UTF-16 LE
see (https://docs.rainmeter.net/tips/unicode-in-rainmeter/)
4. Set you new icons in the icon\png folder. You have to provide images in
16x16, 24x24, 32x32, 48x48 and 256x256 and name it exactly like this without
the png extension.
5. Add "ducksearch" to the plugin table in the main cfg file "SearchBar.cfg.lua"
6. Refresh skin and try to load it, nothing else to do. The rest is handled
automatically. (nothing to do in the store file). If it is not working you
can PM me or write a comment on deviantart.