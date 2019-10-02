//
//  ViewController.swift
//  Core Data Siswa
//
//  Created by yudha on 01/10/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit

//implement = protocol
class InsertViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var tfNama: UITextField!
    @IBOutlet weak var tfNohp: UITextField!
    @IBOutlet weak var pvGender: UIPickerView!
    @IBOutlet weak var swicthMembaca: UISwitch!
    @IBOutlet weak var switchMenulis: UISwitch!
    @IBOutlet weak var swicthMenggambar: UISwitch!
    
    @IBAction func btnSimpan(_ sender: Any) {
        
        let nama = tfNama.text
        let noHp = tfNohp.text
        let selectedGender = gender[pvGender.selectedRow(inComponent: 0)]
        
        var hobbies = [String]()
        if swicthMembaca.isOn{
            hobbies.append("Membaca")
        }
        if swicthMenggambar.isOn {
            hobbies.append("Menggambar")
        }
        if switchMenulis.isOn {
            hobbies.append("Menulis")
        }
        
        let hobi = hobbies.joined(separator: ", ")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        //cek apabila belum pernah diisi core data
        if siswa == nil {
            siswa = Siswa(context: context)
        }
        
        //set value to core data
        siswa?.nama = nama
        siswa?.nohp = noHp
        siswa?.gender = selectedGender
        siswa?.hobi = hobi
        
        //save ke core data
        do{
            try context.save()
        }catch{
            print("gagal save")
        }
        
        let alert = UIAlertController(title: "Info", message: "Berhasil Simpan", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (alertOk) in
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    var gender = ["Pria", "Wanita"]
    
    var siswa : Siswa? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegate adalah menyerahkan tugas dari objek tertentu ke objek yang lain, misalkan untuk melakukan suatu aksi terhadap data yang ditampilkan di sebuah UITableView , maka seringkali kita membutuhkan UIViewController sebagai delegasi dari UITableView untuk melakukan aksi tertentu, misalkan memilih salah satu item pada UITableView
        pvGender.delegate = self
        pvGender.dataSource = self
        
        if siswa != nil {
            self.title = "Edit Data"
            
            tfNama.text = siswa?.nama
            tfNohp.text = siswa?.nohp
            
            let indexGender = gender.firstIndex(of: siswa!.gender!)!
            pvGender.selectRow(indexGender, inComponent: 0, animated: true)
            
            if (siswa?.hobi?.contains("Menggambar"))! {
                swicthMenggambar.isOn = true
            }
            if (siswa?.hobi?.contains("Menulis"))!{
                switchMenulis.isOn = true
            }
            if (siswa?.hobi?.contains("Membaca"))! {
                swicthMembaca.isOn = true
            }
        }
    }

    //untuk menampilkan jumlah picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //menghitung data yang akan di tampilkan di picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
}

