-- 业务路由管理
local post_model = require("app.models.post")
local utils = require("app.libs.utils")
local config = require("app.config.config")

return function(app)

    -- welcome to lor!
    app:get("/", function(req, res, next)
        local result = post_model:test()
        local data = {
            posts = result
        }
        res:render("index", data)
    end)

    -- hello world!
    app:get("/markdown", function(req, res, next)
        -- session validor
        local user = req.session.get("me")
        local name = user.username
        if not name then
            res:redirect("/login")
            return
        end
        res:render("markdown")
    end)

    -- new post
    app:post("/markdown", function(req, res, next)
        -- session validor
        local user = req.session.get("me")
        local name = user.username
        if not name then
            res:redirect("/login")
            return
        end

        local title = req.body.title
        local content = req.body.content
        -- post data is not
        if not title or not content or titile == "" or content == "" then
            local data = {
                message = "title or content is not"
            }
            res:render("markdown", data)
            return
        end
        -- insert 
        local result, err = post_model:new(title, content)

        -- insert is err
        if not result or err then
            local data = {
                message = "save post error"
            }
            res:render("markdown", data)
            return
        end
        -- save sucess
        res:redirect("/")
    end)

    -- get post
    app:get("/post/:id", function(req, res, next)
        local post_id = req.params.id
        if not post_id then
            res:redirect("/")
            return
        end

        local result, err = post_model:get(post_id)

        if not result or err or type(result) ~= "table" or #result ~= 1 then
            res:send("无法查找到该文章")
            return
        end
        local data = {
            post = result[1]
        }
        res:render("post", data)
    end)

    -- login get
    app:get("/login", function(req, res, next)
        res:render("login")
    end)


    -- login post
    app:post("/login", function(req, res, next)
        local username = req.body.name
        local password = req.body.password

        if not username or not password or username == "" or password == "" then
            local data = {
                message = "username or password is not"
            }
            res:render("login", data)
            return
        end
        -- username && password
        enuname =  utils.encode(username .. "#username" .. config.pwd_secret)
        enpassword = utils.encode(password .. "#password" .. config.pwd_secret)
        if enuname ~= config.auth.username or enpassword ~= config.auth.password then
            local data = {
                message = "username or password error"
            }
            res:render("login", data)
            return
        end

        -- save session
        req.session.set("me",{
            username = enuname
            })

        -- go index
        res:redirect("/")
    end)

    -- render html, visit "/view" or "/view?name=foo&desc=bar
    app:get("/about", function(req, res, next)
        res:render("about", data)
    end)
end

