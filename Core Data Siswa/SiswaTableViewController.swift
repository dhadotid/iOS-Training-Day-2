//
//  SiswaTableViewController.swift
//  Core Data Siswa
//
//  Created by yudha on 01/10/19.
//  Copyright © 2019 yudha. All rights reserved.
//

import UIKit
import CoreData

class SiswaTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var siswa : [Siswa] = [Siswa]()
    
    //outlet tbsiswa
    //panggil protocol UITableViewDelegate, UITableViewDataSource

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        //panggil
        //tbSiswa.delegate = self
        //tbSiswa.dataSource = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Siswa")
        
        do{
            let result = try context.fetch(fetchRequest)
            siswa = result as! [Siswa]
            tableView.reloadData()
        } catch {
            print("error")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return siswa.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSiswa", for: indexPath) as! SiswaTableViewCell
        var cell : SiswaTableViewCell? = nil
        let siswa = self.siswa[indexPath.row]
        
        if siswa.gender == "Pria" {
            cell = tableView.dequeueReusableCell(withIdentifier: "cellPria", for: indexPath) as! SiswaTableViewCell
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "cellWanita", for: indexPath) as! SiswaTableViewCell
        }

//        let siswa = self.siswa[indexPath.row]
        cell!.lbNama.text = siswa.nama
        cell!.lbNoHp.text = siswa.nohp
        cell!.lbGender.text = siswa.gender
        cell!.lbHobi.text = siswa.hobi

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tujuan = storyboard.instantiateViewController(identifier: "detailSiswaStory") as! DetailViewController
        let siswa = self.siswa[indexPath.row]
        
        tujuan.siswa = siswa
        tujuan.modalPresentationStyle = .fullScreen
        
        show(tujuan, sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (delete, indexPath) in
            
            let siswa = self.siswa[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            context.delete(siswa)
            
            do{
                try context.save()
            } catch{
                print("gagal hapus")
            }
            
            self.getData()
        }
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { (edit, indexPath) in
            self.performSegue(withIdentifier: "edit", sender: indexPath)
        }
        
        edit.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        return[delete, edit]
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        //cek segue yang diarahkan
        if segue.identifier == "edit" {
            if let tujuan = segue.destination as? InsertViewController {
                var indexPath = sender as! IndexPath
                let siswa = self.siswa[indexPath.row]
                
                //kirim data ke segue yang diarahkan
                tujuan.siswa = siswa
            }
        }
    }

    //handle click segue selain didSelectRowAt
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "edit" {
            return false
        }
        return true
    }
}

extension SiswaTableViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let cariNama = searchText
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Siswa")
        
        if searchText != "" {
            fetchRequest.predicate = NSPredicate(format: "nama == %@", cariNama)
        }
        
        do{
            let result = try context.fetch(fetchRequest)
            siswa = result as! [Siswa]
            tableView.reloadData()
        } catch{
            print("error")
        }
    }
}
