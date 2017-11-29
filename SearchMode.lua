function Initialize()
    -- DEVELOPER NOTES =========================================================

    --[[
    ]]--

    -- INCLUDE =================================================================

    -- insert cfg file variables
    dofile(SKIN:MakePathAbsolute('SearchBar.cfg'))

    -- PREPARE VARIABLES =======================================================

    -- get array size
    maxIndexDrive = iterate(drive)
    maxIndexSScope = iterate(sScope)

    -- "Everything" drive letters
    driveEverything = {}
    driveEverything[1] = ""
    for t, _ in ipairs(drive) do
        if t>1 then
        driveEverything[t] = drive[t]
        end
    end

    -- "Total Commander" drive letters
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

    -- SET SKIN SIZE WITH "SIZE" VARIABLE ======================================

    -- get size
    SearchBar_Size = SKIN:GetVariable('Size')
    SearchBar_Size = SearchBar_Size/100

    -- set Variables (SearchBar_MyModifiers1)
    local SearchBar_MyModifiers1 = SKIN:GetVariable('MyModifiers1')

    SearchBar_MyModifiers1_StrokeWidth = string.match(SearchBar_MyModifiers1, '.-StrokeWidth%s*(%d+)')
    SearchBar_MyModifiers1_StrokeWidth = SearchBar_MyModifiers1_StrokeWidth * SearchBar_Size
    SearchBar_MyModifiers1 = string.gsub(SearchBar_MyModifiers1, 'StrokeWidth.-|' ,
    'StrokeWidth ' .. SearchBar_MyModifiers1_StrokeWidth .. ' |', 1)

    SKIN:Bang('!SetVariable "MyModifiers1" "' .. SearchBar_MyModifiers1 .. '"')

    -- set Plugin_InputText
    local Plugin_InputText = SKIN:GetMeasure('Plugin_InputText')
    Plugin_InputText_X = Plugin_InputText:GetNumberOption('X')
    Plugin_InputText_Y = Plugin_InputText:GetNumberOption('Y')
    Plugin_InputText_W = Plugin_InputText:GetNumberOption('W')
    Plugin_InputText_H = Plugin_InputText:GetNumberOption('H')
    Plugin_InputText_FontSize = Plugin_InputText:GetNumberOption('FontSize')
    -- Note MEASURE "Input Plugin" cannot handle even pixel inch (tested in rainmeter v4.0)
    Plugin_InputText_X = math.floor((Plugin_InputText_X * SearchBar_Size)+0.5)
    Plugin_InputText_Y = math.floor((Plugin_InputText_Y * SearchBar_Size)+0.5)
    Plugin_InputText_W = math.floor((Plugin_InputText_W * SearchBar_Size)+0.5)
    Plugin_InputText_H = math.floor((Plugin_InputText_H * SearchBar_Size)+0.5)
    Plugin_InputText_FontSize = Plugin_InputText_FontSize * SearchBar_Size

    SKIN:Bang('!SetOption "Plugin_InputText" "X" " ' .. Plugin_InputText_X .. '"')
    SKIN:Bang('!SetOption "Plugin_InputText" "Y" " ' .. Plugin_InputText_Y .. '"')
    SKIN:Bang('!SetOption "Plugin_InputText" "W" " ' .. Plugin_InputText_W .. '"')
    SKIN:Bang('!SetOption "Plugin_InputText" "H" " ' .. Plugin_InputText_H .. '"')
    SKIN:Bang('!SetOption "Plugin_InputText" "FontSize" " ' .. Plugin_InputText_FontSize .. '"')

    -- set Background_SearchMode
    l_object_Position = GetMeterPosition('Background_SearchMode')
    l_object_Size = GetMeterShapeSize('Background_SearchMode')
    SetSizetoObject(l_object_Position)
    SetSizetoObject(l_object_Size)
    SetMeterPosition('Background_SearchMode', l_object_Position)
    SetMeterShapeSize('Background_SearchMode', l_object_Size)
    -- set Background_Drive
    l_object_Position = GetMeterPosition('Background_Drive')
    l_object_Size = GetMeterShapeSize('Background_Drive')
    SetSizetoObject(l_object_Position)
    SetSizetoObject(l_object_Size)
    SetMeterPosition('Background_Drive', l_object_Position)
    SetMeterShapeSize('Background_Drive', l_object_Size)
    -- set Background_SearchScope
    l_object_Position = GetMeterPosition('Background_SearchScope')
    l_object_Size = GetMeterShapeSize('Background_SearchScope')
    SetSizetoObject(l_object_Position)
    SetSizetoObject(l_object_Size)
    SetMeterPosition('Background_SearchScope', l_object_Position)
    SetMeterShapeSize('Background_SearchScope', l_object_Size)
    -- set Background_SearchBar
    l_object_Position = GetMeterPosition('Background_SearchBar')
    l_object_Size = GetMeterShapeSize('Background_SearchBar')
    SetSizetoObject(l_object_Position)
    SetSizetoObject(l_object_Size)
    SetMeterPosition('Background_SearchBar', l_object_Position)
    SetMeterShapeSize('Background_SearchBar', l_object_Size)

    -- set Icon_SearchMode
    local Icon_SearchMode = SKIN:GetMeter('Icon_SearchMode')
    Icon_SearchMode_X = Icon_SearchMode:GetX()
    Icon_SearchMode_Y = Icon_SearchMode:GetY()
    Icon_SearchMode_W = Icon_SearchMode:GetW()
    Icon_SearchMode_H = Icon_SearchMode:GetH()

    Icon_SearchMode_X = Icon_SearchMode_X * SearchBar_Size
    Icon_SearchMode_Y = Icon_SearchMode_Y * SearchBar_Size
    Icon_SearchMode_W = Icon_SearchMode_W * SearchBar_Size
    Icon_SearchMode_H = Icon_SearchMode_H * SearchBar_Size

    SKIN:Bang('!SetOption "Icon_SearchMode" "X" " ' .. Icon_SearchMode_X .. '"')
    SKIN:Bang('!SetOption "Icon_SearchMode" "Y" " ' .. Icon_SearchMode_Y .. '"')
    SKIN:Bang('!SetOption "Icon_SearchMode" "W" " ' .. Icon_SearchMode_W .. '"')
    SKIN:Bang('!SetOption "Icon_SearchMode" "H" " ' .. Icon_SearchMode_H .. '"')

    -- set icon Size
    if Icon_SearchMode_W <= 16 then
        ImageNameEverything = SKIN:ReplaceVariables('#@#images\\Everything\\16x16_Everything-1.4.1.877.x64-Setup.png')
        ImageNameTC = SKIN:ReplaceVariables('#@#images\\TC\\16x16_AppIcon6.png')
    elseif Icon_SearchMode_W <= 24 then
        ImageNameEverything = SKIN:ReplaceVariables('#@#images\\Everything\\24x24_Everything-1.4.1.877.x64-Setup.png')
        ImageNameTC = SKIN:ReplaceVariables('#@#images\\TC\\24x24_AppIcon6.png')
    elseif Icon_SearchMode_W <= 32 then
        ImageNameEverything = SKIN:ReplaceVariables('#@#images\\Everything\\32x32_Everything-1.4.1.877.x64-Setup.png')
        ImageNameTC = SKIN:ReplaceVariables('#@#images\\TC\\32x32_AppIcon6.png')
    elseif Icon_SearchMode_W <= 48 then
        ImageNameEverything = SKIN:ReplaceVariables('#@#images\\Everything\\48x48_Everything-1.4.1.877.x64-Setup.png')
        ImageNameTC = SKIN:ReplaceVariables('#@#images\\TC\\48x48_AppIcon6.png')
    else  --Icon_SearchMode_W > 48
        ImageNameEverything = SKIN:ReplaceVariables('#@#images\\Everything\\256x256_Everything-1.4.1.877.x64-Setup.png')
        ImageNameTC = SKIN:ReplaceVariables('#@#images\\TC\\48x48_AppIcon6.png')
    end

    -- set Text_Drive
    l_object_Position = GetMeterPosition('Text_Drive')
    l_object_Size = GetMeterSize('Text_Drive')
    l_FontSize = GetFontSize('Text_Drive')
    SetSizetoObject(l_object_Position)
    SetSizetoObject(l_object_Size)
    SetSizetoObject(l_FontSize)
    SetMeterPosition('Text_Drive', l_object_Position)
    SetMeterSize('Text_Drive', l_object_Size)
    SetFontSize('Text_Drive', l_FontSize)

    -- set Text_SearchScope
    l_object_Position = GetMeterPosition('Text_SearchScope')
    l_object_Size = GetMeterSize('Text_SearchScope')
    l_FontSize = GetFontSize('Text_SearchScope')
    SetSizetoObject(l_object_Position)
    SetSizetoObject(l_object_Size)
    SetSizetoObject(l_FontSize)
    SetMeterPosition('Text_SearchScope', l_object_Position)
    SetMeterSize('Text_SearchScope', l_object_Size)
    SetFontSize('Text_SearchScope', l_FontSize)

    -- set Text_SearchBar
    l_object_Position = GetMeterPosition('Text_SearchBar')
    l_object_Size = GetMeterSize('Text_SearchBar')
    l_FontSize = GetFontSize('Text_SearchBar')
    SetSizetoObject(l_object_Position)
    SetSizetoObject(l_object_Size)
    SetSizetoObject(l_FontSize)
    SetMeterPosition('Text_SearchBar', l_object_Position)
    SetMeterSize('Text_SearchBar', l_object_Size)
    SetFontSize('Text_SearchBar', l_FontSize)

   -- INIT SKIN SETTINGS =======================================================

    if count == 1 then
        SKIN:Bang('!SetOption Icon_SearchMode ImageName "' .. ImageNameTC .. '"')
        SKIN:Bang('!SetOption Text_SearchBar Text "Total Commander"')
    else
        count = 0
        SKIN:Bang('!SetOption Icon_SearchMode ImageName "' .. ImageNameEverything .. '"')
        SKIN:Bang('!SetOption Text_SearchBar Text "Everything"')
    end

    if count2 <= maxIndexDrive then
        SKIN:Bang('!SetOption Text_Drive Text "' .. drive[count2] .. '"')
    else
        count2 = 1
        SKIN:Bang('!SetOption Text_Drive Text "' .. drive[count2] .. '"')
    end

    if count3 <= maxIndexSScope then
        SKIN:Bang('!SetOption Text_SearchScope Text "' .. sScope[count3] .. '"')
    else
        count3 = 1
        SKIN:Bang('!SetOption Text_SearchScope Text "' .. sScope[count3] .. '"')
    end

    -- Update Skin =============================================================
    SKIN:Bang('[!Update][!Redraw]')

