#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>

static int add2(lua_State* L)
{
    double op1 = luaL_checknumber(L, 1);
    double op2 = luaL_checknumber(L, 2);
    printf("c\tadd2(%lf,%lf)\n", op1, op2);
    lua_pushnumber(L, op1 + op2);
    /* number of return(s) */
    return 1;
}

static int inc_array(lua_State* L)
{
    int i, n;
    luaL_checktype(L, 1, LUA_TTABLE);   /* t */
    luaL_checktype(L, 2, LUA_TFUNCTION);/* f */
    n = lua_rawlen(L, 1);
    for (i = 1; i <= n ; i++)
    {
        lua_pushvalue(L, 2);    /* push f */
        /* access is raw does not invoke meta-method */
        lua_rawgeti(L, 1, i);   /* push t[i] */
        printf("c\t(%lf)\n", luaL_checknumber(L, -1));
        lua_call(L, 1, 1);      /* call f(t[i]) */
        lua_rawseti(L, 1, i);   /* t[i] = f(t[i]) */
    }
    return 0;
}

static luaL_Reg mylib[] = {
    {"add2",        add2},
    {"inc_array",   inc_array},
    {NULL, NULL}
};

LUALIB_API
int luaopen_mylib(lua_State* L)
{
    printf("c\tmylib is open\n");
    luaL_newlib(L, mylib);
    return 1;
}
