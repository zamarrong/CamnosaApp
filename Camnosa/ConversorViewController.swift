//
//  ConversorViewController.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 20/10/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class ConversorViewController: UIViewController {
    
    let monedasList = MonedasList()

    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var currency1TextField: UITextFieldWithPickerView!
    @IBOutlet weak var currency2TextField: UITextFieldWithPickerView!
    @IBOutlet weak var conversionLabel: UILabel!
    @IBOutlet weak var conversionReverseLabel: UILabel!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor(red: 6/255, green: 204/255, blue: 88/255, alpha: 1.0);
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        addDoneButtonOnNumpad(quantityTextField)
        
        loadCurrencies()
    }
    
    
    @IBAction func switchButton(_ sender: AnyObject) {
        let c1 = (self.monedasList.getItem(self.currency1TextField.selectedRow()).moneda_id)!
        let c2 = (self.monedasList.getItem(self.currency2TextField.selectedRow()).moneda_id)!
        
        self.currency1TextField.selectRow(self.monedasList.monedas.index(where: {$0.moneda_id == c2})!)
        self.currency2TextField.selectRow(self.monedasList.monedas.index(where: {$0.moneda_id == c1})!)
    }
    
    @IBAction func convertButton(_ sender: AnyObject) {
        if (quantityTextField.text == "") {
            quantityTextField.text = "1"
        }
        
        let q1 = Double(quantityTextField.text!)! * (self.monedasList.getItem(self.currency1TextField.selectedRow()).venta)!
        
        conversionLabel.text = quantityTextField.text! + " " + (self.monedasList.getItem(self.currency1TextField.selectedRow()).codigo)! + " = " + Misc.getDoubleToCurrency(q1 / (self.monedasList.getItem(self.currency2TextField.selectedRow()).venta)!) + " " + (self.monedasList.getItem(self.currency2TextField.selectedRow()).codigo)!
        
        conversionReverseLabel.text = "1 " + (self.monedasList.getItem(self.currency1TextField.selectedRow()).moneda)! + " = " + Misc.getDoubleToCurrency((self.monedasList.getItem(self.currency1TextField.selectedRow()).venta)! / (self.monedasList.getItem(self.currency2TextField.selectedRow()).venta)!) + " " + (self.monedasList.getItem(self.currency2TextField.selectedRow()).moneda)! + "\n" + "1 " + (self.monedasList.getItem(self.currency2TextField.selectedRow()).moneda)! + " = " + Misc.getDoubleToCurrency((self.monedasList.getItem(self.currency2TextField.selectedRow()).venta)! / (self.monedasList.getItem(self.currency1TextField.selectedRow()).venta)!) + " " + (self.monedasList.getItem(self.currency1TextField.selectedRow()).moneda)!
    }
    
    func loadCurrencies() {
        let loadingIndicator = LoadingIndicator(text: Strings.getLoadingString())
        self.view.addSubview(loadingIndicator)
         APIController.tipos_cambio(self.monedasList, excluir: false){(r) -> Void in
            if r {
                //Currency 1
                self.currency1TextField.pickViewOptions = self.monedasList.monedas.map({ (Moneda) -> String in
                    return Moneda.moneda!
                })
                //Currency 2
                self.currency2TextField.pickViewOptions = self.monedasList.monedas.map({ (Moneda) -> String in
                    return Moneda.moneda!
                })
                if (self.monedasList.monedas.count > 0) {
                    self.currency1TextField.selectRow(self.monedasList.monedas.index(where: {$0.moneda_id == 1})!)
                    self.currency2TextField.selectRow(self.monedasList.monedas.index(where: {$0.moneda_id == 5})!)
                }
            }
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func addDoneButtonOnNumpad(_ textField: UITextField) {
        let keypadToolbar: UIToolbar = UIToolbar()
        keypadToolbar.barTintColor = UIColor(red: 255/255, green: 212/255, blue: 99/255, alpha: 1.0);
        // add a done button to the numberpad
        keypadToolbar.items=[
            UIBarButtonItem(title: "Ok", style: UIBarButtonItemStyle.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        ]
        
        keypadToolbar.tintColor = UIColor.white
        keypadToolbar.sizeToFit()
        // add a toolbar with a done button above the number pad
        textField.inputAccessoryView = keypadToolbar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
