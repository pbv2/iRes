//
//  BlocoTableViewController.swift
//  iRes
//
//  Created by student on 25/04/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import UIKit
import CoreLocation

class BlocoTableViewController: UITableViewController, CLLocationManagerDelegate{
    
    var blocos: [bloco] = []
    let locationManager = CLLocationManager()
    let hackaTruck = CLLocation(latitude: -8.056093, longitude: -34.950924)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.blocos = blocoDAO.getBlocos()
        
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let distance = location.distance(from: hackaTruck)
            print(distance)
            print(AppDelegate.login.nome)
            
            if(isReserved()){
                sendDistance(distance: distance)
            }
            
            
        }
    }
    
    func isReserved() -> Bool{
        let salas:[Sala] = salaDAO.getSalas()
        
        let horarioAtual = Date()
        let calendarNow = Calendar.current
        let yearNow = calendarNow.component(.year, from: horarioAtual)
        let monthNow = calendarNow.component(.month, from: horarioAtual)
        let dayNow = calendarNow.component(.day, from: horarioAtual)
        let hourNow = calendarNow.component(.hour, from:horarioAtual)
        let minuteNow = calendarNow.component(.minute, from: horarioAtual)
        
        for sala in salas{
            for reserva in sala.reserva{
                if (reserva.pessoa == AppDelegate.login.nome){
                    let dateF = DateFormatter()
                    dateF.dateFormat = "yyyy/MM/dd HH:mm"
                    let date: Date? = dateF.date( from: reserva.horario! )
                    //date = date?.addingTimeInterval(-3.0 * 60.0 * 60.0)
                
                    let calendarNow = Calendar.current
                    let year = calendarNow.component(.year, from: date!)
                    let month = calendarNow.component(.month, from: date!)
                    let day = calendarNow.component(.day, from: date!)
                    let hour = calendarNow.component(.hour, from:date!)
                    let minute = calendarNow.component(.minute, from: date!)
                    if(year == yearNow && month == monthNow && day == dayNow){
                    let minutesElipsed = hourNow * 60 + minuteNow
                        let minutesReservation = hour * 60 + minute
                        if((minutesElipsed <= minutesReservation) && ((minutesReservation - minutesElipsed) > 20)
                        || ((minutesElipsed >= minutesReservation) && (minutesElipsed - minutesReservation) < 60))
                        {
                            return true
                        }
                    }
                }
            }
        }
        
        return false
    }
    
    func sendDistance(distance: Double){
        let json:[String:Any]
        if distance < 30{
            json = ["led" : "0"]
        } else {
            json = ["led" : "1"]
        }
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        
        let url = URL(string: "https://projetov1-1.mybluemix.net/ledD001")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, response, error in})
        
        task.resume()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return blocos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "blocoCellIdentifier", for: indexPath)

        if let blocoCell = cell as? BlocosTableViewCell {
            let bloco = self.blocos[indexPath.row]
            blocoCell.nomeSala.text = bloco.nome
        }

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        if (segue.identifier == "salaIdentifier") {
            if let blocoView = segue.destination as? SalasTableViewController {
                blocoView.salasAux = salaDAO.getSalas(codigo: blocos[(indexPath?.row)!].codigo)
            }
        }
    }
}
