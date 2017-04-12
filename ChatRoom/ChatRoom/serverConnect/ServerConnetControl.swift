//
//  ServerConnetControl.swift
//  ChatRoom
//
//  Created by mx_in on 2017/4/12.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class ServerConnetControl: NSObject, StreamDelegate{
    
    class var sharedInstance: ServerConnetControl {
        struct Static {
            static let instance: ServerConnetControl = ServerConnetControl()
        }
        return Static.instance
    }
    
    let host: CFString = "localhost" as CFString
    let port: UInt32 = 80
    
    var inputStream: InputStream!
    var outputStream: OutputStream!
    
    var message = Array<String>()
    
    override init() {
        super.init()
        initNetworkCommunication()
    }
    
    fileprivate func initNetworkCommunication() {
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
    
    //MARK: StreamDelegate
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        
    }

}

extension ServerConnetControl {
    public func joinChat(name: String) {
        let response = "iam:\(name)"
        var data = response.data(using: String.Encoding.ascii)!
        
        data.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<UInt8>) -> Void in
            self.outputStream.write(bytes, maxLength: data.count)
        }
    }
}
