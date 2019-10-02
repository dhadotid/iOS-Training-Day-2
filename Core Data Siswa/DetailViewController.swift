//
//  DetailViewController.swift
//  Core Data Siswa
//
//  Created by yudha on 01/10/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var lbGender: UILabel!
    @IBOutlet weak var lbNama: UILabel!
    @IBOutlet weak var lbNoHp: UILabel!
    @IBOutlet weak var lbHobi: UILabel!
    
    var siswa: Siswa? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbNama.text = siswa?.nama
        lbNoHp.text = siswa?.nohp
        lbHobi.text = siswa?.hobi
        lbGender.text = siswa?.gender
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
