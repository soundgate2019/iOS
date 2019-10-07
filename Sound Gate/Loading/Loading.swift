//
//  Loading.swift
//  Chuck Norris 🤯
//
//  Created by Matheus Martins on 29/08/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit
import Lottie

class Loading {
    
    let animationView = LOTAnimationView()
    let backGroundView = UIView()
    
    func playAnimations(view: UIView) {
        view.addSubview(backGroundView)
        backGroundView.translatesAutoresizingMaskIntoConstraints = false
        backGroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backGroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backGroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backGroundView.backgroundColor = UIColor(red: 195/255, green: 240/255, blue: 67/255, alpha: 1)
        
        view.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        animationView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        animationView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        animationView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        animationView.contentMode = .scaleToFill
        animationView.setAnimation(named: "LoadingLottie")
        animationView.loopAnimation = true
        animationView.play()
    }
    
    func stopAnimation() {
        animationView.stop()
        animationView.removeFromSuperview()
        backGroundView.removeFromSuperview()
    }
}
