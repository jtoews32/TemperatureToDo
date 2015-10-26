//
//  TodosTableViewController.swift
//  DecTree
//
//  Created by Jon Toews on 10/24/15.
//  Copyright © 2015 Jon Toews. All rights reserved.
//

import Foundation
import UIKit

class TodosTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var tableView: UITableView?
    var allButton:UIButton?
    var completedButton:UIButton?
    var incompleteButton:UIButton?
    
    var items: [Todo] = []
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBarHidden = false
        
        let frame: CGRect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        self.view = UIView(frame: frame)
        self.view.backgroundColor = UIColor.whiteColor()
        
        let mainLabel = UILabel(frame: CGRectMake(0, 90, UIScreen.mainScreen().bounds.width, 20))
        mainLabel.textColor = UIColor.blackColor()
        mainLabel.backgroundColor = UIColor.whiteColor()
        mainLabel.text = "Todo List"
        mainLabel.textAlignment = .Center
        mainLabel.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 20.0)
        
        let horizontalScrollView:UIView = UIView(frame: CGRectMake(0, 110, UIScreen.mainScreen().bounds.width, 50))
       // horizontalScrollView.indicatorStyle = UIScrollViewIndicatorStyle.Black
        horizontalScrollView.clipsToBounds = false
       // horizontalScrollView.scrollEnabled = true
       // horizontalScrollView.canCancelContentTouches = false
       // horizontalScrollView.delaysContentTouches = true
        
      //  let indicatorView:UIView = UIView()
      //  indicatorView.frame =  CGRectMake(0, 190, UIScreen.mainScreen().bounds.width, 20)
        
      //  let image = UIImage(named:"up.png")
      //  let imageView = UIImageView(image: image!)
        
      //  imageView.frame = CGRect(x: (indicatorView.frame.width/2)-10, y: 0, width:20, height: 20)
        
      //  indicatorView.addSubview(imageView)
        
     //   let spaceView:UIView  = UIView()
     //   spaceView.frame = CGRectMake( 10 , 10, 100, 40)
     //   spaceView.backgroundColor = UIColor.clearColor()
     //   spaceView.layer.cornerRadius = 2
     //   spaceView.layer.masksToBounds = true
        self.allButton  = UIButton()
        self.allButton!.frame = CGRectMake(10, 10, 95, 25)
        self.allButton!.backgroundColor = UIColor.actionColor()
        self.allButton!.layer.cornerRadius = 2
        self.allButton!.layer.masksToBounds = true
       
        self.allButton!.titleLabel!.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 12.0)
        self.allButton!.setTitle("All", forState: .Normal)
        self.allButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.allButton!.addTarget(self, action: "all", forControlEvents: .TouchUpInside)
        
        
        self.completedButton  = UIButton()
        self.completedButton!.frame = CGRectMake(  110 , 10, 95, 25)
        self.completedButton!.backgroundColor = UIColor.actionColor()
        self.completedButton!.layer.cornerRadius = 2
        self.completedButton!.layer.masksToBounds = true
        
        self.completedButton!.titleLabel!.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 12.0)
        self.completedButton!.setTitle("Complete", forState: .Normal)
        self.completedButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.completedButton!.addTarget(self, action: "complete", forControlEvents: .TouchUpInside)
        
        self.incompleteButton  = UIButton()
        self.incompleteButton!.frame = CGRectMake(  210, 10, 95, 25)
        self.incompleteButton!.backgroundColor = UIColor.actionColor()
        self.incompleteButton!.layer.cornerRadius = 2
        self.incompleteButton!.layer.masksToBounds = true
      
        self.incompleteButton!.titleLabel!.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 12.0)
        self.incompleteButton!.setTitle("Incomplete", forState: .Normal)
        self.incompleteButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.incompleteButton!.addTarget(self, action: "incomplete", forControlEvents: .TouchUpInside)

    //    horizontalScrollView.contentSize = CGSizeMake(560, horizontalScrollView.bounds.size.height)
    //    horizontalScrollView.showsHorizontalScrollIndicator = true
   //     horizontalScrollView.indicatorStyle = .Default
     //   horizontalScrollView.contentOffset = CGPointMake(0, 0)
        
   //     horizontalScrollView.addSubview(spaceView)
        horizontalScrollView.addSubview(allButton!)
        horizontalScrollView.addSubview(completedButton!)
        horizontalScrollView.addSubview(incompleteButton!)
      //  horizontalScrollView.delegate = self
        
        let contentFrame = CGRectMake(0, 150, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-150)
        let contentView = UIView(frame: contentFrame)
        // contentView.backgroundColor = UIColor.blackColor()
        let scrollableContentFrame = CGRectMake(10 , 10, contentFrame.size.width - 20, contentFrame.size.height-20)
        let verticalScrollView = UIScrollView(frame: scrollableContentFrame)
        
        verticalScrollView.indicatorStyle = UIScrollViewIndicatorStyle.White
        verticalScrollView.clipsToBounds = true
        verticalScrollView.scrollEnabled = true
        verticalScrollView.pagingEnabled = true
        verticalScrollView.canCancelContentTouches = false
        verticalScrollView.contentSize = CGSizeMake(scrollableContentFrame.width, 1000)
        verticalScrollView.showsHorizontalScrollIndicator = true
        verticalScrollView.indicatorStyle = .Default
        verticalScrollView.directionalLockEnabled = true
        
        let tableViewFrame = CGRectMake(0 , 0, scrollableContentFrame.size.width, 1000)
        
        self.tableView = UITableView(frame: tableViewFrame)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.scrollEnabled = false
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(mainLabel)
        self.view.addSubview(horizontalScrollView)
       // self.view.addSubview(indicatorView)
        verticalScrollView.addSubview(self.tableView!)
        contentView.addSubview(verticalScrollView)
        self.view.addSubview(contentView)
        
        self.items = DatabaseManager.get().allTodos()
        self.allButton?.backgroundColor = UIColor.actionAlphaColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier:String = "cell";
        let cell:UITableViewCell! = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        
        let temperatureFrame = CGRectMake(0, 0, 50, cell.contentView.bounds.height)
        
        let temperatureLabel = UILabel(frame: temperatureFrame)
        let temp = Int( self.items[indexPath.row].temperature! )
        
        temperatureLabel.textColor = UIColor.actionColor()
        temperatureLabel.text = "\(temp)\u{00B0}F"
        temperatureLabel.textAlignment = .Left
        temperatureLabel.font = UIFont(name:  "AppleSDGothicNeo-Bold" , size: 10.0)
    
        let titleTextFrame = CGRectMake(50, 0, 180, cell.contentView.bounds.height)
        
        let titleLabel = UILabel(frame: titleTextFrame)
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.text = self.items[indexPath.row].location
        titleLabel.textAlignment = .Center
        titleLabel.font = UIFont(name:  "AppleSDGothicNeo-SemiBold" , size: 16.0)
        
        
        let descriptionTextFrame = CGRectMake(50, (cell.contentView.bounds.height/2)+5, 180, (cell.contentView.bounds.height/2)-5)
        let descriptionLabel = UILabel(frame: descriptionTextFrame)
        descriptionLabel.textColor = UIColor.blackColor()
        
        descriptionLabel.text = self.items[indexPath.row].description
        descriptionLabel.textAlignment = .Center
        descriptionLabel.font = UIFont(name:  "AppleSDGothicNeo-Regular" , size: 10.0)

        cell.contentView.addSubview( temperatureLabel )
        cell.contentView.addSubview( titleLabel )
        cell.contentView.addSubview( descriptionLabel )
        
        cell.accessoryType = .Checkmark
        
        if self.items[indexPath.row].complete == 1 {
            cell?.accessoryType = .Checkmark
        } else {
            cell?.accessoryType = .None
        }
        
        cell.tag = Int( self.items[indexPath.row].id! )
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let cellId:Int = (cell?.tag)!
        let todo:Todo? = DatabaseManager.get().findTodo( cellId  )
        
        if todo != nil && todo?.complete == 1 {
            cell?.accessoryType = .None
            DatabaseManager.get().updateTodoCheckmark(  cellId , 0)
        } else {
            cell?.accessoryType = .Checkmark
            DatabaseManager.get().updateTodoCheckmark(  cellId , 1)
        }
        cell?.backgroundColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        switch editingStyle {
        case .Delete:
            // remove the deleted item from the model
            self.items.removeAtIndex(indexPath.row)
            
            // remove the deleted item from the `UITableView`
            self.tableView!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        default:
            return
        }
    }

    func clearButtons() {
        self.allButton?.backgroundColor = UIColor.actionColor()
        self.completedButton?.backgroundColor = UIColor.actionColor()
        self.incompleteButton?.backgroundColor = UIColor.actionColor()
    }
    
    func all() {
        clearButtons()
        self.items.removeAll()
        self.items = DatabaseManager.get().allTodos()
        self.tableView!.reloadData()
        self.allButton?.backgroundColor = UIColor.actionAlphaColor()
    }
    
    func complete() {
        clearButtons()
        self.items.removeAll()
        self.items = DatabaseManager.get().allTodosByStatus(1)
        self.tableView!.reloadData()
        self.completedButton?.backgroundColor = UIColor.actionAlphaColor()
    }
    
    func incomplete() {
        clearButtons()
        self.items.removeAll()
        self.items = DatabaseManager.get().allTodosByStatus(0)
        self.tableView!.reloadData()
        self.incompleteButton?.backgroundColor = UIColor.actionAlphaColor()
    }
}