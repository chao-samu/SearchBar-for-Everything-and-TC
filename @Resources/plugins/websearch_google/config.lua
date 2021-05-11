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

fplugin.websearch_google_init = function(current)

    current = deepcopy(websearch_google)
    
    return current
end

fplugin.websearch_google_cmd = function(current, UserInput)

    SKIN:Bang('["'..current.cmd..UserInput..'"]')
    
end

fplugin.websearch_google_terminate = function()

    
end