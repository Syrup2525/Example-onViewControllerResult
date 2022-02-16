//
//  ViewController.swift
//  onViewControllerResult
//
//  Created by 김경환 on 2022/02/16.
//

import UIKit

class FirstViewController: BaseViewController {
    @IBOutlet var lbRequestView: UILabel!
    
    @IBOutlet var tfDataA: UITextField!
    @IBOutlet var tfDataB: UITextField!
    @IBOutlet var tfDataC: UITextField!
    
    @IBOutlet var btPerformSegueA: UIButton!
    @IBOutlet var btPerformSegueB: UIButton!
    
    private let REQUEST_SECOND_VIEW_CONTROLLER = 10000
    private let REQUEST_THIRD_VIEW_CONTROLLER = 10001
    
    private let SECOND_SEGUE = "SecondSegue"
    private let THIRD_SEGUE = "ThirdSegue"
    
    public static let EXAMPLE_OBJECT = "example_obejct"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    private func initLayout() {
        btPerformSegueA.addAction(for: .touchUpInside) { _ in
            self.sendDataAndPerformSegue(withIdentifier: self.SECOND_SEGUE, requestCode: self.REQUEST_SECOND_VIEW_CONTROLLER)
        }
        
        btPerformSegueB.addAction(for: .touchUpInside) { _ in
            self.sendDataAndPerformSegue(withIdentifier: self.THIRD_SEGUE, requestCode: self.REQUEST_THIRD_SEGUE)
        }
    }

    private func sendDataAndPerformSegue(withIdentifier: String, requestCode: Int) {
        var exampleObject = ExampleObject()
        exampleObject.a = self.tfDataA.text
        exampleObject.b = self.tfDataB.text
        exampleObject.c = self.tfDataC.text
        
        var sender = [String:Any]()
        sender.updateValue(exampleObject, forKey: FirstViewController.EXAMPLE_OBJECT)
        
        self.performSegue(withIdentifier: withIdentifier, sender: sender, requestCode: requestCode)
    }
}

extension FirstViewController: OnViewControllerResult {
    func onViewControllerResult(requestCode: Int?, resultCode: ResultCode?, data: [String : Any]?) {
        if let exampleObject = data?[FirstViewController.EXAMPLE_OBJECT] as? ExampleObject {
            tfDataA.text = exampleObject.a
            tfDataB.text = exampleObject.b
            tfDataC.text = exampleObject.c
        }
        
        switch requestCode {
        case REQUEST_SECOND_VIEW_CONTROLLER:
            lbRequestView.text = "REQUEST_SECOND_VIEW_CONTROLLER"
            break
            
        case REQUEST_THIRD_VIEW_CONTROLLER:
            lbRequestView.text = "REQUEST_THIRD_VIEW_CONTROLLER"
            break
            
        default:
            break
        }
    }
}
