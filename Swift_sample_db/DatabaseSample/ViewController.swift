//
//  ViewController.swift
//  DatabaseSample
//
//  Created by   on 28/04/18.
//  Copyright © 2018  . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var IBTableView: UITableView!
    var arrStudentData : [StudentInfo]?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IBTableView.estimatedRowHeight = 44.0
        IBTableView.rowHeight = UITableViewAutomaticDimension
        
        self.getStudentData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditSegue" {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            let viewController = segue.destination as! AddStudentInfoViewController
            viewController.isEdit = true
            viewController.studentData = arrStudentData?[selectedIndex]
        }
    }
    
    func getStudentData()
    {
        arrStudentData = []
        arrStudentData = ModelManager.getInstance().getAllStudentData()
        
        IBTableView.reloadData()
    }

    @IBAction func addBtnTapped(_ sender: Any) {
    }
    @IBAction func editBtnTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "EditSegue", sender: sender)
    }
    @IBAction func deleteBtnTapped(_ sender: Any) {
        let btnDelete : UIButton = sender as! UIButton
        let selectedIndex : Int = btnDelete.tag
        let studentInfo: StudentInfo = arrStudentData![selectedIndex]
        let isDeleted = ModelManager.getInstance().deleteStudentData(studentInfo: studentInfo)
        if isDeleted {
            Utility.invokeAlertMethod(strTitle: "", strBody: "Record deleted successfully.", delegate: nil)
        } else {
            Utility.invokeAlertMethod(strTitle: "", strBody: "Error in deleting record.", delegate: nil)
        }
        self.getStudentData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStudentData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
        let studentData = arrStudentData?[indexPath.row]
        
        if let student = studentData {
            cell.IBLblName.text = student.Name
            cell.IBLblMarks.text = student.Marks
            cell.IBBtnEdit.tag = indexPath.row
            cell.IBBtnDelete.tag = indexPath.row
            let dataDecoded: Data = Data(base64Encoded: student.image, options: .ignoreUnknownCharacters)!
            let decodedimage:UIImage = UIImage(data: dataDecoded)!
            cell.IBImageView.image = decodedimage
        }
        return cell
    }
}

