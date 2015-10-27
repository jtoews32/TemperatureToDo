//
//  CollectionViewController.swift
//  DecTree
//
//  Created by Jon Toews on 10/16/15.
//  Copyright © 2015 Jon Toews. All rights reserved.
//

import Foundation
import UIKit



class CollectionViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 60, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 90, height: 85)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(collectionView)
        
        let toolbar: UIToolbar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        
        let settingsButton = UIBarButtonItem(title: "Settings", style: .Done, target: self, action: "checkedPress")
        settingsButton.tintColor = UIColor.blackColor()
        // settingsButton.t
        
        let helpButton = UIBarButtonItem(title: "Help", style: .Done, target: self, action: "checkedPress")
        helpButton.tintColor = UIColor.blackColor()
        // helpButton.
        
     //   let quitButton = UIBarButtonItem(title: "Quit", style: .Done, target: self, action: "checkedPress")
     //   quitButton.tintColor = UIColor.blackColor()
        // quitButton.ti
        
        let settingsButtonList = [
            flexibleSpace,
            settingsButton,
            flexibleSpace,
            helpButton,
            flexibleSpace
          //  quitButton
        ]

        toolbar.frame = CGRectMake(0, self.view.frame.size.height - 46, self.view.frame.size.width, 52)
        toolbar.sizeToFit()
        toolbar.tintColor = UIColor.yellowColor()
        
        toolbar.setItems(settingsButtonList, animated: true)

        self.view.addSubview(toolbar)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        cell.backgroundColor = UIColor.clearColor()
        
        let button = UIButton()
        button.titleLabel!.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 18.0)

        /// indexPath.row == 1 maybe check for row 1 Item 1
        if indexPath.item == 0 {
            button.setTitle("Grocery", forState: .Normal)
            button.addTarget(self, action: "grocery", forControlEvents: .TouchUpInside)
        }
     
        if indexPath.item == 1 {
            button.setTitle("Drinks", forState: .Normal)
            button.addTarget(self, action: "drinks", forControlEvents: .TouchUpInside)
        }
        
        if indexPath.item == 2 {
            button.setTitle("Search", forState: .Normal)
            button.addTarget(self, action: "search", forControlEvents: .TouchUpInside)
        }
        
        if indexPath.item == 3 {
            button.setTitle("Cart", forState: .Normal)
            button.addTarget(self, action: "cart", forControlEvents: .TouchUpInside)
        }
        
        if indexPath.item == 4 {
            button.setTitle("Add", forState: .Normal)
            button.addTarget(self, action: "add", forControlEvents: .TouchUpInside)
        }
        
        
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.frame = CGRectMake(0, 0, cell.frame.width, cell.frame.height)
        button.backgroundColor = UIColor.successColor()
        
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        
        cell.addSubview(button)
        
        return cell
    }
    
    func search () {
        print("Search")
        /*
        let controller  = SearchTableViewController()
        AppDelegate.getNavigationController().pushViewController(controller, animated: true)
*/
    }
    
    func drinks () {
        print("Drinks")
        /*
        let controller = DrinksTableViewController()
        AppDelegate.getNavigationController().pushViewController(controller, animated: true)
*/
    }

    func grocery () {
        print("Grocery")

        /*
        let controller = TableViewController()
        AppDelegate.getNavigationController().pushViewController(controller, animated: true)*/
    }
    
    func cart() {
        print("Cart")
        /*
        let controller = CartTableViewController()
        AppDelegate.getNavigationController().pushViewController(controller, animated: true)
        */
    }
    
    
    func add() {
        print("Add")
        
        let controller = MainMenuController()
        AppDelegate.getNavigationController().pushViewController(controller, animated: true)
    }
    
    
}



