//
//  BaseViewController.swift
//  daegudelivery
//
//  Created by 김경환 on 2022/02/16.
//

import UIKit

class BaseViewController: UIViewController {
    private var onViewControllorRequestCode: Int?
    private var onViewControllerReverseRequestCode: Int?
    private var onViewControllerResultCode: ResultCode?
    private var onViewControllerResultData: [String:Any]?
    private var senderData: [String:Any]?
    private var presentingViewControllerData: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    final override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presentingViewControllerData = presentingViewController
        
        onViewWillAppear()
    }
    
    func onViewWillAppear() {  }
    
    final override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) {
            completion?()
            
            if let viewController = self.presentingViewControllerData as? OnViewControllerResult {
                viewController.onViewControllerResult(requestCode: self.onViewControllerReverseRequestCode, resultCode: self.onViewControllerResultCode, data: self.onViewControllerResultData)
            }
        }
    }
    
    final func performSegue(withIdentifier identifier: String, sender: Any?, requestCode: Int) {
        onViewControllorRequestCode = requestCode
        
        super.performSegue(withIdentifier: identifier, sender: sender)
    }
    
    final override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationViewController = segue.destination as? BaseViewController
        else {
            return
        }
        
        // sender 데이터 전송
        destinationViewController.senderData = sender as? [String:Any]
        
        // 목적지 viewController 에 현재 requestCode 삽입
        destinationViewController.onViewControllerReverseRequestCode = onViewControllorRequestCode
    }
    
    final func setResult(resultCode: ResultCode) {
        onViewControllerResultCode = resultCode
    }
    
    final func setResult(resultCode: ResultCode, data: [String:Any]) {
        onViewControllerResultCode = resultCode
        onViewControllerResultData = data
    }
    
    final func getSender() -> [String:Any]? {
        return senderData
    }
}
