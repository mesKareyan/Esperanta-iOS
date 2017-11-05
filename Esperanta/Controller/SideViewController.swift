//
//  SideViewController.swift
//  Esperanta
//
//  Created by Mesrop Kareyan on 11/5/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit

class SideViewController: UIViewController {

    weak var wrapper: MainWrapperViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func menuButtonTapped(_ sender: UIBarButtonItem) {
       wrapper.toggleSideMenu()
    }
}
