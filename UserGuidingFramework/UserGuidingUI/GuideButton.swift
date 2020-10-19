//
//  GuideButton.swift
//  UserGuidingTest
//
//  Created by Irmak Ozonay on 10/13/20.
//

import Foundation
import UIKit

class GuideButton: UIButton {
    
    var buttonView: UIView?
    
    init(frame: CGRect, view: UIView) {
        super.init(frame: frame)
        self.buttonView = view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
