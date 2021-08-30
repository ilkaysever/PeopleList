//
//  UIViewControllerExtension.swift
//  Scorp_Case
//
//  Created by İlkay Sever on 27.08.2021.
//

import UIKit

extension UIViewController {
    
    //MARK: - Alert Action
    /// Single Button Alert Actiton
    func showSingleAlertAction(title: String, message: String, completion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}
