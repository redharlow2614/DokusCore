--------------------------------------------------------------------------------
---------------------------------- DokusCore -----------------------------------
--------------------------------------------------------------------------------
-- Callback relays to call server data via the server files.
--------------------------------------------------------------------------------
RCC('DokusCore:Core:DBGet:Users', function(args) return TSC('DokusCore:Core:DBGet:Users', args) end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RCC('DokusCore:Core:DBGet:Settings', function(args) return TSC('DokusCore:Core:DBGet:Settings', args) end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RCC('DokusCore:Core:DBGet:Banks', function(args) return TSC('DokusCore:Core:DBGet:Banks', args) end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RCC('DokusCore:Core:DBGet:Characters', function(args) return TSC('DokusCore:Core:DBGet:Characters', args) end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RCC('DokusCore:Core:DBGet:Whitelist', function(args) return TSC('DokusCore:Core:DBGet:Whitelist', args) end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RCC('DokusCore:Core:DBGet:Storages', function(args) return TSC('DokusCore:Core:DBGet:Storages', args) end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RCC('DokusCore:Core:DBGet:Inventory', function(args) return TSC('DokusCore:Core:DBGet:Inventory', args) end)
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------






























--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
