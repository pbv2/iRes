//
//  HorariosTableViewCell.swift
//  iRes
//
//  Created by student on 30/04/19.
//  Copyright © 2019 iRes. All rights reserved.
//

import UIKit

class HorariosTableViewCell: UITableViewCell {
    @IBOutlet weak var horaLabel: UILabel!
    @IBOutlet weak var pessoaLabel: UILabel!
    @IBOutlet weak var motivoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
