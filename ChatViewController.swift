//
//  ChatViewController.swift
//  Zonnexions
//
//  Created by Technical Staff on 11/29/15.
//  Copyright © 2015 EP. All rights reserved.
//

import Foundation
import UIKit

@objc protocol ChatViewDelegate{//put the @objc so that it will be available to objc classes
    func lala()
}

class ViewController: UIViewController, UIAlertViewDelegate {

let socket = SocketIOClient(socketURL: "node.sekolahhebat.com:3000")

//   let socket = SocketIOClient(socketURL: "localhost:8080", options: [.Log(true), .ForcePolling(true)])


override func viewDidLoad()
    {
        super.viewDidLoad()
    
        socket.on("connected") {data, ack in
            print("socket connected")
        
    }
    
        socket.on("chat message") {data, ack in
        if let name = data[0] as? String {
            //self.textView1.text = name
            let screenSize: CGRect = UIScreen.mainScreen().bounds
            let screenWidth = screenSize.width;
            let screenHeight = screenSize.height;
            
            let textView : UITextField = UITextField(frame : CGRect(x:10, y:(screenHeight/2), width:        (screenWidth-20), height: (screenHeight/3) ))
            textView.backgroundColor = UIColor( red: 0.9, green: 0.9, blue:0.9, alpha: 1.0 )
            textView.placeholder = NSLocalizedString("Start typing...", comment: "")
            textView.text = name
            textView.borderStyle = UITextBorderStyle.Line;
            //   textView.autocorrectionType = .Yes
            //self.textView1.addSubview( textView )
            }
        }
    
        socket.connect()
    
    }
}