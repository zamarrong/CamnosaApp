//
//  TiposCambioList.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 04/11/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import Foundation

class TiposCambioList: NSObject {
    var tiposCambio: [TipoCambio] = []
    
    func getItem(_ index: Int) -> TipoCambio {
        return tiposCambio[index]
    }
}

