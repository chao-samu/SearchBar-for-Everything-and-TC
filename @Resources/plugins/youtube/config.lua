if not youtube then
youtube = {
name = 'youtube',
size = 2,
icon = SKIN:GetVariable('@')..'plugins\\youtube\\icon\\png\\',
field1 = {''},
field2 = {''},
text = 'Search Youtube',
field1_cmd = {''},
field2_cmd = {''},
cmd = 'https://www.youtube.com/results?search_query=',
additional = {''}
}
end

fplugin.youtube_init = function(current)

    current = deepcopy(youtube)

    return current
    
end

fplugin.youtube_cmd = function(current, UserInput)

    SKIN:Bang('["'..current.cmd..UserInput..'"]')
    
end

fplugin.youtube_terminate = function()
    
end