//
//  HistoricoViewController.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 03/11/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit
import Charts

class HistoricoViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var monedaLabel: UILabel!
    @IBOutlet weak var lineChartView: LineChartView!
    var tiposCambioList = TiposCambioList()
    var moneda: Moneda?
    var dias: [String]!
    var tiposCambio: [Double]!
    var promedio: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor(red: 6/255, green: 204/255, blue: 88/255, alpha: 1.0);
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        // Do any additional setup after loading the view.
        self.lineChartView.chartDescription?.textColor = UIColor.white
        self.lineChartView.gridBackgroundColor = UIColor(red: 102/255, green: 102/255, blue: 102/255, alpha: 1.0)
        self.lineChartView.chartDescription?.text = ""
        self.lineChartView.noDataText = "Aún no hay datos suficientes para mostrar la gráfica."
        self.monedaLabel.text = moneda?.moneda!
        loadHistorico((moneda?.moneda_id!)!,d: 7)
    }
    
    func loadHistorico(_ id: Int, d: Int) {
        let loadingIndicator = LoadingIndicator(text: "Cargando...")
        self.view.addSubview(loadingIndicator)
        dias = []
        tiposCambio = []
        APIController.historico(id, dias: d, tiposCambioList: tiposCambioList) {(h) -> Void in
            var suma: Double = 0;
            for (_, element) in self.tiposCambioList.tiposCambio.enumerated() {
                suma = suma + element.venta!
                self.dias.append(Misc.getNSDateToString(element.fecha!))
                self.tiposCambio.append(element.venta!)
            }
            self.promedio = suma / Double(self.tiposCambioList.tiposCambio.count)
            self.setChart(self.dias, values: self.tiposCambio)
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func setChart(_ dataPoints: [String], values: [Double]) {
            // 1 - creating an array of data entries
            var yVals1 : [ChartDataEntry] = [ChartDataEntry]()
            
            for i in 0 ..< dataPoints.count {
                yVals1.append(ChartDataEntry(x: values[i], y: Double(i)))
            }
            
            // 2 - create a data set with our array
            let set1: LineChartDataSet = LineChartDataSet(values: yVals1, label: "Tipo de cambio")
            lineChartView.legend.textColor = UIColor.white
            //set1.highlightColor = UIColor.whiteColor()
            set1.axisDependency = .left // Line will correlate with left axis values
            lineChartView.xAxis.labelPosition = .bottom
            //remove xAxis line
            lineChartView.xAxis.drawGridLinesEnabled = false
            lineChartView.xAxis.drawAxisLineEnabled = false
            lineChartView.xAxis.labelTextColor = UIColor.white
            lineChartView.leftAxis.labelTextColor = UIColor.white
            lineChartView.rightAxis.drawLabelsEnabled = false
            set1.setColor(UIColor(red: 6/255, green: 204/255, blue: 88/255, alpha: 1.0))
            //set1.setCircleColor(UIColor(red: 253/255, green: 212/255, blue: 99/255, alpha: 1.0))
            set1.lineWidth = 2.0
            //set1.circleRadius = 4.0 // the radius of the node circle
            set1.drawFilledEnabled = true
            //remove coordinate circles
            set1.drawCirclesEnabled = false
            set1.mode = .cubicBezier
            //set1.fillAlpha = 65 / 255.0
            set1.fillColor = UIColor(red: 6/255, green: 204/255, blue: 88/255, alpha: 1.0)
            set1.highlightColor = UIColor.white
            lineChartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5, easingOption: .easeInExpo)
            
            //3 - create an array to store our LineChartDataSets
            var dataSets : [LineChartDataSet] = [LineChartDataSet]()
            dataSets.append(set1)
            
            //4 - pass our months in for our x-axis label value along with our dataSets
            let data: LineChartData = LineChartData(dias, dataSets)
            //let data: LineChartData = LineChartData(values: dias, dataSets: dataSets)
            data.setValueTextColor(UIColor.white)
        
            lineChartView.rightAxis.removeAllLimitLines()
            let ll = ChartLimitLine(limit: promedio, label: "Promedio " + Misc.getDoubleToCurrency(promedio))
            ll.lineColor = UIColor(red: 253/255, green: 212/255, blue: 99/255, alpha: 1.0)
            ll.valueTextColor = UIColor.white
            lineChartView.rightAxis.addLimitLine(ll)

            //5 - finally set our data
            self.lineChartView.data = data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func indexChanged(_ sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            loadHistorico((moneda?.moneda_id)!,d: 7)
        case 1:
            loadHistorico((moneda?.moneda_id)!,d: 15)
        case 2:
            loadHistorico((moneda?.moneda_id)!,d: 30)
        default:
            break;
        }
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
