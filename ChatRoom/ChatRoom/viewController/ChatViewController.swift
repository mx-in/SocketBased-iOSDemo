//
//  ChatViewController.swift
//  ChatRoom
//
//  Created by mx_in on 2017/4/13.
//  Copyright © 2017年 mx_in. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var messageInputTextField: UITextField!
    @IBOutlet weak var messageTableView: UITableView!
    
    let messageTableCellId = "chatMessageCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTableView.delegate = self;
        messageTableView.dataSource = self;
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(notification:)), name:Notification.Name(rawValue: ServerConectController.messageRecivedNotification), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @objc fileprivate func reloadData(notification: NSNotification) {
        messageTableView.reloadData()
        let index = IndexPath(row: ServerConectController.sharedInstance.messages.count - 1, section: 0)
        messageTableView.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: true)
    }
    
    @IBAction func sendBtnTrigger(_ sender: UIButton) {
        guard let messsage = messageInputTextField.text else {
            return
        }
        ServerConectController.sharedInstance.sendMessage(messsage)
        messageInputTextField.text = ""
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ServerConectController.sharedInstance.messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageTableCellId)! as UITableViewCell
        let message = ServerConectController.sharedInstance.messages[indexPath.row]
        cell.textLabel?.text = message
        
        return cell
    }
    
    @objc fileprivate func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        var tableViewFrame = messageTableView.frame
        tableViewFrame.size.height -= keyboardHeight
        messageTableView.frame = tableViewFrame
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name(rawValue: ServerConectController.messageRecivedNotification), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
}
