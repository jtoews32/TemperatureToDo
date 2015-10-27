     //
//  AppDelegate.swift
//  DecTree
//
//  Created by Jon Toews on 7/25/15.
//  Copyright (c) 2015 Jon Toews. All rights reserved.
//
import Foundation
import UIKit

func load_data(L: COpaquePointer) -> Int32 {
    /*
    let jsonType:String! = String(UTF8String: lua_tolstring(L, 1, nil))
    let dictionary:NSDictionary! = LuaManager.get().createObject(2, L:L) as! NSDictionary
    switch(jsonType) {
    case "Meals":
        AppDelegate.mealsDictionary = dictionary
    case "Drinks":
        AppDelegate.drinksDictionary = dictionary
        
        let list:AnyObject = dictionary.objectForKey("Drinks")!
      //  let list:AnyObject = dictionary.objectForKey("Drinks")!
     //   let name:Int32 = 1
    default: break
    }
     */
    return 1
}

class NavigationManager {
    static let instance = NavigationManager()
    class func get() -> (NavigationManager) {
        return instance
    }
 
    init() {
    }
    
    func pushView(viewController: UIViewController, _ animated: Bool, _ screen:String?) {
        AppDelegate.getNavigationController().pushViewController(viewController, animated: animated)
    }
    
    func popToController(viewController: UIViewController, _ animated: Bool  ) {
        let viewControllers:[UIViewController] = [viewController]
        AppDelegate.getNavigationController().setViewControllers(viewControllers, animated: animated)
    }

    func popView(animated: Bool ) {

        AppDelegate.getNavigationController().popViewControllerAnimated(animated)
    }
}
     
extension UIColor {
    
    class func actionAlphaColor() -> UIColor {
        return UIColor(red: 55/255.0, green: 122/255.0, blue: 183/255.0, alpha: 0.3)
    }
    
    class func infoAlphaColor() -> UIColor {
        return UIColor(red: 91/255.0, green: 192/255.0, blue: 222/255.0, alpha: 0.3)
    }
    
    class func successAlphaColor() -> UIColor {
        return UIColor(red: 98/255.0, green: 196/255.0, blue: 98/255.0, alpha: 0.3)
    }
    
    class func warningAlphaColor() -> UIColor {
        return UIColor(red: 251/255.0, green: 180/255.0, blue: 80/255.0, alpha: 0.3)
    }
    
    class func dangerAlphaColor() -> UIColor {
        return UIColor(red: 238/255.0, green: 95/255.0, blue: 91/255.0, alpha: 0.3)
    }
    
    class func inverseAlphaColor() -> UIColor {
        return UIColor(red: 68/255.0, green: 68/255.0, blue: 68/255.0, alpha: 0.3)
    }
    
    class func actionColor() -> UIColor {
        return UIColor(red: 55/255.0, green: 122/255.0, blue: 183/255.0, alpha: 1)
    }
    
    class func infoColor() -> UIColor {
        return UIColor(red: 91/255.0, green: 192/255.0, blue: 222/255.0, alpha: 1)
    }
    
    class func successColor() -> UIColor {
        return UIColor(red: 98/255.0, green: 196/255.0, blue: 98/255.0, alpha: 1)
    }

    class func warningColor() -> UIColor {
        return UIColor(red: 251/255.0, green: 180/255.0, blue: 80/255.0, alpha: 1)
    }
    
    class func dangerColor() -> UIColor {
        return UIColor(red: 238/255.0, green: 95/255.0, blue: 91/255.0, alpha: 1)
    }
    
    class func inverseColor() -> UIColor {
        return UIColor(red: 68/255.0, green: 68/255.0, blue: 68/255.0, alpha: 1)
    }
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    /*
    static var mealsDictionary: NSDictionary?
    static var drinksDictionary: NSDictionary?
     */
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame:UIScreen.mainScreen().bounds)

        /*
        LuaManager.get().registerFunction(load_data, name: "load_data")
        
        let filePath:String! = NSBundle.mainBundle().pathForResource("configuration", ofType:"lua")
        let content:String
        
        do {
            content = try String(contentsOfFile: filePath)
        } catch {
            content = ""
        }
        
        let errResult:EvalResult? = LuaManager.get().runCodeFromString(content)
        if(errResult != nil) {
            NSLog( errResult.debugDescription )
        }
        */
        
        let introScreenController  = IntroScreenController()

        let navigationController: UINavigationController = UINavigationController(rootViewController: introScreenController)
 
        var attributes = [
            NSForegroundColorAttributeName: UIColor.inverseColor(),
            NSFontAttributeName: UIFont(name:  "AppleSDGothicNeo-Medium" , size: 12.0)!
        ]
        
        navigationController.navigationBar.titleTextAttributes = attributes
        navigationController.navigationBar.tintColor = UIColor.whiteColor()
        navigationController.navigationBar.backgroundColor =  UIColor.blackColor()
        navigationController.navigationBar.barTintColor = UIColor.blackColor()
 
        
        self.window!.makeKeyAndVisible()
        self.window!.rootViewController = navigationController
        
        return true
    }
    
    class func get() -> (AppDelegate) {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
 
    class func getNavigationController() -> (UINavigationController) {
        return (AppDelegate.get().window!.rootViewController as? UINavigationController)!
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
