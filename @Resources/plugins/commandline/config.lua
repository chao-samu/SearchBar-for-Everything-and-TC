if not commandline then
commandline = {
name = 'commandline',
size = 2,
icon = SKIN:GetVariable('@')..'plugins\\commandline\\icon\\png\\',
field1 = {''},
field2 = {''},
text = 'Enter cmd',
field1_cmd = {''},
field2_cmd = {''},
cmd = '',
additional = {''}
}
end

fplugin.commandline_init = function(current)

    current = deepcopy(commandline)

    return current
    
end

fplugin.commandline_cmd = function(current, UserInput)

            SKIN:Bang('['..UserInput..']')
 
end

fplugin.commandline_terminate = function()
    
end