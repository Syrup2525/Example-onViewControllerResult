//
//  SecondViewController.swift
//  onViewControllerResult
//
//  Created by 김경환 on 2022/02/16.
//

import UIKit

class SecondViewController: BaseViewController {
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var tfDataA: UITextField!
    @IBOutlet var tfDataB: UITextField!
    @IBOutlet var tfDataC: UITextField!
    
    @IBOutlet var btRequestFourth: UIButton!
    @IBOutlet var btBack: UIButton!
    
    private let REQUEST_FOURTH_VIEW_CONTROLLER = 20000
    
    private let FOURTH_SEGUE = "FourthSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        initData()
    }
    
    private func initLayout() {
        lbTitle.text = "This is Second View"
        
        btRequestFourth.addAction(for: .touchUpInside) { _ in
            self.performSegue(withIdentifier: self.FOURTH_SEGUE, sender: nil, requestCode: self.REQUEST_FOURTH_VIEW_CONTROLLER)
        }
        
        btBack.addAction(for: .touchUpInside) { _ in
            var exampleObject = ExampleObject()
            exampleObject.a = self.tfDataA.text
            exampleObject.b = self.tfDataB.text
            exampleObject.c = self.tfDataC.text
            
            var data = [String:Any]()
            data.updateValue(exampleObject, forKey: FirstViewController.EXAMPLE_OBJECT)
            
            self.setResult(resultCode: .RESULT_OK, data: data)
            self.dismiss(animated: true)
        }
    }
    
    private func initData() {
        guard
            let sender = getSender(),
            let exampleObject = sender[FirstViewController.EXAMPLE_OBJECT] as? ExampleObject
        else {
            print("guard else block")
            return
        }
        
        tfDataA.text = exampleObject.a
        tfDataB.text = exampleObject.b
        tfDataC.text = exampleObject.c
    }
}

extension SecondViewController: OnViewControllerResult {
    func onViewControllerResult(requestCode: Int?, resultCode: ResultCode?, data: [String : Any]?) {
        if resultCode == .RESULT_OK {
            switch requestCode {
            case REQUEST_FOURTH_VIEW_CONTROLLER:
                lbTitle.text = "Result FOURTH_VIEW"
                break
                
            default:
                break
            }
        }
    }
    
}
