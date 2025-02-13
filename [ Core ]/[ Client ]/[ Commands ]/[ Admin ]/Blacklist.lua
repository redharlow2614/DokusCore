--------------------------------------------------------------------------------
---------------------------------- DokusCore -----------------------------------
--------------------------------------------------------------------------------
local Low = string.lower
local Sub = string.gsub
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RegisterCommand("blacklist", function(source, args, rawCommand)
  local IsForUsers, IsForAdmins, IsForOwners = false, false, false
  if (_Commands.Blacklist.Users) then IsForUsers = true end
  if (_Commands.Blacklist.Admins) then IsForAdmins = true end
  if (_Commands.Blacklist.SuperAdmins) then IsForOwners = true end

  -- Check if user is admin or superadmin
  local Group, Cmds, CMD, Lang = GetUserGroup(), {}, _Commands, _Language.Lang
  local Mod, IsUser, IsAdmin, IsOwner = _Moderation, true, true, true
  if (Group ~= Mod.User) then IsUser = false end
  if (Group ~= Mod.Admin) then IsAdmin = false end
  if (Group ~= Mod.SuperAdmin) then IsOwner = false end

  local Steam = TSC('DokusCore:Core:GetUserIDs', { 'user' })[1]

  -- Get the users language
  if _Language.Multi then
    local Data = TSC('DokusCore:Core:DBGet:Settings', { 'user', { Steam } })
    Lang = Data.Result[1].Language
  end

  local function DoThis()
    local _source, Admin = source, GetPlayerName(_source)
    local Type, CharID, Time, Reason = args[1], args[2], args[3], args[4]
    if (Type == nil) then ShowRightNote(_('Err_BLType', Lang)) Wait(3000) end
    if (Type == nil) then ShowRightNote(_('Usage_BL', Lang)) Wait(3000) return end
    if (Low(Type) == 'add') then
      if (CharID == nil) then ShowRightNote(_('Err_BLID', Lang)) Wait(3000) end
      if (CharID == nil) then ShowRightNote(_('Usage_BLAdd', Lang)) return end
      local iD = string.match(rawCommand, "%d+")
      if (iD == nil) then ShowRightNote(_('Err_DBIDNotANR', Lang)) return end
      if (Time == nil) then ShowRightNote(_('Err_BLTime', Lang)) return end
      if ((Reason == nil) or (Reason == '')) then ShowRightNote(_('Err_BLReason', Lang)) return end
      local Until = args[3] or -1
      Reason = string.gsub(rawCommand, "blacklist ", "_")
      Reason = string.gsub(Reason, args[1].." ", "_")
      Reason = string.gsub(Reason, args[2].." ", "_")
      Reason = string.gsub(Reason, Until.." ", "_")
      Reason = string.gsub(Reason, "-", "_")
      Reason = string.gsub(Reason, "_", "")
      local Data = TSC('DokusCore:Core:DBGet:Blacklist', { 'User', 'ServerID', { iD } } )
      if not (Data.Exist) then
        local Steam = TSC('DokusCore:Core:GetUserIDs', { 'user' })[1]
        if (Steam == nil) then ShowRightNote(_('BLNoUserWithID', Lang).." "..iD) return end
        local User = TSC('DokusCore:Core:DBGet:Users', { 'User', { Steam } })
        local X = User.Result[1]
        local Index = { Steam, X.IP, X.License, X.XBoxLive,  X.MLive }
        TSC('DokusCore:Core:DBIns:Blacklist', { Admin, Reason, Until, Index })
        ShowTopNote(_('BL', Lang), _('BLBannedUser', Lang))
        TSC('DokusCore:Core:KickPlayer', { CharID, Reason })
        ShowRightNote(_('BLSuccess', Lang))
      end
    end

    if (Low(Type) == 'remove') then
      local Type2 = args[2]
      if (Low(Type2) == 'ip') then
        if not (IsIpAddress(Time)) then ShowRightNote(_('Err_BLIP', Lang)) return end
        local Data = TSC('DokusCore:Core:DBGet:Blacklist', { 'User', 'IP', { Time } } )
        if not (Data.Exist) then ShowRightNote('This user is not on the blacklist!') return end
        if (Data.Exist) then
          local Data = TSC('DokusCore:Core:DBDel:Blacklist', { 'User', 'IP', { Time } } )
          ShowRightNote('User Removed from the blacklist')
        end
      end

      if (Low(Type2) == 'steamid') then
        local Data = TSC('DokusCore:Core:DBGet:Blacklist', { 'User', 'SteamID', { args[3] } } )
        if not (Data.Exist) then ShowRightNote('This user is not on the blacklist!') return end
        local Data = TSC('DokusCore:Core:DBDel:Blacklist', { 'User', 'SteamID', { args[3] } } )
        ShowRightNote('User Removed from the blacklist')
      end
    end
  end

  if IsForUsers  and IsUser  then DoThis() end
  if IsForAdmins and IsAdmin then DoThis() end
  if IsForOwners and IsOwner then DoThis() end
end, false)
