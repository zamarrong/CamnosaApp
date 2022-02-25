//
//  APIController.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 06/07/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class APIController {
    class func tipos_cambio(_ monedasList: MonedasList, excluir: Bool, completion: @escaping (Bool) -> Void) {
        var extra: String = "";
        if excluir {
            extra = "?excluir=MXN"
        }
        let url = URL(string: API.apiURL() + "/monedas" + extra)!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                DispatchQueue.main.async {
                    let monedas = Moneda.parseList(r)
                    monedasList.monedas = monedas
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    class func historico(_ id: Int, dias: Int, tiposCambioList: TiposCambioList, completion: @escaping (Bool) -> Void) {
        let url = URL(string: API.apiURL() + "/historico/" + String(id) + "?dias=" + String(dias))!
        let api_call = API(url: url)
        
        api_call.get() { (result) -> Void in
            if let r = result {
                DispatchQueue.main.async {
                    let tiposCambio = TipoCambio.parseList(r)
                    tiposCambioList.tiposCambio = tiposCambio
                    completion(true)
                }
            } else {
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
}
