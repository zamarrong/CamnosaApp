//
//  TiposCambio.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 06/07/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class TipoCambio {
    var tipoCambio_id, moneda_id: Int?
    var compra, venta: Double?
    var fecha: Date?
    
    class func parseList(_ json: JSON) -> [TipoCambio] {
        var tiposCambio = [TipoCambio]()
        for (_,subJson):(String, JSON) in json {
            //print(json)
            let tipoCambio = TipoCambio()
            if let tipoCambio_id = Int(subJson["tipoCambio_id"].string!) {
                tipoCambio.tipoCambio_id = tipoCambio_id
            }
            if let moneda_id = Int(subJson["moneda_id"].string!) {
                tipoCambio.moneda_id = moneda_id
            }
            if let compra = Double(subJson["compra"].string!) {
                tipoCambio.compra = compra
            }
            if let venta = Double(subJson["venta"].string!) {
                tipoCambio.venta = venta
            }
            if let fecha = subJson["created_at"].string {
                tipoCambio.fecha = Misc.getStringToNSDate(fecha)
            }
            tiposCambio.append(tipoCambio)
        }
        return tiposCambio
    }
    
    class func parse(_ json: JSON) -> TipoCambio {
        let tipoCambio = TipoCambio()
        if let tipoCambio_id = json["tipoCambio_id"].int {
            tipoCambio.tipoCambio_id = tipoCambio_id
        }
        if let moneda_id = json["moneda_id"].int {
            tipoCambio.moneda_id = moneda_id
        }
        return tipoCambio
    }
}
