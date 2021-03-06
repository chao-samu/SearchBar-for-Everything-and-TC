function Initialize()
    -- INCLUDE ================================================================= 
    
    dofile(SKIN:GetVariable('@')..'scripts\\_modules\\barHandler.lua')
    dofile(SKIN:GetVariable('@')..'scripts\\_modules\\ResponsiveHandler.lua')
    dofile(SKIN:GetVariable('@')..'scripts\\_modules\\storeHandler.lua')
    dofile(SKIN:GetVariable('@')..'scripts\\_modules\\misc.lua')

    -- MAIN ====================================================================
    do
        -- load actionHandler
        dofile(SKIN:GetVariable('@')..'scripts\\_modules\\actionHandler.lua')
        -- load config
        dofile(SKIN:MakePathAbsolute('SearchBar.cfg.lua'))
        -- load store
        aSBar = readStoreCfg(savesettings)
        
        -- global plugin functions
        fplugin = {}

        -- global plugin table, hold's information of current activated plugin
        current = {
            name = '',
            size = '',
            icon = '',
            field1 = {},
            field2 = {},
            text = '',
            field1_cmd = {},
            field2_cmd = {},
            cmd = '',
            additional  = {}
        }
        
        aSBar = resetBarIfOutOfRange(plugins, aSBar)
        
        loadPlugins(plugins)
        setResponsiveSize(current)
        current, cF1, cF2 = callPlugin(plugins, fplugin, current, cF1, cF2)

        SKIN:Bang('[!Update][!Redraw]')
    end
end

function Update()
   -- pass
end