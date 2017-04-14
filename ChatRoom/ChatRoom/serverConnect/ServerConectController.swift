//
//  ServerConnetControl.swift
//  ChatRoom
//
//  Created by mx_in on 2017/4/12.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

 class ServerConectController: NSObject, StreamDelegate{
    
    class var sharedInstance: ServerConectController {
        struct Static {
            static let instance: ServerConectController = ServerConectController()
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
    
    func joinChat(name: String) {
        let responseStr = "iam:\(name)"
        responseStr.withBytes(stringBytes: {(stringBytes: (UnsafeMutablePointer <UInt8>), dataCount: Int) -> Void in
            self.outputStream.write(stringBytes, maxLength: dataCount)
        })
        
    }
    
    func sendMessage(_ message: String) {
        let responseStr = "msg:\(message)"
        responseStr.withBytes { bytes, length in self.outputStream.write(bytes, maxLength: length) }
    }
    
    //MARK: StreamDelegatstringBytes: (UnsafeMutablePointer <UInt8>), dataCount: integer-> Voide
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        
    }

}

extension String {
    func withBytes(stringBytes: (UnsafeMutablePointer <UInt8>,  Int)-> Void) {
        var stringData = self.data(using: String.Encoding.ascii)!
        stringData.withUnsafeMutableBytes { (bytes: UnsafeMutablePointer<UInt8>) -> Void in
            stringBytes(bytes, stringData.count)
        }
    }
}









