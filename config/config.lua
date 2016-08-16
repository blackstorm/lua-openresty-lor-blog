return{
	page_config = {
		post_page_size = 10
	},
	-- 生成session的secret，请一定要修改此值为一复杂的字符串，用于加密session
	session_secret = "vMG94;WslOxfCL[tHoY,UqZ`+ndJhr=X",

	-- 用于存储密码的盐，请一定要修改此值, 一旦使用不能修改，用户也可自行实现其他密码方案
	pwd_secret = "_&e=wTXW",
	
	view_config = {
		engine = "tmpl",
		ext = "html",
		views = "./app/views"
	},
	-- mysql config
	mysql = {
		timeout = 5000,

		connect_config = {
			host = "127.0.0.1",
			port = 3306,
			database = "blog",
			user = "root",
			password = "root",
			max_packet_size = 1024 * 1024
		},

		pool_config = {
			max_idle_timeout = 20000, -- 20s
        		pool_size = 50 -- connection pool size
		}
	},
	auth = {
		username = "sha256",
		password = "sha256"
	}
}
