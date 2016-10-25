//
//  ProgressHUD.swift
//  Flickr Viewer
//
//  Created by Jorge Mendes on 25/10/16.
//  Copyright © 2016 Jorge Mendes. All rights reserved.
//

import UIKit
import JGProgressHUD

class ProgressHUD: NSObject {

    private class func createProgressHUD() -> JGProgressHUD {
        let hud: JGProgressHUD = JGProgressHUD(style: .dark)
        hud.interactionType = .blockAllTouches
        hud.animation = JGProgressHUDFadeZoomAnimation()
        hud.backgroundColor = UIColor.init(white: 0.0, alpha: 0.4)
        hud.textLabel.font = UIFont.systemFont(ofSize: 14.0)
        hud.hudView.layer.shadowColor = UIColor.black.cgColor
        hud.hudView.layer.shadowOffset = CGSize.zero
        hud.hudView.layer.shadowOpacity = 0.4
        hud.hudView.layer.shadowRadius = 8.0
        return hud
    }
    
    class func showProgressHUD(view: UIView, text: String = "", isSquared: Bool = true) {
        let allHuds: [JGProgressHUD] = JGProgressHUD.allProgressHUDs(in: view) as! [JGProgressHUD]
        if allHuds.count > 0 {
            let hud: JGProgressHUD = allHuds.first!
            hud.indicatorView = JGProgressHUDIndeterminateIndicatorView(hudStyle: hud.style)
            hud.textLabel.text = text
            hud.square = isSquared
        } else {
            let newHud: JGProgressHUD = self.createProgressHUD()
            newHud.indicatorView = JGProgressHUDIndeterminateIndicatorView(hudStyle: newHud.style)
            newHud.textLabel.text = text
            newHud.square = isSquared
            newHud.show(in: view)
        }
    }
    
    class func showSuccessHUD(view: UIView, text: String = "Success") {
        let allHuds: [JGProgressHUD] = JGProgressHUD.allProgressHUDs(in: view) as! [JGProgressHUD]
        if allHuds.count > 0 {
            let hud: JGProgressHUD = allHuds.first!
            hud.indicatorView = JGProgressHUDSuccessIndicatorView()
            hud.textLabel.text = text
            hud.dismiss(afterDelay: 3.0)
        } else {
            let newHud: JGProgressHUD = self.createProgressHUD()
            newHud.indicatorView = JGProgressHUDSuccessIndicatorView()
            newHud.textLabel.text = text
            newHud.show(in: view)
            newHud.dismiss(afterDelay: 3.0)
        }
    }
    
    class func showErrorHUD(view: UIView, text: String = "Error") {
        let allHuds: [JGProgressHUD] = JGProgressHUD.allProgressHUDs(in: view) as! [JGProgressHUD]
        if allHuds.count > 0 {
            let hud: JGProgressHUD = allHuds.first!
            hud.indicatorView = JGProgressHUDErrorIndicatorView()
            hud.textLabel.text = text
            hud.dismiss(afterDelay: 3.0)
        } else {
            let newHud: JGProgressHUD = self.createProgressHUD()
            newHud.indicatorView = JGProgressHUDErrorIndicatorView()
            newHud.textLabel.text = text
            newHud.show(in: view)
            newHud.dismiss(afterDelay: 3.0)
        }
    }
    
    class func dismissAllHuds(view: UIView) {
        JGProgressHUD.allProgressHUDs(in: view).forEach{ ($0 as! JGProgressHUD).dismiss() }
    }
    
}
