-- LuaRocks configuration

rocks_trees = {
   { name = "user", root = home .. "/.luarocks" };
   { name = "system", root = "/usr/local" };
}
lua_interpreter = "lua5.4";
variables = {
   LUA_DIR = "/usr/local";
   LUA_BINDIR = "/usr/local/bin";
}
