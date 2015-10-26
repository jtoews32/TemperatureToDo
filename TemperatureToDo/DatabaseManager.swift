//
//  DatabaseManager.swift
//  DecTree
//
//  Created by Jon Toews on 10/14/15.
//  Copyright © 2015 Jon Toews. All rights reserved.
//
import Foundation

struct Todo {
    var id:Int32?
    var description:String?
    var location:String?
    var complete:Int32?
    var temperature:Double?
}

class DatabaseManager {
    var databasePath:String?
    
    static let instance = DatabaseManager()
    
    class func get() ->  (DatabaseManager) {
        return instance
    }
    
    init() {
        let filemgr = NSFileManager.defaultManager()
        let dirPaths =
        NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
            .UserDomainMask, true)
        
        let directoryURL:NSURL = NSURL(fileURLWithPath: dirPaths[0])
        let path:NSURL = NSURL(string: "contacts.db", relativeToURL: directoryURL)!
        
        databasePath = path.absoluteString
        
        if !filemgr.fileExistsAtPath((databasePath as String?)!) {
            let todoDB = FMDatabase(path: databasePath as String?)
            
            if todoDB == nil {
                print ("Error: \(todoDB.lastErrorMessage())")
            }
            
            if todoDB.open() {
                let sql_stmt1 = "CREATE TABLE IF NOT EXISTS TODO (ID INTEGER PRIMARY KEY AUTOINCREMENT, DESCRIPTION TEXT, LOCATION TEXT, COMPLETE INTEGER, TEMPERATURE DOUBLE)"
                if !todoDB.executeStatements(sql_stmt1) {
                    print ("Error: \(todoDB.lastErrorMessage())")
                }
                
                todoDB.close()
            } else {
                print ("Error: \(todoDB.lastErrorMessage())")
            }
        }
    }
    
    func createTodo(description:String, _ location:String, _ complete:Int, _ temperature:Double ) {
        let todoDB = FMDatabase(path: databasePath as String?)
        
        if todoDB.open() {
            let insertSQL = "INSERT INTO TODO (description, location, complete, temperature) VALUES (\"\(description)\", \"\(location)\", \(complete), \(temperature) )"
            let result = todoDB.executeUpdate(insertSQL, withArgumentsInArray: nil)
            
            if !result {
                print ("Error: \(todoDB.lastErrorMessage())")
            }
        } else {
            print("Error: \(todoDB.lastErrorMessage())")
        }
    }
    
    func allTodos() -> [Todo] {
        var todos:[Todo]? = []
        let todoDB = FMDatabase(path: databasePath as String?)
        
        if todoDB.open() {
            let querySQL = "SELECT id, description, location, complete, temperature FROM TODO order by temperature DESC"
            let results:FMResultSet? = todoDB.executeQuery(querySQL, withArgumentsInArray: nil)

            while results?.next() == true {
                var next = Todo()
                
                next.id = results?.intForColumn("id")
                next.location = results?.stringForColumn("location")
                next.description = results?.stringForColumn("description")
                next.complete = results?.intForColumn("complete")
                next.temperature = results?.doubleForColumn("temperature")
                
                todos?.append( next )
            }
            todoDB.close()
        } else {
            // println("Error: \(contactDB.lastErrorMessage())")
        }
        
        return todos!
    }
    
    func updateTodoTemperature(_ id:Int32, _ temperature:Double ) {
        let todoDB = FMDatabase(path: databasePath as String?)
        if todoDB.open() {
            let insertSQL = "update todo set temperature = \(temperature) where id = \(id)"
            let result = todoDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
            }
        } else {
            print("Error: \(todoDB.lastErrorMessage())")
        }
    }
    
    func updateTodoCheckmark(_ id:Int, _ complete:Int ) {
        let todoDB = FMDatabase(path: databasePath as String?)
        if todoDB.open() {
            let insertSQL = "update todo set complete = \(complete) where id = \(id)"
            let result = todoDB.executeUpdate(insertSQL,
                withArgumentsInArray: nil)
            
            if !result {
            }
        } else {
            print("Error: \(todoDB.lastErrorMessage())")
        }
    }
    
    func allTodosByStatus(completed:Int) -> [Todo] {
        var todos:[Todo]? = []
        let todoDB = FMDatabase(path: databasePath as String?)
        
        if todoDB.open() {
            let querySQL = "SELECT id, description, location, complete, temperature FROM TODO where complete = \(completed) order by temperature DESC"
            let results:FMResultSet? = todoDB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                var next = Todo()
                
                next.id = results?.intForColumn("id")
                next.location = results?.stringForColumn("location")
                next.description = results?.stringForColumn("description")
                next.complete = results?.intForColumn("complete")
                next.temperature = results?.doubleForColumn("temperature")
                
                todos?.append( next )
            }
            todoDB.close()
        } else {
            // println("Error: \(contactDB.lastErrorMessage())")
        }
        return todos!
    }
    
    func findTodo(id:Int) -> Todo? {
        let todoDB = FMDatabase(path: databasePath as String?)
        
        if todoDB.open() {
            let querySQL = "SELECT id, description, location, complete, temperature FROM TODO where id = \(id)"
            let results:FMResultSet? = todoDB.executeQuery(querySQL, withArgumentsInArray: nil)
            
            while results?.next() == true {
                var next = Todo()
                
                next.id = results?.intForColumn("id")
                next.location = results?.stringForColumn("location")
                next.description = results?.stringForColumn("description")
                next.complete = results?.intForColumn("complete")
                next.temperature = results?.doubleForColumn("temperature")
                
                todoDB.close()
                
                return next
            }
           todoDB.close()
        } else {
            // println("Error: \(contactDB.lastErrorMessage())")
        }
        
        return nil
    }
}