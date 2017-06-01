//
//  SDPhotoViewer.swift
//  ImageZoomDemo
//
//  Created by Shekhar on 10/26/16.
//  Copyright © 2016 perennial. All rights reserved.
//

import UIKit
import Foundation

private let X_OFFSET              : CGFloat = 50
private let Y_OFFSET              : CGFloat = 20
private let VIEW_ALPHA            : CGFloat = 0.6
private let ANIMATION_DURATION    : TimeInterval = 0.4
private let VIEW_BACKGROUND_COLOR : UIColor = UIColor.black

public class SDPhotoViewer: UIView, UIScrollViewDelegate {
    
    private var zoomedImgView : UIImageView?
    private var originalImageFrame = CGRect()
    private var scrollView : UIScrollView = UIScrollView()
    
    class public func showImageFrom(imageView: UIImageView) {
        if imageView.image != nil {
            
            let objSdImageZoom = SDPhotoViewer()
            objSdImageZoom.showImageFrom(imgView: imageView)
        }
    }
    
    private func getRootView() -> UIView {
        
        var controller : UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!
        
        while ((controller.presentedViewController) != nil) {
            controller = controller.presentedViewController!
        }
        
        return controller.view
    }
    
    private func showImageFrom(imgView: UIImageView) {
        
        self.frame = UIScreen.main.bounds
        self.backgroundColor = VIEW_BACKGROUND_COLOR
        self.alpha = VIEW_ALPHA
        
        self.scrollView.frame = self.bounds
        self.scrollView.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.delegate = self
        self.addSubview(self.scrollView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        let mainView = getRootView()
        let originalFrame = imgView.convert(imgView.bounds, to: mainView)
        
        zoomedImgView = UIImageView(image: imgView.image)
        zoomedImgView?.contentMode = .scaleAspectFit
        originalImageFrame = originalFrame
        zoomedImgView?.frame = originalImageFrame
        
        self.scrollView.addGestureRecognizer(tapGesture)
        
        self.scrollView.addSubview(zoomedImgView!)
        mainView.addSubview(self)
        self.updateScrollViewZoomScales()
        mainView.addSubview(scrollView)
        let zoomedImageWidth = mainView.frame.size.width - (2*Y_OFFSET)
        let zoomedImageHeight = mainView.frame.size.height - (2*X_OFFSET)
        let zoomedFrame = CGRect(x: X_OFFSET, y: Y_OFFSET, width: zoomedImageWidth, height: zoomedImageHeight)
        
        UIView.animate(withDuration: ANIMATION_DURATION, animations: {
            
            self.zoomedImgView?.frame = zoomedFrame
            self.zoomedImgView?.center = self.center
        }) { (completion) in
            
            UIView.animate(withDuration: ANIMATION_DURATION, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                
                self.zoomedImgView?.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
                
                }, completion: nil)
        }
    }
    
    @objc private func handleTapGesture(gesture: UITapGestureRecognizer) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.closeAnimation()
        })
        self.scrollView.setZoomScale(1.0, animated: true)
        CATransaction.commit()
    }
    
    private func closeAnimation() {
        
        let view = getRootView()
        view.isUserInteractionEnabled = false
        UIView.animate(withDuration: ANIMATION_DURATION, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.zoomedImgView?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }) { (completion) in
            
            UIView.animate(withDuration: ANIMATION_DURATION, animations: {
                
                self.zoomedImgView?.frame = self.originalImageFrame
                }, completion: { (completion) in
                    
                    self.scrollView.removeFromSuperview()
                    self.zoomedImgView = nil
                    self.removeFromSuperview()
                    view.isUserInteractionEnabled = true
            })
        }
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.zoomedImgView
    }
    
    private func updateScrollViewZoomScales() {
        self.scrollView.maximumZoomScale = 5.0
        self.scrollView.zoomScale = 1.0
    }
}
