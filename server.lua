-- Malik™ Conversion --

local result2 = nil
local statusdog = nil

Citizen.CreateThread(function()

    TriggerEvent("vorp:getCharacter",source,function(user)
        local playerid = user.identifier
        exports.ghmattimysql:execute( "SELECT * FROM dogs WHERE identifier = @identifier", {['identifier'] = playerid}, function(result)
        if result[1] then 
           statusdog = result[1].dog
        end
           return false
        end)
        end)
        print(statusdog)
end)

local function GetAmmoutdogs( Player_ID )
    TriggerEvent("vorp:getCharacter",source,function(user)
    local playerid = user.identifier
    exports.ghmattimysql:execute( "SELECT * FROM dogs WHERE identifier = @identifier", {['identifier'] = playerid}, function(result)
    if result[1] then 
       statusdog = result[1].dog
    end
       return false
    end)
    end)
end

RegisterServerEvent('kcrp:buydog')
AddEventHandler( 'kcrp:buydog', function ( args )

    local _src   = source
    local _price = args['Price']
    local _model = args['Model']


	TriggerEvent("vorp:getCharacter",source,function(user)
        u_identifier = user.identifier
        u_money = user.money
        GetAmmoutdogs(u_identifier)
    end)


    if u_money <= _price then
        TriggerClientEvent( 'UI:DrawNotification', _src, Config.NoMoney )
        return
    end

    TriggerEvent("vorp:removeMoney", _src, 0, _price);


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

    local _src = source

	TriggerEvent("vorp:getCharacter",source,function(user)
        u_identifier = user.identifier
    end)

    local Parameters = { ['identifier'] = u_identifier }
    exports.ghmattimysql:execute( "SELECT * FROM dogs WHERE identifier = @identifier", Parameters, function(result)

    if result[1] then
        local dog = result[1].dog
        print(dog)
        TriggerClientEvent("kcrp:spawndog", _src, dog, false)
    end
end)
end )