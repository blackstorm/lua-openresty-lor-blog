local type = type
local pairs = pairs
local type = type
local mceil = math.ceil
local mfloor = math.floor
local mrandom = math.random
local mmodf = math.modf
local sgsub = string.gsub
local tinsert = table.insert
local date = require("app.libs.date")
local resty_sha256 = require "resty.sha256"
local str = require "resty.string"
local ngx_quote_sql_str = ngx.quote_sql_str

   

local _M = {}

function _M.encode(s)
    local sha256 = resty_sha256:new()
    sha256:update(s)
    local digest = sha256:final()
    return str.to_hex(digest)
end


function _M.clear_slash(s)
    s, _ = sgsub(s, "(/+)", "/")
    return s
end

function _M.is_table_empty(t)
    if t == nil or _G.next(t) == nil then
        return true
    else
        return false
    end
end

function _M.table_is_array(t)
    if type(t) ~= "table" then return false end
    local i = 0
    for _ in pairs(t) do
        i = i + 1
        if t[i] == nil then return false end
    end
    return true
end

function _M.mixin(a, b)
    if a and b then
        for k, v in pairs(b) do
            a[k] = b[k]
        end
    end
    return a
end

function _M.random()
    return mrandom(0, 1000)
end


function _M.total_page(total_count, page_size)
    local total_page = 0
    if total_count % page_size == 0 then
        total_page = total_count / page_size
    else
        local tmp, _ = mmodf(total_count/page_size)
        total_page = tmp + 1
    end

    return total_page
end


function _M.days_after_registry(req)
    local diff = 0
    local diff_days = 0 -- default value, days after registry

    if req and req.session then
        local user = req.session.get("user")
        local create_time = user.create_time
        if create_time then
            local now = date() -- seconds
            create_time = date(create_time)
            diff = date.diff(now, create_time):spandays()
            diff_days = mfloor(diff)
        end
    end

    return diff_days, diff
end

function _M.now()
    local n = date()
    local result = n:fmt("%Y-%m-%d %H:%M:%S")
    return result
end

function _M.secure_str(str)
    return ngx_quote_sql_str(str)
end


function _M.string_split(str, delimiter)
    if str==nil or str=='' or delimiter==nil then
        return nil
    end
    
    local result = {}
    for match in (str..delimiter):gmatch("(.-)"..delimiter) do
        tinsert(result, match)
    end
    return result
end

return _M
