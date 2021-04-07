//
//  MenuPC.swift
//  FinanceApp
//
//  Created by Андрей Таланчук on 20.03.2021.
//

import UIKit
import RxSwift

class MenuPC: UIPresentationController {
    
    
    let greyView = UIView()
    let bag = DisposeBag()
    var keyboardHeight: CGFloat = 0
    
    func overrideKeyboardHeight(){
        FinanceViewModel.viewModel.keyboardHeight
            .subscribe(onNext: {[weak self] keyboardHeight in
                self?.keyboardHeight = keyboardHeight
            }).disposed(by: bag)
    }
    
    func changeFrameOfPresentedView(){
        FinanceViewModel.viewModel.keyboardHeight
            .subscribe(onNext: {[weak self] keyboardHeight in
                var frameOfPresentedViewInContainerView: CGRect {
                    get {
                        guard let theView = self?.containerView else {
                            return CGRect.zero
                        }
                        return CGRect(x: 0, y: theView.bounds.height - keyboardHeight - 155 - FinanceViewModel.viewModel.secondTxtFieldHeit, width: theView.bounds.width, height: theView.bounds.height)
                    }
                }
                UIView.animate(withDuration: 0.1){
                    self?.containerViewDidLayoutSubviews()
                }
            }).disposed(by: bag)
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        overrideKeyboardHeight()
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
    
    @objc func dismissVC(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
        
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            return CGRect(x: 0, y: theView.bounds.height - keyboardHeight - 155 - FinanceViewModel.viewModel.secondTxtFieldHeit, width: theView.bounds.width, height: theView.bounds.height)
        }
    }
    
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            (UIViewControllerTransitionCoordinatorContext) in
                self.greyView.alpha = 0
            }, completion: { (UIViewControllerTransitionCoordinatorContext) in
                self.greyView.removeFromSuperview()
            })
        }
    override func presentationTransitionWillBegin() {
        self.greyView.alpha = 0
        self.containerView?.addSubview(greyView)
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.greyView.alpha = 0.5
        }, completion: {[weak self] (UIViewControllerTransitionCoordinatorContext) in
           self?.changeFrameOfPresentedView()
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
