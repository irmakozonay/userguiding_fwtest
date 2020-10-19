//
//  UserGuiding.swift
//  UserGuidingFramework
//
//  Created by Irmak Ozonay on 10/19/20.
//

import Foundation
import UIKit

public class UserGuiding: NSObject {
    
    public static let shared = UserGuiding()
        
    override init(){}
    
    var viewController: UIViewController!
    var viewControllerKey: String?
    var viewSubviews: [UIView] = []
    var guideViews: [UIView] = []
    var navigationController: UINavigationController?
    var stepPreviewViewController: StepPreviewViewController?
    
    public func setActiveViewController(_ viewController: UIViewController) {
        self.viewController = viewController
        self.viewControllerKey = viewController.description.slice(from: ".", to: ":")?.appending("UserGuide")
    }
    
    public func manageGuide() {
        print("manage guide")
        if navigationController == nil {
            let guidesViewController = GuidesViewController()
            navigationController = UINavigationController(rootViewController: guidesViewController)
            navigationController!.setNavigationBarHidden(true, animated: false)
        }
        openGuideView()
    }
    
    public func showGuide() {
        addGuide()
    }
    
    public func closeGuideView(){
        if let navigationController = self.navigationController {
            if self.viewController.view.subviews.contains(navigationController.view) {
                navigationController.view.removeFromSuperview()
            }
        }
    }
    
    func openGuideView() {
        if let navigationController = self.navigationController {
            navigationController.view.frame = CGRect(x: 0, y: 0, width: self.viewController.view.frame.size.width - 100, height: self.viewController.view.frame.size.height);
            self.viewController.view.addSubview(navigationController.view)
            self.viewController.addChild(navigationController)
            navigationController.didMove(toParent: self.viewController)
            addCloseButton()
        }
    }
    
    func addCloseButton() {
        if let navigationController = self.navigationController {
            let button = UIButton(frame: CGRect(x: navigationController.view.frame.size.width, y: 100, width: 70, height: 50))
            button.setTitle("X", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .orange
            button.addTarget(self, action:#selector(self.selectGuideSubview), for: .touchUpInside)
            guideViews.append(button)
        }
    }
    
    func openStepPreview() {
        closeGuideView()
        stepPreviewViewController = StepPreviewViewController()
        self.viewController.view.addSubview(stepPreviewViewController!.view)
    }
    
    func stepSelected() {
        stepPreviewViewController?.view.removeFromSuperview()
        stepPreviewViewController = nil
        markSubviews()
    }
    
    func addGuide(){
        let viewPath = self.getViewPath()
        var subview = self.viewController.view.subviews[viewPath[0]]
        for i in 1..<viewPath.count {
            subview = subview.subviews[viewPath[i]]
        }
        let imageView = UIImageView(frame: CGRect(x: subview.frame.origin.x - 10, y: subview.frame.origin.y - 10, width: subview.frame.size.width + 20, height: subview.frame.size.height + 20))
        imageView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.2)
        subview.superview?.addSubview(imageView)
    }
    
    func getViewPath() -> [Int] {
        var viewPath: [Int] = []
        if let key = viewControllerKey {
            if let guideIndexes = UserDefaults.standard.string(forKey: key)?.split(separator: "-") {
                var indexes = guideIndexes
                indexes.reverse()
                for index in indexes {
                    viewPath.append(Int(index)!)
                }
            }
        }
        return viewPath
    }
    
    func markSubviews() {
        if let key = viewControllerKey {
            UserDefaults.standard.removeObject(forKey: key)
        }
        findSubviews(view: self.viewController.view)
        for subview in viewSubviews {
            let imageView = UIImageView(frame: CGRect(x: subview.frame.origin.x - 10, y: subview.frame.origin.y - 10, width: subview.frame.size.width + 20, height: subview.frame.size.height + 20))
            imageView.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.2)
            let button = GuideButton(frame: CGRect(x: imageView.frame.origin.x + imageView.frame.size.width / 2 - 35, y: imageView.frame.origin.y + imageView.frame.size.height / 2 - 25, width: 70, height: 50), view: subview)
            button.setTitle("Select", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action:#selector(self.selectGuideSubview), for: .touchUpInside)
            guideViews.append(button)
            guideViews.append(imageView)
            subview.superview?.addSubview(button)
            subview.superview?.addSubview(imageView)
        }
    }
    
    func findSubviews(view: UIView){
        let subviews = view.subviews
        for subview in subviews {
            findSubviews(view: subview)
            viewSubviews.append(subview)
        }
    }
    
    @IBAction func selectGuideSubview(_ sender: GuideButton) {
        if let actionView = sender.buttonView {
            detectViewSuperviews(actionView)
        }
        for guideView in guideViews {
            guideView.removeFromSuperview()
        }
        guideViews = []
        viewSubviews = []
    }
    
    func detectViewSuperviews(_ view: UIView){
        if let superview = view.superview {
            saveViewPath(view: view, superview: superview)
            if superview != self.viewController.view {
                detectViewSuperviews(superview)
            }
        }
    }
    
    func saveViewPath(view: UIView, superview: UIView){
        if let key = viewControllerKey {
            let defaults = UserDefaults.standard
            var guideIndexes = defaults.string(forKey: key)
            if let subviewIndex = superview.subviews.firstIndex(of: view) {
                if guideIndexes == nil {
                    guideIndexes = "" + String(subviewIndex)
                } else {
                    guideIndexes = guideIndexes! + "-" + String(subviewIndex)
                }
            }
            defaults.set(guideIndexes, forKey: key)
        }
    }
    
    
}

private extension String {

    func slice(from: String, to: String) -> String? {

        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
