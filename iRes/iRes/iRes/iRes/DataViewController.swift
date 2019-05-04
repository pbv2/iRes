//
//  DataViewController.swift
//  iRes
//
//  Created by student on 29/04/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var selectButton: UIButton!
    
    var salaAux: Sala?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSelectButton(_sender:Any){
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "horariosIdentifier") {
            if let horariosView = segue.destination as? horarioTableViewController {
                horariosView.salaAux = salaDAO.getSala(codigo: (salaAux?.nome)!)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY/MM/dd"
                let dateString = dateFormatter.string(from: datePicker.date)

                horariosView.dataAux = dateString
            }
        }
 
    }
}
