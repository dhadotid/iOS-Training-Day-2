//
//  SiswaTableViewCell.swift
//  Core Data Siswa
//
//  Created by yudha on 01/10/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit

class SiswaTableViewCell: UITableViewCell {

    @IBOutlet weak var lbNama: UILabel!
    @IBOutlet weak var lbNoHp: UILabel!
    @IBOutlet weak var lbHobi: UILabel!
    @IBOutlet weak var lbGender: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
