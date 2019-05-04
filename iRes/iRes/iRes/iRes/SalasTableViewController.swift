//
//  SalasTableViewController.swift
//  iRes
//
//  Created by student on 26/04/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import UIKit

class SalasTableViewController: UITableViewController{

    var salasAux: [Sala]?
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salasAux!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "salaCellIdentifier", for: indexPath)

        if let salaCell = cell as? SalasTableViewCell {
            let sala = self.salasAux?[indexPath.row]
            salaCell.nomeSala.text = sala?.nome
            salaCell.especificacoesLabel.text = sala?.descricao
        }
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)

        if (segue.identifier == "dataIdentifier") {
            if let dataView = segue.destination as? DataViewController {
                dataView.salaAux = salasAux?[(indexPath?.row)!]
            }
        }
    }
    
}