end

function Update()
   -- pass
end







-- FUNCTIONS: user action handling =============================================

function UserInput()

    MyMeasure = SKIN:GetMeasure('Plugin_InputText')
    local UserInput = MyMeasure:GetStringValue()
    if count == 1 then
        SKIN:Bang('["' .. PathTCScript .. '" "' .. PathTC .. '" "' .. sScopeTC[count3] .. '" "'.. driveTC[count2] .. '" "' .. UserInput .. '"]')
        SKIN:Bang('!SetOption Text_SearchBar Text "Total Commander"')
    else
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
        SKIN:Bang('!SetOption Text_SearchBar Text "Everything"')
    end

    SKIN:Bang('[!UpdateMeter Text_SearchBar][!Redraw]')

end

-- ToDo: fix range
function Icon_SearchMode()

    count = count + 1

    if count == 1 then
        SKIN:Bang('!SetOption Icon_SearchMode ImageName "' .. ImageNameTC .. '"')
        SKIN:Bang('!SetOption Text_SearchBar Text "Total Commander"')
    else
        count = 0
        SKIN:Bang('!SetOption Icon_SearchMode ImageName "' .. ImageNameEverything .. '"')
        SKIN:Bang('!SetOption Text_SearchBar Text "Everything"')
    end

    SKIN:Bang('[!UpdateMeter Text_SearchBar][!UpdateMeter Icon_SearchMode][!Redraw]')

    saveLUAConfigVALUE()

