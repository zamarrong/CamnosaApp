//
//  MonedasList.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 06/07/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class MonedasList: NSObject {
    var monedas: [Moneda] = []
    
    func getItem(_ index: Int) -> Moneda {
        return monedas[index]
    }
    
}

extension MonedasList : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monedas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Currency", for: indexPath) as! CustomTableViewCell
        let moneda = monedas[indexPath.row]

        cell.CurrencyNameLabel.text = moneda.moneda
        
        let dateString = moneda.fecha
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString!)
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = DateComponentsFormatter.UnitsStyle.full
        formatter.includesApproximationPhrase = false
        formatter.includesTimeRemainingPhrase = false
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]
        
        if let pastDate = date {
            let dateRelativeString = formatter.string(from: pastDate, to: Date())
            cell.DateLabel.text = "hace " + dateRelativeString!
        }
        
        cell.BuyLabel.text = "Compra: " + Misc.getDoubleToCurrency(moneda.compra!)
        cell.SellLabel.text = "Venta: " + Misc.getDoubleToCurrency(moneda.venta!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        monedas.remove(at: indexPath.row)
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
        tableView.endUpdates()
    }
}

