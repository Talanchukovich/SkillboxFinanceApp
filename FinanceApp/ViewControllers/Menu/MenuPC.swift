//
//  MenuPC.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 20.03.2021.
//

import UIKit

extension MenuPC: ObserverProtocol{
    func transferKeyboardHeight(keyboardHeight: CGFloat) {
        changeFrame(keyboardHeight: keyboardHeight)
    }
    
    
}

class MenuPC: UIPresentationController {
    
    let greyView = UIView()
    
    @objc func dismissVC(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    func changeFrame(keyboardHeight: CGFloat){
        var frameOfPresentedViewInContainerView: CGRect {
            get {
                guard let theView = containerView else {
                    return CGRect.zero
                }
                return CGRect(x: 0, y: theView.bounds.height - KeyboardProperties.shared.keyboardHeight - 155 - KeyboardProperties.shared.secondTxtFieldHeit, width: theView.bounds.width, height: theView.bounds.height - keyboardHeight - 155 - KeyboardProperties.shared.secondTxtFieldHeit)
            }
        }
        UIView.animate(withDuration: 0.1){
            self.containerViewDidLayoutSubviews()
        }
    }
    
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        greyView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let layer0 = CALayer()
        layer0.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        if let compositingFilter = CIFilter(name: "CIMultiplyBlendMode") {
            layer0.compositingFilter = compositingFilter
        }
        layer0.bounds = greyView.bounds
        layer0.position = greyView.center
        greyView.layer.addSublayer(layer0)
        greyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        greyView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissVC))
        greyView.addGestureRecognizer(tapGestureRecognizer)
       
        }
        
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }

            return CGRect(x: 0, y: theView.bounds.height - KeyboardProperties.shared.keyboardHeight - 155 - KeyboardProperties.shared.secondTxtFieldHeit, width: theView.bounds.width, height: theView.bounds.height - KeyboardProperties.shared.keyboardHeight - 155 - KeyboardProperties.shared.secondTxtFieldHeit)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            (UIViewControllerTransitionCoordinatorContext) in
                self.greyView.alpha = 0
            }, completion: { (UIViewControllerTransitionCoordinatorContext) in
                self.greyView.removeFromSuperview()
                Notificator.shared.removeObserver(self)
            })
        }
        override func presentationTransitionWillBegin() {
            self.greyView.alpha = 0
            self.containerView?.addSubview(greyView)
            self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
                self.greyView.alpha = 0.5
            }, completion: { (UIViewControllerTransitionCoordinatorContext) in
                Notificator.shared.addObserver(self)
            })
        }
        override func containerViewWillLayoutSubviews() {
            super.containerViewWillLayoutSubviews()
            presentedView!.layer.masksToBounds = true
        }
        override func containerViewDidLayoutSubviews() {
            super.containerViewDidLayoutSubviews()
            self.presentedView?.frame = frameOfPresentedViewInContainerView
            greyView.frame = containerView!.bounds
        }
}
