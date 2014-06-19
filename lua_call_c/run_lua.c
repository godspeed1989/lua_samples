#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

#define filename "call_c.lua"

int main()
{
    lua_State* L = luaL_newstate();
    luaL_openlibs(L);
    if (luaL_loadfile(L, filename) ||
        lua_pcall(L, 0, 0, 0))
    {
        luaL_error(L, "%s", lua_tostring(L, -1));
    }
    lua_close(L);
    return 0;
}
