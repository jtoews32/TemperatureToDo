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
    
    static var instance:LuaManager?
    
    class func get () -> LuaManager {
        if instance == nil {
            instance = LuaManager()
        }
        return instance!
    }
    
    func registerFunction( function:lua_CFunction, name:String ) {
        let L: COpaquePointer = self.state
        lua_pushcclosure(L, function, 0)
        lua_setglobal(L, name)
    }
    
    func createObject (luaIndex:Int32, L: COpaquePointer) -> AnyObject {
        let type = lua_type(L, luaIndex)
        var results = Dictionary<String, AnyObject>()
        var returnVal:AnyObject //= nil
        
        switch (type) {
        case LUA_TBOOLEAN:
            let retBool:Int32 =  lua_toboolean(L, luaIndex) // [NSNumber numberWithBool:lua_toboolean(L, luaIndex)];
            returnVal = retBool as! Bool
            
        case LUA_TSTRING:
            let retString:String! =  String(UTF8String: lua_tolstring(L, luaIndex, nil)) // lua_tolstring(L, luaIndex, nil)
            returnVal = (retString as? String)!
            
        case LUA_TNUMBER:
            returnVal = lua_tonumberx(L, luaIndex, nil)    // [NSNumber numberWithDouble:lua_tonumber(L, luaIndex)]
            
        case LUA_TTABLE:
            var top:Int32 = luaIndex
            if top < 0 {
                top = lua_gettop(L)
            }
            
            lua_pushnil(L)
            var convertToArray:Bool = false
            var largestArraySubscript:NSNumber = 1
            
            while lua_next(L, top) != 0 {
                let key:AnyObject! = createObject(-2, L:L)
                var stringKey:String = ""
                
                if( key is NSNumber ) {
                    convertToArray = true
                    let numKey = key as? NSNumber
                    stringKey = key.stringValue
                    
                    if (largestArraySubscript.integerValue < numKey?.integerValue) {
                        largestArraySubscript = numKey!
                    }
                    
                } else if (key is NSString) {
                    stringKey = key as! String
                }
                
                let value:AnyObject? = createObject(-1, L:L)
                
                results[stringKey] = value
                lua_settop(L, -2)
            }
            
            if (convertToArray) {
                var array = Array<AnyObject>()
                for i in 1...largestArraySubscript.integerValue {
                    let tempStr  = String(i)
                    let anyObject: AnyObject! = results[tempStr]
                    
                    if anyObject != nil {
                        array.append(anyObject)
                        
                    } else {
                        NSLog( "Warning, conversion of lua array to native array has collapsed a value at index %i", i);
                    }
                }
                returnVal = array
            } else {
                returnVal = results
            }
            
        default:
            NSLog("No Matches")
            returnVal = Dictionary<String, AnyObject>()
            
        }
        return returnVal
    }
    
    func runCodeFromString(script: String) -> EvalResult {
        let L: COpaquePointer = self.state
        var results: [String] = []
        
        lua_settop(L, 0)

        var error = luaL_loadstring(L, script)
        if error != LUA_OK {
           
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            if let errmsg = msg {
                NSLog(errmsg);
            }

            return (error, results)
        }

        error = lua_pcallk(L, 0, LUA_MULTRET, 0, 0, nil)
        
        if error != LUA_OK {
            let msg = String(UTF8String: lua_tolstring(L, -1, nil))
            if let errmsg = msg {
                NSLog(errmsg)
            }
            
            return (error, results)
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
            
            if let errmsg = msg {
                NSLog(errmsg)
            }
            
            return (error, results)
        }
        return (LUA_OK, results)
    }
}


