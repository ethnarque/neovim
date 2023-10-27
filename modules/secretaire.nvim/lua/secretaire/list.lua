---@class SecretaireList
--
---@type SecretaireList
local List = {}
List.__index = List

function List:new()
    self = setmetatable({}, List)
    return self
end

return List
