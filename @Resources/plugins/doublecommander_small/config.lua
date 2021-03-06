if not doublecommander_small then 
doublecommander_small = {
name = 'doublecommander_small',
size = 2,
icon = SKIN:GetVariable('@')..'plugins\\doublecommander_small\\icon\\png\\',
field1 = drives,
field2 = { 'ALL' , 'FOLDER', 'FILE' },
text = 'Search Double Commander',
field1_cmd = {},
field2_cmd = {'-A', '-V', '-F' },
cmd = SKIN:GetVariable('@')..'plugins\\doublecommander_small\\helper\\DC-search-rainmeter.ahk',
additional  = {SKIN:ReplaceVariables('C:\\Program Files\\Double Commander\\doublecmd.exe')}
}
end

fplugin.doublecommander_small_init = function(current)
    current = deepcopy(doublecommander_small)
    current = doublecommander_drive(current)

    return current
end

fplugin.doublecommander_small_cmd = function(current, UserInput)
    SKIN:Bang('["' .. current.cmd .. '" "' .. current.additional[1] .. '" "' .. current.field2_cmd[1] .. '" "'.. current.field1_cmd[1] .. '" "' .. UserInput .. '"]')
end

fplugin.doublecommander_small_terminate = function()

end

function doublecommander_small_drive(current)

    current.field1_cmd[1] = ""
    for k, _ in ipairs(current.field1) do
        if k>1 then
            current.field1_cmd[1] = current.field1_cmd[1] .. current.field1[k] .. ';'
        end
    end
    current.field1_cmd[1] = current.field1_cmd[1]:sub(1, -2)..'\\'
    for k, _ in ipairs(current.field1) do
        if k>1 then
            current.field1_cmd[k] = current.field1[k] .. '\\'
        end
    end

    return current

end