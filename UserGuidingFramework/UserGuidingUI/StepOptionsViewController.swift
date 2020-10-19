//
//  StepOptionsViewController.swift
//  UserGuidingTest
//
//  Created by Irmak Ozonay on 10/16/20.
//

import UIKit

class StepOptionsViewController: UIViewController {

    init() {
        super.init(nibName: "StepOptionsViewController", bundle: Bundle(for: StepOptionsViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func stepSelected(_ sender: UIButton) {
        UserGuiding.shared.openStepPreview()
    }

}
