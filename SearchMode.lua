function Initialize()

    -- VARIABLES ===================================================================================
    
    -- insert cfg file variables
    dofile(SKIN:MakePathAbsolute('SearchBar.cfg'))

    -- PREPARE VARIABLES ===========================================================================
    
    -- get array size
    maxIndexDrive = iterate(drive)
    maxIndexSScope = iterate(sScope)

    --Everything drive letters
    driveEverything = {}
    driveEverything[1] = ""
    for t, _ in ipairs(drive) do
        if t>1 then
        driveEverything[t] = drive[t]
        end
    end

    --Total Commander drive letters
    driveTC = {}
    driveTC[1] = ""
    for t, _ in ipairs(drive) do
        if t>1 then
        driveTC[1] = driveTC[1] .. drive[t] .. ';'
        end
    end
    for t, v in ipairs(drive) do
        if t>1 then
        driveTC[t] = drive[t] .. '\\'
        end
    end

   -- INIT SKIN SETTINGS ===========================================================================
   
    if count % 2 == 0 then
        SKIN:Bang('!SetOption ProgrammICON ImageName "' .. ImageNameEverything .. '"')
        SKIN:Bang('!SetOption SearchBarText Text "Everything"')
    else
        SKIN:Bang('!SetOption ProgrammICON ImageName "' .. ImageNameTC .. '"')
        SKIN:Bang('!SetOption SearchBarText Text "Total Commander"')
    end     
   
    if count2 <= maxIndexDrive then
        SKIN:Bang('!SetOption DriveICON Text "' .. drive[count2] .. '"')
    else
        count2 = 1
        SKIN:Bang('!SetOption DriveICON Text "' .. drive[count2] .. '"')
    end
    
    if count3 <= maxIndexSScope then
        SKIN:Bang('!SetOption SearchScopeICON Text "' .. sScope[count3] .. '"')
    else
        count3 = 1
        SKIN:Bang('!SetOption SearchScopeICON Text "' .. sScope[count3] .. '"')
    end

    SKIN:Bang('[!UpdateMeter SearchBarText][!UpdateMeter ProgrammICON][!UpdateMeter DriveICON][!UpdateMeter SearchScopeICON][!Redraw]')
    
end

function Update()
   -- pass
end

function UserInput()

    MyMeasure = SKIN:GetMeasure('InputText')
    local UserInput = MyMeasure:GetStringValue()
    if count % 2 == 0 then
        if count2 == 1 or count3 == 1 then
            if count2 == 1 and count3 == 1 then
            SKIN:Bang('["' .. PathEverything .. '" -s "' .. UserInput .. '"]')
            elseif count2 == 1 then
            SKIN:Bang('["' .. PathEverything .. '" -s "' .. sScopeEverything[count3] .. ' ' .. UserInput .. '"]')  
            else --count3 == 1
            SKIN:Bang('["' .. PathEverything .. '" -s "' .. driveEverything[count2] .. ' ' .. UserInput .. '"]')  
            end
        else
        SKIN:Bang('["' .. PathEverything .. '" -s "' .. sScopeEverything[count3] .. ' '.. driveEverything[count2] .. ' ' .. UserInput .. '"]')       
        end
        SKIN:Bang('!SetOption SearchBarText Text "Everything"')
    else
        SKIN:Bang('["' .. PathTCScript .. '" "' .. PathTC .. '" "' .. sScopeTC[count3] .. '" "'.. driveTC[count2] .. '" "' .. UserInput .. '"]')
        SKIN:Bang('!SetOption SearchBarText Text "Total Commander"')
    end

    SKIN:Bang('[!UpdateMeter SearchBarText][!Redraw]')

end

function ProgrammICON()
    
    count = count + 1
    
    if count % 2 == 0 then
        SKIN:Bang('!SetOption ProgrammICON ImageName "' .. ImageNameEverything .. '"')
        SKIN:Bang('!SetOption SearchBarText Text "Everything"')
    else
        SKIN:Bang('!SetOption ProgrammICON ImageName "' .. ImageNameTC .. '"')
        SKIN:Bang('!SetOption SearchBarText Text "Total Commander"')
    end    

    SKIN:Bang('[!UpdateMeter SearchBarText][!UpdateMeter ProgrammICON][!Redraw]')
    
    saveLUAConfigVALUE()

end

function DriveICON()
       
    count2 = count2 + 1
    
    if count2 <= maxIndexDrive then
        SKIN:Bang('!SetOption DriveICON Text "' .. drive[count2] .. '"')
    else
        count2 = 1
        SKIN:Bang('!SetOption DriveICON Text "' .. drive[count2] .. '"')
    end

    SKIN:Bang('[!UpdateMeter DriveICON][!Redraw]')
    
    saveLUAConfigVALUE()      
    
end

function SearchScopeICON()
   
    count3 = count3 + 1

    if count3 <= maxIndexSScope then
        SKIN:Bang('!SetOption SearchScopeICON Text "' .. sScope[count3] .. '"')
    else
        count3 = 1
        SKIN:Bang('!SetOption SearchScopeICON Text "' .. sScope[count3] .. '"')
    end

    SKIN:Bang('[!UpdateMeter SearchScopeICON][!Redraw]')
    
    saveLUAConfigVALUE()

end

function SearchBarTextRestore()

    if count % 2 == 0 then
        SKIN:Bang('!SetOption SearchBarText Text "Everything"')
    else
        SKIN:Bang('!SetOption SearchBarText Text "Total Commander"')
    end

    SKIN:Bang('[!UpdateMeter SearchBarText][!Redraw]')  

end

function iterate(drive)

    local index = 0

    for _ in pairs(drive) do
        index = index + 1
    end

    return index

end

function saveLUAConfigVALUE()
    
    if savesettings == false then
        return
    end
    
    local fp = io.open( SKIN:MakePathAbsolute('SearchBar.cfg'), "r+" )
    local content = fp:read("*all")
    fp:seek('set')
    
    content = string.gsub(content, "count%s*=%s*%d*", "count = " .. count)
    content = string.gsub(content, "count2%s*=%s*%d*", "count2 = " .. count2)
    content = string.gsub(content, "count3%s*=%s*%d*", "count3 = " .. count3)
    

    fp:write(content)
    fp:close()

end