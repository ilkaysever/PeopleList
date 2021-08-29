//
//  LoadingExtension.swift
//  Scorp_Case
//
//  Created by İlkay Sever on 27.08.2021.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class LoadingView {
    
    var loading: NVActivityIndicatorView = {
        let loadingView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 88, width: 50, height: 50))
        loadingView.backgroundColor = UIColor.red
        return loadingView
    }()
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        
//    }
    
    func startLoading() {
        loading.type = .ballClipRotateMultiple
        loading.color = .yellow
        loading.startAnimating()
    }
    
    func stopLoading() {
        loading.stopAnimating()
    }
    
}
