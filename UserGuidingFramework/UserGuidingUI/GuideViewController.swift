//
//  GuideViewController.swift
//  UserGuidingTest
//
//  Created by Irmak Ozonay on 10/16/20.
//

import UIKit

class GuideViewController: UIViewController {

    init() {
        super.init(nibName: "GuideViewController", bundle: Bundle(for: GuideViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addStep(_ sender: UIButton) {
        self.navigationController?.pushViewController(StepOptionsViewController(), animated: true)
    }

}
