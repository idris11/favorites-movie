//
//  ExtensionUIView.swift
//  favorites-movie
//
//  Created by Idris on 20/02/20.
//  Copyright © 2020 Idris-labs. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
	func startIndicatorView(view: UIView) {
		let backgroundSpinner = UIView.init(frame: view.bounds)
    backgroundSpinner.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.1)
    
    let loadingView: UIView = UIView()
    loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    loadingView.center = view.center
    loadingView.backgroundColor = UIColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.6)
    loadingView.clipsToBounds = true
    loadingView.layer.cornerRadius = 10
    
    
    let ai : UIActivityIndicatorView = UIActivityIndicatorView()
    ai.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		if #available(iOS 13.0, *) {
			ai.style = UIActivityIndicatorView.Style.large
		} else {
			// Fallback on earlier versions
		}
    ai.center = CGPoint(x: loadingView.frame.size.width/2, y: loadingView.frame.size.height/2)
    
    
		loadingView.tag = 99
		backgroundSpinner.tag = 100
		loadingView.addSubview(ai)
		backgroundSpinner.addSubview(loadingView)
		view.addSubview(backgroundSpinner)
		view.bringSubviewToFront(backgroundSpinner)
		view.bringSubviewToFront(ai)
		ai.startAnimating()
    
	}
	
	func stopIndikatorView(view: UIView) {
    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
      view.viewWithTag(99)?.removeFromSuperview()
      view.viewWithTag(100)?.removeFromSuperview()
    }
  }
}
