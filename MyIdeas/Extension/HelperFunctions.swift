//
//  HelperFunctions.swift
//  MyIdeas
//
//  Created by Асельдер Гаджиев on 20.07.2021.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    func sd_setImageWithLoader(_ imageUrl: URL, type: String, activityView: UIActivityIndicatorView) {
        
        let PhotoPlug = UIImage(named: "noImagePlug")
        
        if type != "PhotosCell" {
            self.image = nil
        }
        
        activityView.startAnimating()
        
        DispatchQueue.global(qos: .background).async { [weak self] () -> Void in
            
            SDWebImageManager.shared.loadImage(with: imageUrl, options: [.retryFailed, .avoidAutoSetImage], progress: nil, completed: { [weak self] (image, _, error, cacheType, success, url) -> Void in
                
                activityView.stopAnimating()
                
                if image == nil {
                    self?.image = PhotoPlug
                }
                
                if success == false {
                    return
                }
                
                let shouldAnimate = cacheType == .none
                
                if image != nil {
                    self?.image = image
                }
                
                if shouldAnimate == true {
                    
                    let transition = CATransition()
                    
                    transition.duration = 0.5
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                    transition.type = CATransitionType.fade
                    
                    self?.layer.add(transition, forKey: nil)
                    activityView.layer.add(transition, forKey: nil)
                }
                })
        }
    }
}
