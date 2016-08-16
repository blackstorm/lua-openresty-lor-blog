local utils = require("app.libs.utils")
local DB = require("app.libs.db")
local db = DB:new()

local post_model = {}

function post_model:test()
	return db:query("select * from post order by id desc")
end

function post_model:new(title, content)
	local now = utils.now()
	return db:query("insert into post(title, content, created) values(?,?,?)",
		{title, content, now})
end

function post_model:get(id)
	return db:query("select * from post where post.id = ?", {tonumber(id)})
end

return post_model
