//
//  MainMenuScreen.swift
//  DecTree
//
//  Created by Jon Toews on 10/23/15.
//  Copyright © 2015 Jon Toews. All rights reserved.
//

import Foundation
import UIKit

class MainMenuController : UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        AppDelegate.getNavigationController().navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        AppDelegate.getNavigationController().navigationBarHidden = true
    }
    
    override func loadView() {
        let frame: CGRect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        self.view = UIView(frame: frame)
        self.view.backgroundColor = UIColor.blackColor()
        
        let mainLabel = UILabel(frame: CGRectMake(0, 25, UIScreen.mainScreen().bounds.width, 20))
        mainLabel.textColor = UIColor.whiteColor()
        mainLabel.backgroundColor = UIColor.clearColor()
        mainLabel.text = "Menu"
        mainLabel.textAlignment = .Center
        mainLabel.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 24.0)
 
        let buttonFrame: CGRect = CGRectMake(0, 150, UIScreen.mainScreen().bounds.width, 200)
        let buttonView = UIView(frame: buttonFrame)
        let todoButton = UIButton()
        
        todoButton.titleLabel!.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 18.0)
        todoButton.setTitle("Add Todo Item", forState: .Normal)
        todoButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        todoButton.frame = CGRectMake(60, 10, buttonFrame.size.width-120, 50)
        todoButton.backgroundColor = UIColor.actionColor()
        todoButton.addTarget(self, action: "add", forControlEvents: .TouchUpInside)
        todoButton.layer.cornerRadius = 5
        todoButton.layer.masksToBounds = true
        
        let addButton = UIButton()
        
        addButton.titleLabel!.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 18.0)
        addButton.setTitle("Todo List", forState: .Normal)
        addButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        addButton.frame = CGRectMake(60, 70, buttonFrame.size.width-120, 50)
        addButton.backgroundColor = UIColor.actionColor()
        addButton.addTarget(self, action: "todos", forControlEvents: .TouchUpInside)
        addButton.layer.cornerRadius = 5
        addButton.layer.masksToBounds = true
        
        self.view.addSubview(mainLabel)
        buttonView.addSubview(addButton)
        buttonView.addSubview(todoButton)
        self.view.addSubview(buttonView)
        
    }
    
    func add() {
        let controller = InputViewController()
        AppDelegate.getNavigationController().pushViewController(controller, animated: true)
    }
    
    func todos() {
        let controller = TodosTableViewController()
        AppDelegate.getNavigationController().pushViewController(controller, animated: true)
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
}