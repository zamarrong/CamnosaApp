//
//  MainViewController.swift
//  Camnosa
//
//  Created by Jorge Zamarrón on 06/07/16.
//  Copyright © 2016 Sifen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    let monedasList = MonedasList()
    var selectedItem: Moneda?
    var refreshControl = UIRefreshControl()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 90, height: 22))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "Logo")
        imageView.image = image
        self.navigationItem.titleView =  imageView
        
        
        tableView.separatorColor = UIColor.darkGray
        //tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = monedasList
        
        loadMonedas()
        
        self.refreshControl.addTarget(self, action: #selector(MainViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        self.refreshControl.tintColor = UIColor(red: 255/255, green: 212/255, blue: 99/255, alpha: 1.0);
        self.tableView.addSubview(refreshControl)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func refreshButton(_ sender: AnyObject) {
        loadMonedas()
    }
    
    func handleRefresh(_ refreshControl: UIRefreshControl) {
        loadMonedas()
        refreshControl.endRefreshing()
    }
    
    func loadMonedas() {
        let loadingIndicator = LoadingIndicator(text: Strings.getLoadingString())
        self.view.addSubview(loadingIndicator)
        APIController.tipos_cambio(self.monedasList, excluir: true) {(r) -> Void in
            if r {
                self.tableView.dataSource = self.monedasList
                self.tableView.delegate = self
                self.tableView.reloadData()
            }
            loadingIndicator.removeFromSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedItem = self.monedasList.getItem(indexPath.row)
        self.performSegue(withIdentifier: "showHistorico", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? HistoricoViewController {
            detailViewController.moneda = self.selectedItem!
        }
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
