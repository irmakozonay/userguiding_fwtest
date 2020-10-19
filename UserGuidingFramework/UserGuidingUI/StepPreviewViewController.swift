//
//  StepPreviewViewController.swift
//  UserGuidingTest
//
//  Created by Irmak Ozonay on 10/17/20.
//

import UIKit

class StepPreviewViewController: UIViewController {

    init() {
        super.init(nibName: "StepPreviewViewController", bundle: Bundle(for: StepPreviewViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func stepSelected(_ sender: UIButton) {
        UserGuiding.shared.stepSelected()
    }

}
