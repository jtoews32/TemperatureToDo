//
//  LuaManager.swift
//  DecTree
//
//  Created by Jon Toews on 7/25/15.
//  Copyright (c) 2015 Jon Toews. All rights reserved.
//
import Foundation

typealias EvalResult = (code: Int32, results: [String])

class LuaManager {
    let state: COpaquePointer
    
    init() {
        state = luaL_newstate()
        luaL_openlibs(state)
        lua_settop(state, 0)
    }
    
    deinit {
        lua_close(state)
    }
    
    class func get () -> LuaManager {
        return LuaManager()
    }
    
    func registerFunction( function:lua_CFunction, name:String ) {
        let L: COpaquePointer = self.state
        lua_pushcclosure(L, function, 0)
        lua_setglobal(L, name)
    }
    
    /*
    func registerFunction(function: lua_CFunction, name:String?) {
        lua_pushcclosure(self.state, function, 0)
        lua_setglobal(self.state, name! )
    }
    */
    
    
    // Works
    func runCodeFromString(script: String) -> EvalResult {
        let L: COpaquePointer = self.state
        
        var results: [String] = []
        
        lua_settop(L, 0)

        var error = luaL_loadstring(L, script)
        if error != LUA_OK
        {
           
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            
            
           
            if let errmsg = msg
            {
                NSLog(errmsg);
            }
            
            
            return (error, results)
        }

        error = lua_pcallk(L, 0, LUA_MULTRET, 0, 0, nil)
        if error != LUA_OK
        {
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            
            
            
            if let errmsg = msg
            {
                NSLog(errmsg);
            }
            
            return (error, results)
        }
        
        
        return (LUA_OK, results)
    }
    
        
    // Isn't necessary .. Probably does exactly what the script before it does
    
    func runCodeFromStringWithResult(script: String) -> EvalResult
    {
        let L: COpaquePointer = self.state
        
        
        var results: [String] = []
        
        lua_settop(L, 0)
        
        
        var err = luaL_loadstring(L, script)
        if err != LUA_OK
        {
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            
            if let errmsg = msg
            {
                results.append(errmsg)
            }
            
            return (err, results)
        }
        
        
        err = lua_pcallk(L, 0, LUA_MULTRET, 0, 0, nil)
        if err != LUA_OK
        {
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            
            if let errmsg = msg
            {
                results.append(errmsg)
            }
            
            return (err, results)
        }
        
        
        let nresults = lua_gettop(L)
        if nresults != 0
        {
            for var i = nresults; i > 0; i--
            {
                let msg = String(UTF8String: lua_tolstring(L, -1 * i, nil))
                
                if let errmsg = msg
                {
                    results.append(errmsg)
                }
            }
            
            lua_settop(L, -(nresults)-1) // can't use lua_pop since it's a #define
        }
        
        
        return (LUA_OK, results)
    }
    
    
    func runCodeFromFileWithPath(path: String) -> EvalResult {
        let L: COpaquePointer = self.state
        
        var results: [String] = []
        
        lua_settop(L, 0)
        
        
        let error = luaL_loadfilex(L,path, nil)
        
        if error != LUA_OK {
            
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            
            if let errmsg = msg
            {
                NSLog(errmsg)
            }
            
            return (error, results)
        }
        
        return (LUA_OK, results)
    }

/*
    func evaluate(script: String) -> EvalResult
    {
        var results: [String] = []
        
        lua_settop(L, 0)
        
        
        var err = luaL_loadstring(L, script)
        if err != LUA_OK
        {
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            
            if let errmsg = msg
            {
                results.append(errmsg)
            }
            
            return (err, results)
        }
        
        
        err = lua_pcallk(L, 0, LUA_MULTRET, 0, 0, nil)
        if err != LUA_OK
        {
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            
            if let errmsg = msg
            {
                results.append(errmsg)
            }
            
            return (err, results)
        }
        
        
        let nresults = lua_gettop(L)
        if nresults != 0
        {
            for var i = nresults; i > 0; i--
            {
                let msg = String(UTF8String: lua_tolstring(L, -1 * i, nil))
                
                if let errmsg = msg
                {
                    results.append(errmsg)
                }
            }
            
            lua_settop(L, -(nresults)-1) // can't use lua_pop since it's a #define
        }
        
        
        return (LUA_OK, results)
    }
    */
    
    
    /*
    
    func callFunctionNamed(name: String) {
        let L: COpaquePointer = self.state
        
        lua_getglobal(L, name )
        
        var error = lua_pcallk(L, 0, LUA_MULTRET, 0, 0, nil)
        if error != LUA_OK
        {
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            
            if let errmsg = msg
            {
                //  results.append(errmsg)
            }
            
            return; // (error, results)
        }
    }
    
    
    
    func callFunctionNamed(name: String, object: COpaquePointer) {
        let L: COpaquePointer = self.state
        
        lua_getglobal(L, name )
        
        /*
        if object    [  object isKindOfClass:[UIViewController class]]) {
            lua_pushlightuserdata(L, (__bridge void*)(object));
        } else {
            writeIntoLua(object, nil, L);
        }
        
        */
        
        
        var error = lua_pcallk(L, 1, LUA_MULTRET, 0, 0, nil)
        if error != LUA_OK
        {
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            
            if let errmsg = msg
            {
                //  results.append(errmsg)
            }
            
            return; // (error, results)
        }
        
        
        
        */
        
      
}


