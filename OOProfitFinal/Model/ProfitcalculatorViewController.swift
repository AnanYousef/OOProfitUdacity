//
//  ViewController.swift
//  OOProfitFinal
//
//  Created by Anan Yousef on 21/03/2021.
//

import Foundation
import UIKit


class ProfitcalculatorViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UITableViewDelegate {

    
    
    @IBOutlet weak var ResetButton: UIBarButtonItem!
    @IBOutlet weak var SaveButton: UIBarButtonItem!
    @IBOutlet weak var profit: UILabel!
    @IBOutlet weak var milesTextField: UITextField!
    @IBOutlet weak var loadPayTextField: UITextField!
    @IBOutlet weak var dispatchFee: UITextField!
    @IBOutlet weak var mpg: UITextField!
    @IBOutlet weak var fuelCost: UITextField!
    @IBOutlet weak var calculateButton: UIButton!

    let textDelegate = TextClear()
    
    
    

    override func viewDidLoad() {

        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(calculateButton(_:)))
        
        
        initializeTextField(textField: milesTextField, text: "")
        initializeTextField(textField: loadPayTextField, text: "")
        initializeTextField(textField: dispatchFee, text: "")
        initializeTextField(textField: mpg, text: "")
        initializeTextField(textField: fuelCost, text: "")

        addDoneButtonOnKeyboard()
        calculateButton.isEnabled = true
        subscribeToKeyboardNotification()
        
        
       
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        
    }
    
    

    func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()
        milesTextField.inputAccessoryView = doneToolbar
        loadPayTextField.inputAccessoryView = doneToolbar
        dispatchFee.inputAccessoryView = doneToolbar
        mpg.inputAccessoryView = doneToolbar
        fuelCost.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            milesTextField.resignFirstResponder()
            loadPayTextField.resignFirstResponder()
            dispatchFee.resignFirstResponder()
            mpg.resignFirstResponder()
            fuelCost.resignFirstResponder()
        }

    func initializeTextField(textField: UITextField, text: String) {
        textField.delegate = textDelegate
        textField.text = text
        textField.textAlignment = .center
        
    }
    
    func calculate() {
        
        if let milesTextConv = Double(milesTextField.text ?? ""),
           let loadPayTextFieldConv = Double(loadPayTextField.text!),
           let dispatchFeeConv = Double(dispatchFee.text!),
           let truckMpgConv: Double = Double(mpg.text!),
           let fuelCostConv: Double = Double(fuelCost.text!)
         {
         let calculate1: Int = Int((milesTextConv / truckMpgConv) * (fuelCostConv) + (loadPayTextFieldConv * dispatchFeeConv / 100))
         
         let calculate2: Int = Int(loadPayTextFieldConv) - calculate1
         profit.text = String("$\(calculate2)")
        } else {
         showAlertForCalculateButton()
        }
    }
    
    
 
    @IBAction func calculateButton(_ sender: AnyObject) {
        
        calculate()
    }
    
    
    func showAlertForCalculateButton() {

    let alert = UIAlertController(title: "Please fill empty field", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
        print("tapped Dismiss")
        
    }))
    present(alert, animated: true)
}
    
    func showAlertForSaveButton() {

    let alert = UIAlertController(title: "Load Saved", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
        print("tapped Dismiss")
        
    }))
    present(alert, animated: true)
}
    
    

    @IBAction func Save(_ sender: UIBarButtonItem) {
        let profitText = (self.profit.text ?? "").replacingOccurrences(of: "$", with: "")
        
        let profit = Profit(loadPay: Int(self.loadPayTextField.text ?? "") ?? 0 , profit: Int(profitText) ?? 0)
        
        UserDefaulsManager.shared.addProfit(profit)
        

        showAlertForSaveButton()
   
    }

    @IBAction func Reset(_ sender: UIBarButtonItem) {
        
        milesTextField.text = ""
        loadPayTextField.text = ""
        dispatchFee.text = ""
        mpg.text = ""
        fuelCost.text = ""
        profit.text = ""
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if fuelCost.isFirstResponder || mpg.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}
 
   

