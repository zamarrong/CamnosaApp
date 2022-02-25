//
//  TiposCambio.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 06/07/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class Moneda : NSObject {
    var moneda_id: Int?
    var moneda, codigo, simbolo, fecha: String?
    var compra, venta: Double?
    
    override init() {
        super.init()
    }
    
    class func parseList(_ json: JSON) -> [Moneda] {
        var monedas = [Moneda]()
        for (_,subJson):(String, JSON) in json {
            //print(json)
            let moneda = Moneda()
            if let moneda_id = Int(subJson["moneda_id"].string!) {
                moneda.moneda_id = moneda_id
            }
            if let nombre = subJson["moneda"].string {
                moneda.moneda = nombre
            }
            if let codigo = subJson["codigo"].string {
                moneda.codigo = codigo
            }
            if let simbolo = subJson["simbolo"].string {
                moneda.simbolo = simbolo
            }
            if let compra = Double(subJson["tipodecambio"]["compra"].string!) {
                moneda.compra = compra
            }
            if let venta = Double(subJson["tipodecambio"]["venta"].string!) {
                moneda.venta = venta
            }
            if let fecha = subJson["tipodecambio"]["created_at"].string {
                moneda.fecha = fecha
            }
            
            monedas.append(moneda)
        }
        return monedas
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
