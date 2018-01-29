//
//  XuLogInVC.swift
//  YMSJ
//
//  Created by  abcxdx@sina.com on 2017/12/6.
//  Copyright © 2017年 xdxbus@sina.com. All rights reserved.
//

import UIKit

class XuLogInVC: UITableViewController,UITextFieldDelegate {
    
    var userName:String?
    var passWord:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = xu_main_bgColor
        tableView.tableHeaderView = logoView()
    }

    // MARK: - layout
    func logoView() -> UIView {
        
        let headerView = UIView()
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 250)

        let logoView = UIImageView()
        logoView.contentMode = UIViewContentMode.center
        logoView.image = UIImage(named: "xu_login_logo_100x100")
        
        headerView.addSubview(logoView)
        
        logoView.snp.makeConstraints { (make) in
            
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(50)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }
        
        return headerView
    }
    
    @objc func logInActoin() {
        self.view.endEditing(true)
        
        if (userName == nil) || (passWord == nil) || (userName?.isEmpty)! || (passWord?.isEmpty)! {
            return
        }
        
        loginSuccess()
    }
    
    func loginSuccess() {
        
        self .dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.selectionStyle  = UITableViewCellSelectionStyle.none
        cell.backgroundColor = xu_main_bgColor
        
        if indexPath.row < 2 {
            let inputTF = UITextField()
            inputTF.tag = indexPath.row + 1000;
            inputTF.delegate = self;
            inputTF.backgroundColor = .white
            cell.contentView.addSubview(inputTF)
            
            inputTF.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: 200, height: 44))
            })

            if indexPath.row == 0 {
                inputTF.placeholder = "用户名"
            } else {
                inputTF.isSecureTextEntry = true
                inputTF.placeholder = "密码"
            }
            
        } else {
            let loginBtn = UIButton()
            loginBtn.setTitle("登 陆", for: .normal)
            loginBtn.addTarget(self, action: #selector(logInActoin), for: .touchUpInside)
            loginBtn.backgroundColor = xu_main_color
            cell.contentView.addSubview(loginBtn)
            loginBtn.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: 200, height: 44))
            })
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 80
        case 1:
             return 80
        case 2:
             return 80
        default:
             return 80
        }
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1000 {
            userName = textField.text!
            } else {
            passWord = textField.text!
        }
    }
}
