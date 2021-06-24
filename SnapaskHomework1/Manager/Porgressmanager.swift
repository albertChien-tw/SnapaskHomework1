//
//  Porgressmanager.swift
//  SnapaskHomework
//
//  Created by Albert_Chien on 2021/6/24.
//

import SVProgressHUD

class ProgressManager {

    class func dismiss() {
        SVProgressHUD.dismiss()
    }

    class func showPressHUD() {
        SVProgressHUD.setBackgroundLayerColor(UIColor.init(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.1))
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.show()
    }

    class func showPressHUDDarkBackground() {
        SVProgressHUD.setBackgroundLayerColor(UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6))
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.show()
    }

    class func showErrorHUD(withStatus: String?, type: SVProgressHUDMaskType = .none, time: TimeInterval = 1) {
        SVProgressHUD.dismiss()
        SVProgressHUD.setMinimumDismissTimeInterval(time)
        SVProgressHUD.setDefaultMaskType(type)
        SVProgressHUD.showError(withStatus: withStatus)
    }

    class func showSuccessHUD(withStatus: String?) {
        SVProgressHUD.dismiss()
        SVProgressHUD.setMaximumDismissTimeInterval(1)
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.showSuccess(withStatus: withStatus)
    }

    class func showInfoHUD(withStatus: String?, timeInterval: TimeInterval = 1, type: SVProgressHUDMaskType = .custom) {
        SVProgressHUD.dismiss()
        SVProgressHUD.setMaximumDismissTimeInterval(timeInterval)
        SVProgressHUD.setDefaultMaskType(type)
        SVProgressHUD.showInfo(withStatus: withStatus)
    }

    class func showHUD(withStatus: String?, type: SVProgressHUDMaskType = .custom) {
        SVProgressHUD.dismiss()
        SVProgressHUD.setDefaultMaskType(type)
        SVProgressHUD.show(withStatus: withStatus)
    }

    class func showProgress(progress: Float) {
        SVProgressHUD.dismiss()
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.showProgress(progress)
    }
}