end

function Text_Drive()

    count2 = count2 + 1

    if count2 <= maxIndexDrive then
        SKIN:Bang('!SetOption Text_Drive Text "' .. drive[count2] .. '"')
    else
        count2 = 1
        SKIN:Bang('!SetOption Text_Drive Text "' .. drive[count2] .. '"')
    end

    SKIN:Bang('[!UpdateMeter Text_Drive][!Redraw]')

    saveLUAConfigVALUE()

end

function Text_SearchScope()

    count3 = count3 + 1

    if count3 <= maxIndexSScope then
        SKIN:Bang('!SetOption Text_SearchScope Text "' .. sScope[count3] .. '"')
    else
        count3 = 1
        SKIN:Bang('!SetOption Text_SearchScope Text "' .. sScope[count3] .. '"')
    end

    SKIN:Bang('[!UpdateMeter Text_SearchScope][!Redraw]')

    saveLUAConfigVALUE()

end

function Text_SearchBar_Restore()

    if count == 1 then
        SKIN:Bang('!SetOption Text_SearchBar Text "Total Commander"')
    else
        SKIN:Bang('!SetOption Text_SearchBar Text "Everything"')
    end

    SKIN:Bang('[!UpdateMeter Text_SearchBar][!Redraw]')

end

function iterate(d_Object)

    local index = 0

    for _ in pairs(d_Object) do
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

