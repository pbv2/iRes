//
//  horarioTableViewController.swift
//  iRes
//
//  Created by student on 29/04/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import UIKit

class horarioTableViewController: UITableViewController {
    
    var salaAux: Sala?
    var dataAux: String?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "horarioCell", for: indexPath)

        if let horaCell = cell as? HorariosTableViewCell {

            let temp: String
            if((indexPath.row + 8) < 10){
                temp = "0" + String((indexPath.row + 8))
            } else {
                temp = String(indexPath.row + 8)
            }
            horaCell.horaLabel.text = temp + ":00"

            for reservaAux in salaAux!.reserva {
                if(reservaAux.horario == (dataAux! + " " + horaCell.horaLabel.text!)){
                    horaCell.pessoaLabel.text = reservaAux.pessoa
                    horaCell.motivoLabel.text = reservaAux.motivo
                    horaCell.horaLabel.textColor = UIColor.init(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.9)
                    horaCell.backgroundColor = UIColor.init(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
                    break;
                } else {
                    horaCell.pessoaLabel.text = " "
                    horaCell.motivoLabel.text = " "
                }
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let horaCell = cell as? HorariosTableViewCell {
            if horaCell.pessoaLabel.text != " "{
                return
            }
        }
        
        let alertController = UIAlertController(title: "Alert", message: "Deseja realizar a reserva?", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Reservar", style: .default, handler: {action in
            if (AppDelegate.login.isLogged == false) {
                self.performSegue(withIdentifier: "loginIdentifier", sender: self)
            } else {
                self.reservar(indexPath: indexPath)
            }
        }
        ))
        
        self.present(alertController, animated: true)
        
        }
    
     override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "detalhesIdentifier") {
            return true
        }
        return false
    }
    
    func reservar (indexPath: IndexPath){
        let cell = tableView.cellForRow(at: indexPath)
        
        
        if let horaCell = cell as? HorariosTableViewCell {
        
            let json:[String:Any] = [
                "nome" : salaAux?.nome as Any,
                "reservas" : ["pessoa":AppDelegate.login.nome,
                              "horario": (dataAux! + " " + horaCell.horaLabel.text!)]
                ]
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            
        
            let url = URL(string: "https://projetov1-1.mybluemix.net/reservar")
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = jsonData
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            //request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in
                guard let data = data, error == nil else{
                    return
                }
                self.reloadTableView(data: data)
            })
            
            task.resume()
        }
    }
    
    func reloadTableView(data:Data){
        salaAux = nil
        do{
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                salaAux = Sala(json: json)
                DispatchQueue.main.async{self.tableView.reloadData()}
                
            }
        }catch let jsonErr {
                print("error during serialization", jsonErr)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "detalhesIdentifier") {
            if let detalheView = segue.destination as? DetalhesViewController {
                detalheView.salaAux = self.salaAux
            }
        }
    }
    
    
}
