//
//  CirclePresenter.swift
//  Memories
//
//  Created by Jérémie Pouillon on 23/07/2017.
//  Copyright © 2017 Jérémie Pouillon. All rights reserved.
//

import Foundation

protocol CircleViewProtocol: class {
    var presenter: CirclePresenterProtocol { get }
}

protocol CirclePresenterProtocol {
    var view: CircleViewProtocol! { get }
    
    init(view: CircleViewProtocol)
    func topAreaClicked()
    func bottomAreaClicked()
    func leftAreaClicked()
    func rightAreaClicked()
    func centerAreaClicked()
}

class CirclePresenter: CirclePresenterProtocol {
    weak var view: CircleViewProtocol!
    
    required init(view: CircleViewProtocol) {
        self.view = view
    }
    
    // MARK: - CirclePresenterProcotol
    
    internal func topAreaClicked() {
        <#code#>
    }
    
    internal func bottomAreaClicked() {
        <#code#>
    }
    
    internal func leftAreaClicked() {
        <#code#>
    }
    
    internal func rightAreaClicked() {
        
    }
    
    internal func centerAreaClicked() {
        <#code#>
    }
}
