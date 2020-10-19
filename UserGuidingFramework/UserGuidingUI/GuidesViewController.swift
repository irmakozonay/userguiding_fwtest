//
//  GuidesViewController.swift
//  UserGuidingTest
//
//  Created by Irmak Ozonay on 10/16/20.
//

import UIKit

class GuidesViewController: UIViewController {

    init() {
        super.init(nibName: "GuidesViewController", bundle: Bundle(for: GuidesViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func guideTapped(_ sender: Any) {
        self.navigationController?.pushViewController(GuideViewController(), animated: true)
    }

}
