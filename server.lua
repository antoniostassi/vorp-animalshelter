-- Malik™ Conversion --
-- Neo Green Fixed Native Errors and Animal Relations, and Finished Conversion for VORP 2.0----

local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

local result2 = nil
local statusdog = nil

Citizen.CreateThread(function()
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter

   
    local playerid = Character.identifier
    exports.ghmattimysql:execute( "SELECT * FROM dogs WHERE identifier = @identifier", {['identifier'] = playerid}, function(result)
    if result[1] then 
        statusdog = result[1].dog
        end
        return false
    end)
    
        
end)

local function GetAmmoutdogs( Player_ID )
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local playerid = Character.identifier
    exports.ghmattimysql:execute( "SELECT * FROM dogs WHERE identifier = @identifier", {['identifier'] = playerid}, function(result)
    if result[1] then 
       statusdog = result[1].dog
    end
       return false
    end)
    
end

RegisterServerEvent('kcrp:sellpet')
AddEventHandler('kcrp:sellpet', function()
    TriggerEvent("vorp:getCharacter", source, function(user)
        local playerid = user.identifier
        local number = math.number(1, 100000)
        exports.ghmattimysql:execute("UPDATE dogs SET identifier = @nil WHERE identifier = @identifier", {["identifier"] = playerid, ["nil"] = number})
    end)

end)


RegisterServerEvent('kcrp:buydog')
AddEventHandler( 'kcrp:buydog', function ( args )
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local _src   = source
    local _price = args['Price']
    local _model = args['Model']


	
    u_identifier = Character.identifier
    u_money = Character.money
    GetAmmoutdogs(u_identifier)
    


    if u_money <= _price then
        TriggerClientEvent( 'UI:DrawNotification', _src, Config.NoMoney )
        return
    end

    Character.removeCurrency(0, _price)


    TriggerClientEvent('kcrp:spawndog', _src, _model, true)

    print(result)
    if statusdog == nil then
        local Parameters = { ['identifier'] = u_identifier, ['dog'] = _model }
        exports.ghmattimysql:execute("INSERT INTO dogs ( `identifier`,`dog` ) VALUES ( @identifier, @dog )", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, 'You bought a new pet' )
    elseif statusdog ~= nil then
        local Parameters = { ['identifier'] = u_identifier, ['dog'] = _model }
        exports.ghmattimysql:execute(" UPDATE dogs SET dog = @dog WHERE identifier = @identifier", Parameters)
        TriggerClientEvent( 'UI:DrawNotification', _src, 'You replaced your old pet' )
    end

end)

RegisterServerEvent( 'kcrp:loaddog' )
AddEventHandler( 'kcrp:loaddog', function ( )
    local User = VorpCore.getUser(source)
    local Character = User.getUsedCharacter
    local _src = source

	
    u_identifier = Character.identifier
    

    local Parameters = { ['identifier'] = u_identifier }
    exports.ghmattimysql:execute( "SELECT * FROM dogs WHERE identifier = @identifier", Parameters, function(result)

    if result[1] then
        local dog = result[1].dog
        print(dog)
        TriggerClientEvent("kcrp:spawndog", _src, dog, false)
    end
end)
end )