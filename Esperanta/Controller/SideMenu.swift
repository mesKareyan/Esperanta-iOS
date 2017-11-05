//
//  SideMenu.swift
//  Esperanta
//
//  Created by Mesrop Kareyan on 11/5/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit

class SideMenu {
    
    private init(){}
    private(set) static var instance: SideViewController!
    static let shared: SideMenu = {
        let appDelegate  = UIApplication.shared.delegate as! AppDelegate
        let rootController = appDelegate.window!.rootViewController as! MainWrapperViewController
        instance = rootController.sideMenu
        return SideMenu()
    }()
    
}
