//
//  AddNewClaimVC.swift
//  ClaimsProject
//
//  Created by Lijauco, Carlo Cedric on 07/09/2016.
//  Copyright © 2016 arvato. All rights reserved.
//

import UIKit

class AddNewClaimVC: UIViewController {

    @IBOutlet weak var documentDateTextField: CustomUITextField!
    @IBOutlet weak var postingDateTextField: CustomUITextField!
    @IBOutlet weak var claimTypeTextField: CustomUITextField!
    @IBOutlet weak var costCenterTextField: CustomUITextField!
    @IBOutlet weak var projectIDTextField: CustomUITextField!
    @IBOutlet weak var GSTRelevantTextField: CustomUITextField!
    @IBOutlet weak var amountTextField: CustomUITextField!
    @IBOutlet weak var currencyTextField: CustomUITextField!
    @IBOutlet weak var rateTextField: CustomUITextField!
    @IBOutlet weak var itemTextField: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!

    private var datePickerView:UIDatePicker?
    private var toolbar:UIToolbar?
    private var normalPickerView:UIPickerView?
    private var normalPickerComponent = []
    private var activeTextField:UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        documentDateTextField.delegate = self
        postingDateTextField.delegate = self
        claimTypeTextField.delegate = self
        costCenterTextField.delegate = self
        projectIDTextField.delegate = self
        GSTRelevantTextField.delegate = self
        amountTextField.delegate = self
        currencyTextField.delegate = self
        rateTextField.delegate = self
        itemTextField.delegate = self

        createDatePicker()
        createNormalPicker()
        createToolBar()

        self.addToolBar(itemTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func createDatePicker() {
        datePickerView = UIDatePicker()
        datePickerView!.datePickerMode = UIDatePickerMode.Date
        datePickerView!.addTarget(self, action: Selector("datePickerValueChanged:"), forControlEvents: UIControlEvents.ValueChanged)
    }

    private func createNormalPicker() {
        normalPickerView = UIPickerView()
        normalPickerView!.delegate = self
    }

    private func showDatePicker(textField:UITextField) {
        textField.inputView = datePickerView
        self.addToolBar(textField)
    }

    private func showNormalPicker(textField:UITextField) {
        textField.inputView = normalPickerView
        self.addToolBar(textField)
    }

    @objc private func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"

        if documentDateTextField.isFirstResponder(){
            documentDateTextField.text = dateFormatter.stringFromDate(sender.date)
        } else if postingDateTextField.isFirstResponder(){
            postingDateTextField.text = dateFormatter.stringFromDate(sender.date)
        }
    }

    private func createToolBar() {
        let barButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action:Selector("doneAction"))

        let fixedItemSpaceWidth = UIBarButtonItem(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        let screenWidth = UIScreen.mainScreen().bounds.width
        fixedItemSpaceWidth.width = screenWidth - 80

        toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        toolbar?.items = [fixedItemSpaceWidth,barButton]
    }

    private func addToolBar(textField:UITextField) {
        textField.inputAccessoryView = toolbar;
    }

    private func addToolBar(textView:UITextView) {
        textView.inputAccessoryView = toolbar;
    }

    @objc private func doneAction() {
        if activeTextField?.isFirstResponder() == true{
            activeTextField?.resignFirstResponder()
        }
        else{
            itemTextField.resignFirstResponder()
        }
    }

    @IBAction func submitClaim(){
        EmailManager.sharedInstance.sendEmail(recipients: ["carlocedriclijauco@live.com"], subject: "this is a subject", messageBody: "body", inViewController: self)
    }
}


extension AddNewClaimVC : UITextFieldDelegate{

    func textFieldDidBeginEditing(textField: UITextField) {
       // textField.inputAccessoryView = toolbar
        activeTextField = textField
        if textField == documentDateTextField || textField == postingDateTextField{
            showDatePicker(textField)
        }
        else if textField == claimTypeTextField || textField == costCenterTextField || textField == projectIDTextField || textField == currencyTextField{
            showNormalPicker(textField)
        }
        else{
            self.addToolBar(textField)
        }

        //Scroll to Textfield
        let frame = textField.convertRect(textField.frame, fromView:self.scrollView)
        let point = CGPointMake(0,((frame.origin.y * (-1)) - 60.0))
        scrollView.setContentOffset(point, animated: true)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == itemTextField{
            textField.text = "\(textField.text!)\n"
            return false
        }
        else{
            textField.resignFirstResponder()
            return true
        }
    }

    func textFieldDidEndEditing(textField: UITextField) {
        textField.resignFirstResponder()
    }

}

extension AddNewClaimVC : UIPickerViewDelegate{
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return normalPickerComponent[row] as? String
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeTextField?.text = normalPickerComponent[row] as? String
    }
}

extension AddNewClaimVC : UIPickerViewDataSource{
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {

        if claimTypeTextField.isFirstResponder(){
            normalPickerComponent = Constants.listOfClaims
        }
        else if costCenterTextField.isFirstResponder(){
            normalPickerComponent = Constants.listOfCostCenter
        }

        else if projectIDTextField.isFirstResponder(){
            normalPickerComponent = Constants.listOfProjectID
        }
        else if currencyTextField.isFirstResponder(){
            normalPickerComponent = Constants.listOfCurrency
        }
        else{
            normalPickerComponent = []
        }

        return normalPickerComponent.count
    }
    
}

extension AddNewClaimVC: UITextViewDelegate{

    func textViewDidEndEditing(textView: UITextView) {
        textView.resignFirstResponder()
    }

    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        return true
    }

}



