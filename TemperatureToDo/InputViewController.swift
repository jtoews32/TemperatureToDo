//
//  InputViewController.swift
//  DecTree
//
//  Created by Jon Toews on 10/24/15.
//  Copyright © 2015 Jon Toews. All rights reserved.
//

import Foundation
import UIKit

class InputViewController : UIViewController, NSURLConnectionDelegate {
    
    var locationTextField: UITextField?
    var descriptionTextField: UITextField?
    var messageTextView: UITextView?
    
    var checkButton:UIButton?
    var saveButton:UIButton?
    var connection: NSURLConnection?
    var todo:Todo?
    
    lazy var data = NSMutableData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Force the device in portrait mode when the view controller gets loaded
        UIDevice.currentDevice().setValue(UIInterfaceOrientation.Portrait.rawValue, forKey: "orientation")
    }
    
    override func loadView() {
        super.loadView()
        self.navigationController?.navigationBarHidden = false
        
        let frame: CGRect = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height)
        
        self.view = UIView(frame: frame)
        self.view.backgroundColor = UIColor.whiteColor()
        
        let mainLabel = UILabel(frame: CGRectMake(0, 90, UIScreen.mainScreen().bounds.width, 20))
        mainLabel.textColor = UIColor.blackColor()
        mainLabel.backgroundColor = UIColor.whiteColor()
        mainLabel.text = "Create Todo"
        mainLabel.textAlignment = .Center
        mainLabel.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 20.0)
    
        let infoLabel: UILabel = UILabel()
        infoLabel.frame = CGRectMake((UIScreen.mainScreen().bounds.width / 2) - 100 , 100, 200, 50)
        infoLabel.textColor = UIColor.blackColor()
        infoLabel.textAlignment = NSTextAlignment.Center
        infoLabel.text = "Add Location/Description"
        infoLabel.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 16.0)
        self.view.addSubview(infoLabel)
        
        locationTextField = UITextField()
        locationTextField!.frame = CGRectMake((UIScreen.mainScreen().bounds.width / 2) - 150 , 150, 300, 50)
        locationTextField!.placeholder = "Location"

        var border = CALayer()
        var width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: locationTextField!.frame.size.height - width, width:  locationTextField!.frame.size.width , height: locationTextField!.frame.size.height)
        
        border.borderWidth = width
        locationTextField!.contentVerticalAlignment = .Bottom
        locationTextField!.layer.addSublayer(border)
        locationTextField!.layer.masksToBounds = true
        self.view.addSubview(locationTextField!)
        
        descriptionTextField = UITextField()
        descriptionTextField!.frame = CGRectMake((UIScreen.mainScreen().bounds.width / 2) - 150 , 202, 300, 50)
        descriptionTextField!.placeholder = "Description"

        border = CALayer()
        width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: descriptionTextField!.frame.size.height - width, width:  descriptionTextField!.frame.size.width, height: descriptionTextField!.frame.size.height-2)
        
        border.borderWidth = width
        descriptionTextField!.contentVerticalAlignment = .Bottom
        descriptionTextField!.layer.addSublayer(border)
        descriptionTextField!.layer.masksToBounds = true
       
        self.view.addSubview(descriptionTextField!)
        
        let buttonFrame: CGRect = CGRectMake(0, 420, UIScreen.mainScreen().bounds.width, 200)
        let buttonView = UIView(frame: buttonFrame)
        
        self.checkButton = UIButton()
        
        checkButton!.titleLabel!.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 18.0)
        checkButton!.setTitle("Get Temperature", forState: .Normal)
        checkButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        checkButton!.frame = CGRectMake(60, 10, buttonFrame.size.width-120, 50)
        checkButton!.backgroundColor = UIColor.actionColor()
        checkButton!.addTarget(self, action: "temperature", forControlEvents: .TouchUpInside)
        checkButton!.layer.cornerRadius = 5
        checkButton!.layer.masksToBounds = true
        
        self.saveButton = UIButton()
        
        saveButton!.titleLabel!.font = UIFont(name:  "AppleSDGothicNeo-Medium" , size: 18.0)
        saveButton!.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        saveButton!.frame = CGRectMake(60, 70, buttonFrame.size.width-120, 50)
        saveButton!.backgroundColor = UIColor.actionColor()
        saveButton!.setTitle("Save", forState: .Normal)
        saveButton!.addTarget(self, action: "save", forControlEvents: .TouchUpInside)
        saveButton!.layer.cornerRadius = 5
        saveButton!.layer.masksToBounds = true
        saveButton!.hidden = true
        
        messageTextView = UITextView()
        messageTextView!.frame = CGRectMake((UIScreen.mainScreen().bounds.width / 2) - 150 , 302, 300, 100)
 
        border = CALayer()
        width = CGFloat(1.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: messageTextView!.frame.size.height - width, width:  messageTextView!.frame.size.width, height: messageTextView!.frame.size.height-2)
        
        border.borderWidth = width
        
        messageTextView!.layer.addSublayer(border)
        messageTextView!.layer.masksToBounds = true
        messageTextView!.userInteractionEnabled = false
        messageTextView!.textAlignment = .Center

        self.view.addSubview(messageTextView!)
        
        self.view.addSubview(mainLabel)
        buttonView.addSubview(checkButton!)
        buttonView.addSubview(saveButton!)
        self.view.addSubview(buttonView)
    }
    
    
    func temperature(){
        let location:String = self.locationTextField!.text!
        
        let city = location.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        
        let urlPath: String = "http://api.openweathermap.org/data/2.5/weather?q=\(city!)&appid=bd82977b86bf27fb59a04b61b657fb6f"
        var url: NSURL = NSURL(string: urlPath)!
        var request: NSURLRequest = NSURLRequest(URL: url)
        
        self.connection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        self.connection?.start()
    }
    
    func save(){
        DatabaseManager.get().createTodo((self.todo?.description)!, (self.todo?.location)!, 0, (self.todo?.temperature)!)
        let controller = MainMenuController()
        NavigationManager.get().popToController(controller, true )
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {

        do {
            let response: NSDictionary = try NSJSONSerialization.JSONObjectWithData(self.data, options: NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            self.connection?.cancel()
            self.data = NSMutableData()
                

            self.todo = Todo()
            self.todo?.description = self.descriptionTextField!.text!
            var failed:Bool = false
            
            print(response)
            
            if let json = response as? NSDictionary {
                if let name = json["name"] as AnyObject? as? String {
                    self.todo?.location = name
                } else {
                    failed = true
                }
                if let main = json["main"] as? NSDictionary {
                    if let temp = main["temp"] as AnyObject? as? Double {
                        self.todo?.temperature = temp * 9/5 - 459.67
                    } else {
                        failed = true
                    }
                } else {
                    failed = true
                }
            } else {
                failed = true
            }
            
            if self.todo?.description! == nil || self.todo?.description! == "" {
                failed = true
            }
        
            if failed  {
                messageTextView?.text = "Data Service Failure! Try another location\nor\nFix your connection"
                return
            }
            
            let temperature = Int( self.todo!.temperature! )
            messageTextView?.text = "Successful!\n\n\(self.todo!.location!)\n\(temperature)\u{00B0}F\n\(self.todo!.description!)"
            saveButton?.hidden = false
            

        } catch let error as NSError {
            
            messageTextView?.text = "Data Service Failure! \(error)"
            
            print("\(error)\(self.data)")
            return
        }
        
    }
    
    override func shouldAutorotate() -> Bool {
        // Lock autorotate
        return false
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }
}