-- FUNCTIONS: Size handling ====================================================

-- get Functions
function GetMeterPosition(MeterName)

    local MeterObject = SKIN:GetMeter(MeterName)
    local MeterObject_X = MeterObject:GetX()
    local MeterObject_Y = MeterObject:GetY()

    return { ['X'] = MeterObject_X, ['Y'] = MeterObject_Y}

end

function GetMeterSize(MeterName)

    local MeterObject = SKIN:GetMeter(MeterName)
    local MeterObject_W = MeterObject:GetW()
    local MeterObject_H = MeterObject:GetH()

    return {['W'] = MeterObject_W, ['H'] = MeterObject_H}

end

function GetMeterShapeSize(MeterName)

    local MeterObject = SKIN:GetMeter(MeterName)
    MeterObject_Shape = MeterObject:GetOption('Shape')
    local MeterObject_Shape_X = string.match(MeterObject_Shape, '%a+%s+(%d+),%d+,%d+,%d+')
    local MeterObject_Shape_Y = string.match(MeterObject_Shape, '%a+%s+%d+,(%d+),%d+,%d+')
    local MeterObject_Shape_W = string.match(MeterObject_Shape, '%a+%s+%d+,%d+,(%d+),%d+')
    local MeterObject_Shape_H = string.match(MeterObject_Shape, '%a+%s+%d+,%d+,%d+,(%d+)')

    return {['X'] = MeterObject_Shape_X, ['Y'] = MeterObject_Shape_Y, ['W'] = MeterObject_Shape_W, ['H'] = MeterObject_Shape_H}

end

function GetFontSize(MeterName)

    local MeterObject = SKIN:GetMeter(MeterName)
    MeterObject_FontSize = MeterObject:GetOption('InlineSetting2')
    MeterObject_FontSize = string.match(MeterObject_FontSize, 'Size%s*|%s*(%d+)')

    return {['FontSize'] = tonumber(MeterObject_FontSize)}

end

-- set Functions (global)
function SetSizetoObject(t_Object)
    -- needs global value "SearchBar_Size"
    for k, v in pairs(t_Object) do
        t_Object[k] = v * SearchBar_Size
    end

end

-- set Functions (local)
function SetMeterPosition(MeterName, t_MeterSize)

    SKIN:Bang('!SetOption "' .. MeterName .. '" "X" " ' .. t_MeterSize['X'] .. '"')
    SKIN:Bang('!SetOption "' .. MeterName .. '" "Y" " ' .. t_MeterSize['Y'] .. '"')

end

function SetMeterSize(MeterName, t_MeterSize)

    SKIN:Bang('!SetOption "' .. MeterName .. '" "W" " ' .. t_MeterSize['W'] .. '"')
    SKIN:Bang('!SetOption "' .. MeterName .. '" "H" " ' .. t_MeterSize['H'] .. '"')

end

function SetMeterShapeSize(MeterName, t_MeterShapeSize)

    MeterObject_Shape = string.gsub(MeterObject_Shape, '.-%s|' ,
    'Rectangle ' .. t_MeterShapeSize['X'] .. ',' .. t_MeterShapeSize['Y'] ..
    ',' .. t_MeterShapeSize['W'] .. ',' .. t_MeterShapeSize['H'] .. ' |', 1)

    SKIN:Bang('!SetOption "' .. MeterName .. '" "Shape" "' .. MeterObject_Shape .. '"')

end

function SetFontSize(MeterName, t_FontSize)

    MeterObject_FontSize = string.gsub(MeterObject_FontSize, '.*', 'Size | ' .. t_FontSize['FontSize'], 1)

    SKIN:Bang('!SetOption "' .. MeterName .. '" "InlineSetting2" " ' .. MeterObject_FontSize .. '"')

end