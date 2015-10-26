//
//  IntroScreenController.swift
//  DecTree
//
//  Created by Jon Toews on 9/21/15.
//  Copyright © 2015 Jon Toews. All rights reserved.
//
import Foundation
import UIKit

class IntroScreenController: UIViewController  {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Force the device in portrait mode when the view controller gets loaded
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
    }
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBarHidden = true
        
        let frame: CGRect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        self.view = UIView(frame: frame)
        self.view.backgroundColor = UIColor.blackColor()
        
        let image1 = UIImage(named:"temp.png")
        let imageView1 = UIImageView(image: image1!)
        imageView1.frame = CGRect(x: 80, y: 0, width: UIScreen.mainScreen().bounds.width-160, height: 300)
        
        let mainLabel = UILabel(frame: CGRectMake(0, 60, UIScreen.mainScreen().bounds.width, 60))
        mainLabel.textColor = UIColor.whiteColor()
        mainLabel.text = "TemperatureToDo"
        mainLabel.textAlignment = .Center
        mainLabel.font = UIFont(name:  "AppleSDGothicNeo-SemiBold" , size: 30.0)
        
        let buttonViewFrame: CGRect = CGRectMake(0, 450, UIScreen.mainScreen().bounds.width, 70)
        let buttonView = UIView(frame: buttonViewFrame)
        
        let startButton = UIButton()
        
        startButton.titleLabel!.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 18.0)
        startButton.setTitle("Start", forState: .Normal)
        startButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        startButton.frame = CGRectMake(60, 10, buttonViewFrame.size.width-120, 50)
        startButton.backgroundColor = UIColor.actionColor()
        startButton.addTarget(self, action: "pressed", forControlEvents: .TouchUpInside)
        startButton.layer.cornerRadius = 5
        startButton.layer.masksToBounds = true

        let imageFrame: CGRect = CGRectMake(0, 130, UIScreen.mainScreen().bounds.width, 300)
        
        let pictureView = UIView(frame: imageFrame)
        pictureView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        pictureView.addSubview(imageView1)
        
        self.view.addSubview(mainLabel)
        buttonView.addSubview(startButton)
        self.view.addSubview(buttonView)
        self.view.addSubview(pictureView)
        
    }
    
    func pressed() {
        let controller = MainMenuController()
        NavigationManager.get().popToController(controller, true )

        /*
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "Here's a message"
        alert.addButtonWithTitle("Understod")
        alert.show()
        */
    }
    
    
    override func viewWillDisappear(animated: Bool)
    {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }
}