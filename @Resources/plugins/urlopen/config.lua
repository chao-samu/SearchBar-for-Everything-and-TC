if not urlopen then
urlopen = {
name = 'urlopen',
size = 2,
icon = SKIN:GetVariable('@')..'plugins\\urlopen\\icon\\png\\',
field1 = {''},
field2 = {''},
text = 'Enter URL',
field1_cmd = {''},
field2_cmd = {''},
cmd = 'http://',
additional = {''}
}
end

fplugin.urlopen_init = function(current)

    current = deepcopy(urlopen)

    return current
    
end

fplugin.urlopen_cmd = function(current, UserInput)

        if string.find(UserInput, '^https://') then
            SKIN:Bang('['..UserInput..']')
        elseif string.find(UserInput, '^http://') then 
            SKIN:Bang('["'..UserInput..'"]')
        else
            SKIN:Bang('["http://'..UserInput..'"]')
        end
 
end

fplugin.urlopen_terminate = function()
    
end