//
//  FourthViewController.swift
//  onViewControllerResult
//
//  Created by 김경환 on 2022/02/25.
//

import UIKit

class FourthViewController: BaseViewController {
    @IBOutlet var btBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btBack.addAction(for: .touchUpInside) { _ in
            self.setResult(resultCode: .RESULT_OK)
            self.dismiss(animated: true)
        }
    }
    
}
