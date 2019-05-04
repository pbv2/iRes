//
//  DetalhesViewController.swift
//  iRes
//
//  Created by student on 02/05/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import UIKit

class DetalhesViewController: UIViewController {
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var especsField: UITextView!
    
    var salaAux: Sala?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeLabel.text = salaAux?.nome
        descricaoLabel.text = salaAux?.descricao
        especsField.text = "  "
        for especificacao in (salaAux?.especificacoes)!{
            especsField.text = especsField.text! + especificacao.key + ": " + especificacao.value + "\n  "
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
