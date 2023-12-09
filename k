  function HopServer()
            local Player = game.Players.LocalPlayer    
            local Http = game:GetService("HttpService")
            local TPS = game:GetService("TeleportService")
            local Api = "https://games.roblox.com/v1/games/"
            local _place,_id = game.PlaceId, game.JobId
            local _servers = Api.._place.."/servers/Public?sortOrder=Asc&limit=100"
            function ListServers(cursor)
               local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
               return Http:JSONDecode(Raw)
            end
    
            while true do 
               local Servers = ListServers()
               for i, server in ipairs(Servers.data) do
                  local args = {
                        [1] = "teleport",
                        [2] = server.id
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser"):InvokeServer(unpack(args))
                end
                wait(5)
            end
    end

    while _G.ServerHop do
        wait(0.05)
        ServerHop()
    end
