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
    }
    
    @IBAction func sendBtnTrigger(_ sender: UIButton) {
        guard let messsage = messageInputTextField.text else {
            return
        }
        ServerConectController.sharedInstance.sendMessage(messsage)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageTableCellId)! as UITableViewCell
        
        return cell
    }
}
