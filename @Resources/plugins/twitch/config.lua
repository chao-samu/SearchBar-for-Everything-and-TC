if not twitch then
twitch = {
name = 'twitch',
size = 2,
icon = SKIN:GetVariable('@')..'plugins\\twitch\\icon\\png\\',
field1 = {''},
field2 = {''},
text = 'Search Twitch',
field1_cmd = {''},
field2_cmd = {''},
cmd = 'https://www.twitch.tv/search?term=',
additional = {''}
}
end

fplugin.twitch_init = function(current)

    current = deepcopy(twitch)

    return current
    
end

fplugin.twitch_cmd = function(current, UserInput)

    SKIN:Bang('["'..current.cmd..UserInput..'"]')
    
end

fplugin.twitch_terminate = function()
    
end