//
//  TextClear.swift
//  OOProfitFinal
//
//  Created by Anan Yousef on 21/03/2021.
//

import Foundation
import UIKit

class TextClear: NSObject ,UITextFieldDelegate  {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
        
    }
