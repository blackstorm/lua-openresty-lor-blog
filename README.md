## 依赖

[OpenResty](http://openresty.org/cn/) 一个基于 Nginx 与Lua 的高性能 Web 平台

[Lor](https://github.com/sumory/lor) a fast, minimalist web framework for lua based on OpenResty

[如何使用LOR，并导入项目代码](https://github.com/sumory/lor#installation)

## 数据库MYSQL
表结构

```
+---------+------------------+------+-----+---------+----------------+
| Field   | Type             | Null | Key | Default | Extra          |
+---------+------------------+------+-----+---------+----------------+
| id      | int(11) unsigned | NO   | PRI | NULL    | auto_increment |
| title   | varchar(255)     | NO   |     |         |                |
| content | text             | NO   |     | NULL    |                |
| created | datetime         | NO   |     | NULL    |                |
+---------+------------------+------+-----+---------+----------------+
```

配置文件

lua-blog/config$ config.lua

```
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
    username = "sha256用户名",
    password = "sha256密码"
  }
}
```