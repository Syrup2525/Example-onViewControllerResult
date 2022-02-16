//
//  SecondViewController.swift
//  onViewControllerResult
//
//  Created by 김경환 on 2022/02/16.
//

import UIKit

class SecondViewController: BaseViewController {
    @IBOutlet var tfDataA: UITextField!
    @IBOutlet var tfDataB: UITextField!
    @IBOutlet var tfDataC: UITextField!
    
    @IBOutlet var btBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        initData()
    }
    
    private func initLayout() {
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
