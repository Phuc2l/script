LinkHook = "https://discord.com/api/webhooks/1182959098027851847/tbReInRTSQiP4A7FUhYKd7cV3x_B3tuD8nlZLNbmlBSg__lbeeLMAiq-vYkhY1WqFW9L"

local Moon = {
['8'] = "http://www.roblox.com/asset/?id=9709149431", -- 🌕
['7'] = "http://www.roblox.com/asset/?id=9709149052", -- 🌖
['6'] = "http://www.roblox.com/asset/?id=9709143733", -- 🌗
['5'] = "http://www.roblox.com/asset/?id=9709150401", -- 🌘
['4'] = "http://www.roblox.com/asset/?id=9709135895", -- 🌑
['3'] = "http://www.roblox.com/asset/?id=9709139597", -- 🌒
['2'] = "http://www.roblox.com/asset/?id=9709150086", -- 🌓
['1'] = "http://www.roblox.com/asset/?id=9709149680", -- 🌔
};

    if game:GetService("Lighting").Sky.MoonTextureId == Moon['1'] then
        MoonIcon = '🌔'
    elseif game:GetService("Lighting").Sky.MoonTextureId == Moon['2'] then
        MoonIcon = '🌓'
    elseif game:GetService("Lighting").Sky.MoonTextureId == Moon['3'] then
        MoonIcon = '🌒'
    elseif game:GetService("Lighting").Sky.MoonTextureId == Moon['4'] then
        MoonIcon = '🌑'
    elseif game:GetService("Lighting").Sky.MoonTextureId == Moon['5'] then
        MoonIcon = '🌘'
    elseif game:GetService("Lighting").Sky.MoonTextureId == Moon['6'] then
        MoonIcon = '🌗'
    elseif game:GetService("Lighting").Sky.MoonTextureId == Moon['7'] then
        MoonIcon = '🌖'
    elseif game:GetService("Lighting").Sky.MoonTextureId == Moon['8'] then
        MoonIcon = '🌕'
    end

    for i,v in pairs(Moon) do
        if game:GetService("Lighting").Sky.MoonTextureId == v then
            MoonPercent = i / 8 * 100
        end
    end
    
    for i,v in pairs(game.Players:GetPlayers()) do
        PlayersMin = i
    end

    MoonMessage = '```'..tostring(MoonPercent..'%'..' : '..MoonIcon)..'```'
    CodeServer = 'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,'..'\''..tostring(game.JobId)..'\''..')'

		local Embed = {
			 ["username"] = "Full Moon Notify",
			 ["avatar_url"] = "https://play-lh.googleusercontent.com/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec",
			 ["embeds"] = {
				{
					["title"] = "**Full Moon Notify**",
					["color"] = tonumber(00000000),
					["type"] = "rich",
					["fields"] =  {
						{
							["name"] = "Players",
							["value"] = '```'..tostring(PlayersMin)..'/12```',
							["inline"] = false
						},
                        {
							["name"] = "Job Id",
							["value"] = '```'..tostring(game.JobId)..'```',
							["inline"] = false
                        },
                        {
							["name"] = "Code",
							["value"] = '```'..CodeServer..'```',
							["inline"] = true
                        },
                        {
							["name"] = "Moon",
							["value"] = ''..MoonMessage..'',
							["inline"] = true
                        }
					},
                    ["thumbnail"] = {
                    ["url"] = "https://moewalls.com/wp-content/uploads/2022/05/itachi-uchiha-full-moon-naruto-shippuden-thumb.jpg",
                    },
					["footer"] = {
						["text"] = os.date("%A".." // ".."%d".." ".."%B".." ".."%Y".." // ".."%X").." \104\116\116\112\115\58\47\47\100\105\115\99\111\114\100\46\103\103\47\110\88\110\97\81\68\87\74",
                        ["icon_url"] = "https://play-lh.googleusercontent.com/8ddL1kuoNUB5vUvgDVjYY3_6HwQcrg1K2fd_R8soD-e2QYj8fT9cfhfh3G0hnSruLKec"
                    }
				}
			},
		}
        local Data = game:GetService("HttpService"):JSONEncode(Embed)
		local Head = {["content-type"] = "application/json"}
		Send = http_request or request or HttpPost or syn.request
		local sendhook = {Url = LinkHook, Body = Data, Method = "POST", Headers = Head}
		Send(sendhook)

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

    _G.ServerHop = true

    while _G.ServerHop do
        wait(0.05)
        ServerHop()
    end
