//
//  ViewController.swift
//  ChatRoom
//
//  Created by mx_in on 2017/4/12.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class JoinChatViewController: UIViewController, StreamDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    var message = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func joinChat(_ sender: UIButton) {
        guard let name = nameTextField.text else {
            
            return
        }
        
        ServerConectController.sharedInstance.joinChat(name: name)
        
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        
    }
}

