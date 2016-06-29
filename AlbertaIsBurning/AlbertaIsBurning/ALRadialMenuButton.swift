//
//  ALRadialMenuButton.swift
//  AlbertaIsBurning
//
//  Created by Pouillon Jérémie on 24/05/2016.
//  Copyright © 2016 Pouillon Jérémie. All rights reserved.
//

import UIKit

public typealias ALRadialMenuButtonAction = () -> Void

public class ALRadialMenuButton: UIButton {
    public var action: ALRadialMenuButtonAction? {
        didSet {
            configureAction()
        }
    }
    
    private func configureAction() {
        addTarget(self, action: #selector(performAction), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    internal func performAction() {
        if let a = action {
            a()
        }
    }
}