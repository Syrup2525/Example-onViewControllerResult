//
//  BaseViewController.swift
//  daegudelivery
//
//  Created by 김경환 on 2022/02/16.
//

import UIKit

class BaseViewController: UIViewController {
    private var onViewControllorRequestCode: Int?
    private var onViewControllerResultCode: ResultCode?
    private var onViewControllerResultData: [String:Any]?
    
    private var senderData: [String:Any]?
    
    private var presentingViewControllerData: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presentingViewControllerData = presentingViewController
        
        super.viewWillAppear(animated)
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag) {
            completion?()
            
            if let viewController = self.presentingViewControllerData as? OnViewControllerResult {
                viewController.onViewControllerResult(requestCode: self.onViewControllorRequestCode, resultCode: self.onViewControllerResultCode, data: self.onViewControllerResultData)
            }
        }
    }
    
    func performSegue(withIdentifier identifier: String, sender: Any?, requestCode: Int) {
        onViewControllorRequestCode = requestCode
        
        super.performSegue(withIdentifier: identifier, sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destinationViewController = segue.destination as? BaseViewController
        else {
            return
        }
        
        // sender 데이터 전송
        destinationViewController.senderData = sender as? [String:Any]
        
        // 목적지 viewController 에 현재 requestCode 삽입
        destinationViewController.onViewControllorRequestCode = onViewControllorRequestCode
    }
    
    func setResult(resultCode: ResultCode) {
        onViewControllerResultCode = resultCode
    }
    
    func setResult(resultCode: ResultCode, data: [String:Any]) {
        onViewControllerResultCode = resultCode
        onViewControllerResultData = data
    }
    
    func getSender() -> [String:Any]? {
        return senderData
    }
}
