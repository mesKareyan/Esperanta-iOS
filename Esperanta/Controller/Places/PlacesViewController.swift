//
//  PlacesViewController.swift
//  Esperanta
//
//  Created by Mesrop Kareyan on 11/6/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit

class PlacesViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.title = self.navigationItem.title
    }
    
}
