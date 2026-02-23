-- CONFIGURAÇÕES
local WebhookURL = "https://discord.com/api/webhooks/1475292276417630359/-xKkhddbWRobqhwCkNq-paApzVrW8lOoI1YAL4IZN1pIHQYw6OGa9fsTOP4eJFj34rZm"
local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- LISTA DE PERMISSÃO
local Whitelist = {
    "yuliaNO9900",
    "jubileu9973",
    "lucazmainzz",
    "BunnyStarmar
}

-- FUNÇÃO DE LOG (Adaptada para Executores)
local function SendDiscordLog(allowed)
    local status = allowed and "Acess Granted" or "NOT WHITELISTED"
    local color = allowed and 65280 or 16711680
    
    local headers = {["Content-Type"] = "application/json"}
    local data = {
        ["embeds"] = {{
            ["title"] = "Log Execution",
            ["color"] = color,
            ["fields"] = {
                {["name"] = "Player", ["value"] = LP.Name .. " (" .. LP.UserId .. ")", ["inline"] = true},
                {["name"] = "Status", ["value"] = status, ["inline"] = true},
                {["name"] = "Jogo", ["value"] = "ID: " .. game.PlaceId, ["inline"] = false}
            }
        }}
    }

    -- Tenta usar os métodos de executor (request) que são mais garantidos
    local requestFunc = syn and syn.request or http_request or request or (http and http.request)
    if requestFunc then
        requestFunc({
            Url = WebhookURL,
            Method = "POST",
            Headers = headers,
            Body = game:GetService("HttpService"):JSONEncode(data)
        })
    end
end

-- VERIFICAÇÃO
local authenticated = false
for _, name in pairs(Whitelist) do
    if LP.Name == name then
        authenticated = true
        break
    end
end

if authenticated then
    SendDiscordLog(true)
    print("Whitelist Sucessful, loading script.")
    
    -- === COLOQUE O SEU SCRIPT PRINCIPAL ABAIXO DESTA LINHA ===
    print("loadstring(game:HttpGet("https://raw.githubusercontent.com/nitherhub-dotcom/nitherhub/refs/heads/main/nither.txt"))()"))()
    
    -- Exemplo: 
    
else
    SendDiscordLog(false)
    LP:Kick("You do not have permission to use this script.")
end
