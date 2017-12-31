//
//  SideViewController.swift
//  Esperanta
//
//  Created by Mesrop Kareyan on 11/5/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit

protocol SideMenuDelegate: class {
    func menuButtonTapped()
    func signoutButtonTapped()
}

class SideViewController: UITableViewController {
    
    weak var delegate: SideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        let leftSideView = UIView()
        leftSideView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftSideView)
        leftSideView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        leftSideView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leftSideView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftSideView.widthAnchor.constraint(lessThanOrEqualToConstant: 2.0).isActive = true
        leftSideView.backgroundColor = UIColor.red
    }

    @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
       delegate?.menuButtonTapped()
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        delegate?.signoutButtonTapped()
    }
    
}
