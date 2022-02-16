//
//  OnViewControllerResult.swift
//  onViewControllerResult
//
//  Created by 김경환 on 2022/02/16.
//

import Foundation

protocol OnViewControllerResult {
    func onViewControllerResult(requestCode: Int?, resultCode: ResultCode?, data: [String:Any]?)
}
