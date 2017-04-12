//
//  ViewController.swift
//  ChatRoom
//
//  Created by mx_in on 2017/4/12.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class ChatClientViewController: UIViewController, StreamDelegate {

    let host: CFString = "localhost" as CFString
    let port: UInt32 = 80
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNetworkCommunication()
    }
    
    func initNetworkCommunication() {
        var readStream: Unmanaged<CFReadStream>?
        var writeStream: Unmanaged<CFWriteStream>?
        CFStreamCreatePairWithSocketToHost(nil, self.host, self.port, &readStream, &writeStream)
        
        self.inputStream = readStream!.takeRetainedValue()
        self.outputStream = writeStream!.takeRetainedValue()
        
        self.inputStream.delegate = self
        self.outputStream.delegate = self
        
        self.inputStream.schedule(in: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        self.inputStream.open()
        self.outputStream.open()
    }

    @IBAction func joinChat(_ sender: UIButton) {
        
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        
    }
}

