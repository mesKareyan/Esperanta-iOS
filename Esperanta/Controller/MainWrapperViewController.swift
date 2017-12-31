//
//  MainWrapperViewController.swift
//  Esperanta
//
//  Created by Mesrop Kareyan on 11/5/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainWrapperViewController: UIViewController {

    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var mainViewSideConstraintR: NSLayoutConstraint!
    @IBOutlet weak var mainViewSideConstraint: NSLayoutConstraint!
    @IBOutlet weak var sideViewSideConstraint: NSLayoutConstraint!
    
    weak var sideMenu: SideViewController!
    weak var mainTab: MainTabBarController!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var sideView: UIView!
    var tap: UITapGestureRecognizer!
    
    var isSideMenuHidden = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let identifier = segue.identifier else {
            return
        }
        if identifier == "sideMenu" {
            let sideMenu = (segue.destination as! UINavigationController).viewControllers.first as! SideViewController
            sideMenu.delegate = self
            self.sideMenu = sideMenu
        } else if identifier == "mainTabBar" {
            let mainTab = (segue.destination as! UINavigationController).viewControllers.first as! MainTabBarController
            mainTab.wrapper = self
            self.mainTab = mainTab
        }
    }
    
    var sideMenuPosition: CGFloat = 0 {
        didSet {
            let value = sideMenuPosition / sideView.bounds.width
            UIView.animate(withDuration: 0.1) {
                self.coverView.alpha = value
            }
        }
    }

}

extension MainWrapperViewController {
    
    func configureUI(){
        sideViewSideConstraint.constant = -sideView.bounds.width
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleLeftViewSwipe(recognizer:)))
        sideView.addGestureRecognizer(pan)
        
        tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        let leftEdgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleLeftViewEdgePan(recognizer:)))
        leftEdgePan.edges = .left
        view.addGestureRecognizer(leftEdgePan)
        //add cover view
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            coverView.backgroundColor = UIColor.esperantaGray
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = coverView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            coverView.addSubview(blurEffectView)
        } else {
            coverView.backgroundColor = UIColor.esperantaGray
        }
        coverView.alpha = 0.0
    }
    
    //MARK: Side menu
    @objc func handleLeftViewSwipe(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: sideView)
        var xConstant = translation.x
        var animationDuration = 0.1
        if xConstant > 0 {
            xConstant = 0
        }
        switch recognizer.state {
        case .cancelled, .failed, .ended:
            //hide left view if needed
            if xConstant < -50 {
                hideSideMenu()
                return
            } else {
                xConstant = 0
                animationDuration = 0.2
            }
        default:
            break
        }
        //xConstant is touch position in left view
        sideViewSideConstraint.constant  = xConstant
        sideMenuPosition = sideView.bounds.width + xConstant
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    @objc func handleLeftViewEdgePan(recognizer:
                                    UIScreenEdgePanGestureRecognizer) {
        let translation = recognizer.translation(in: sideView)
        var xConstant = translation.x - sideView.bounds.width
        var animationDuration = 0.1
        if xConstant >  0 {
            xConstant = 0
        }
        switch recognizer.state {
        case .cancelled, .failed, .ended:
            //hide left view if needed
            if xConstant < -50
                && recognizer.velocity(in: sideView).x > 0 {
                showSideMenu()
                return
            } else {
                xConstant = 0
                animationDuration = 0.2
            }
        default:
            break
        }
        //xConstant is touch position in left view
        sideViewSideConstraint.constant = xConstant
        sideMenuPosition = sideView.bounds.width + xConstant
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func hideSideMenu(){
        sideMenuPosition = 0
        isSideMenuHidden = true
        sideViewSideConstraint.constant = -sideView.bounds.width
        mainViewSideConstraint.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @objc func showSideMenu(){
        sideMenuPosition = sideView.bounds.width
        isSideMenuHidden = false
        sideViewSideConstraint.constant = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func toggleSideMenu(){
        isSideMenuHidden ? showSideMenu() : hideSideMenu()
    }
    
    @objc func handleTap(_ tap: UITapGestureRecognizer) {
        let tapView = tap.view
        let location = tap.location(in: tapView)
        if !sideView.frame.contains(location) {
            hideSideMenu()
        }
    }
}

extension MainWrapperViewController: SideMenuDelegate {
    
    func menuButtonTapped() {
        toggleSideMenu()
    }
    
    func signoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch  {
            print(error)
        }
    }
    
  
}






