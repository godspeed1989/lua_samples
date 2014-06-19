#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

lua_State* load_lua_src (const char *filename)
{
    lua_State *L = luaL_newstate();
    if (!L)
    {
        luaL_error(L, "bad alloc lua state\n");
    }
    /* opens all standard Lua libraries */
    luaL_openlibs(L);
    if (luaL_loadfile(L, filename) ||
        lua_pcall(L, 0, 0, 0))
    {
        luaL_error(L, "open %s error", filename);
    }
    return L;
}

void unload_lua_src (lua_State* L)
{
    lua_close(L);
}

static void stackDump(lua_State* L)
{
    int i, top = lua_gettop(L);
    for (i = 1; i <= top; i++)
    {
        int t = lua_type(L, i);
        printf("%d ", i);
        switch(t)
        {
            case LUA_TSTRING:
                printf("`%s'", lua_tostring(L, i)); break;
            case LUA_TNUMBER:
                printf("%g", lua_tonumber(L, i));   break;
            default:  /* other values */
                printf("%s", lua_typename(L, t));
        }
        printf("\n");
    }
}

static void get_global_var (lua_State* L)
{
    /* get global variable(s) */
    lua_getglobal(L, "width");
    lua_getglobal(L, "height");
    if (!lua_isnumber(L, -2))
        luaL_error(L, "`width' should be a number\n");
    if (!lua_isnumber(L, -1))
        luaL_error(L, "`height' should be a number\n");

    printf( "`width' is a %s: %d\n",
            lua_typename(L, lua_type(L, -2)),
            (int)lua_tonumber(L, -2) );
    printf( "`height' is a %s: %d\n",
            lua_typename(L, lua_type(L, -1)),
            (int)lua_tonumber(L, -1) );
    stackDump(L);
    lua_pop(L, 2);
}

static void call_global_func (lua_State* L)
{
    /* call global function */
    lua_getglobal(L, "func");   /* function to be called */
    lua_pushstring(L, "from_c");/* push 1st argument */
    lua_pushnumber(L, 3);       /* push 2nd argument */
    lua_pushnumber(L, 4);       /* push 3rd argument */

    /* do the call (3 arguments, 2 results) */
    if (lua_pcall(L, 3, 2, 0) != 0)
    {
        printf("call_global_func:\n");
        printf("%s\n", lua_tostring(L, -1));
    }

    /* retrieve result */
    if (!lua_isnumber(L, -2))
        luaL_error(L, "`func' must return a number\n");
    printf( "`func' return " LUA_NUMBER_FMT "\n",
            lua_tonumber(L, -2) );
    if (!lua_isstring(L, -1))
        luaL_error(L, "`func' must return a string\n");
    printf( "`func' return %s \n",
            lua_tostring(L, -1) );
    /* pop returned value */
    lua_pop(L, 2);
}

static void get_global_table (lua_State* L)
{
    lua_getglobal(L, "bg");
    if (!lua_istable(L, -1))
        luaL_error(L, "`bg' should be a table");
    /* table is on the stack top */

    lua_pushstring(L, "r");
    lua_gettable(L, -2);    /* get bg.r */
    if (!lua_isnumber(L, -1))
        luaL_error(L, "`bg.r' must be a number\n");
    printf( "`bg.r' = " LUA_NUMBER_FMT "\n",
        lua_tonumber(L, -1) );
    lua_pop(L, 1);  /* remove bg.r */

    lua_pushnumber(L, 1);
    lua_gettable(L, -2);    /* get bg[1] */
    if (!lua_isnumber(L, -1))
        luaL_error(L, "`bg[1]' must be a number\n");
    printf( "`bg[1]' = " LUA_NUMBER_FMT "\n",
        lua_tonumber(L, -1) );
    lua_pop(L, 1);  /* remove bg[1] */

    lua_pushstring(L, "d");
    lua_gettable(L, -2);    /* get bg.d */
    if (!lua_istable(L, -1))
        luaL_error(L, "`bg.d' must be a table\n");
    lua_pushstring(L, "v");
    lua_gettable(L, -2);    /* get bg.d.v */
    if (!lua_isnumber(L, -1))
        luaL_error(L, "`bg.d.v' must be a number\n");
    printf( "`bg.d.v' = " LUA_NUMBER_FMT "\n",
        lua_tonumber(L, -1) );
    lua_pop(L, 1);  /* remove table bg.d.v */
    lua_pop(L, 1);  /* remove table bg.d */

    lua_pop(L, 1);  /* remove table bg */
}

int main (int argc, char *argv[])
{
    lua_State *L;
    L = load_lua_src(argv[1]);

    printf("----------------\n");
    get_global_var(L);
    printf("----------------\n");
    call_global_func(L);
    printf("----------------\n");
    get_global_table(L);

    unload_lua_src(L);
    return 0;
}
