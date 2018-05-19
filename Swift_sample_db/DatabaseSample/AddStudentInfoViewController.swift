//
//  AddStudentInfoViewController.swift
//  DatabaseSample
//
//  Created by   on 28/04/18.
//  Copyright © 2018  . All rights reserved.
//

import UIKit

class AddStudentInfoViewController: UIViewController {
    @IBOutlet weak var IBTextName: UITextField!
    
    @IBOutlet weak var IBTextMarks: UITextField!
    
    var isEdit : Bool = false
    var studentData : StudentInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isEdit {
            IBTextName.text = studentData.Name
            IBTextMarks.text = studentData.Marks
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
        if(IBTextName.text == "")
        {
            Utility.invokeAlertMethod(strTitle: "", strBody: "Please enter student name.", delegate: nil)
        }
        else if(IBTextMarks.text == "")
        {
            Utility.invokeAlertMethod(strTitle: "", strBody: "Please enter student marks.", delegate: nil)
        }
        else
        {
            if isEdit {
                let studentInfo = StudentInfo()
                studentInfo.RollNo = studentData.RollNo
                studentInfo.Name = IBTextName.text!
                studentInfo.Marks = IBTextMarks.text!
                let isUpdated = ModelManager.getInstance().updateStudentData(studentData: studentInfo)
                if isUpdated {
                    Utility.invokeAlertMethod(strTitle: "", strBody: "Record updated successfully.", delegate: nil)
                }else {
                   Utility.invokeAlertMethod(strTitle: "", strBody: "Error in updating record.", delegate: nil)
                }
                
            }else {
                let studentInfo: StudentInfo = StudentInfo()
                studentInfo.Name = IBTextName.text ?? ""
                studentInfo.Marks = IBTextMarks.text ?? ""
                let image = #imageLiteral(resourceName: "user.png")
                let imageData: Data = UIImagePNGRepresentation(image)!
                let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
                studentInfo.image = strBase64
                let inserted = ModelManager.getInstance().addStudentData(studentInfo: studentInfo)
                if inserted {
                    Utility.invokeAlertMethod(strTitle: "", strBody: "Record inserted successfully.", delegate: nil)
                }else {
                    Utility.invokeAlertMethod(strTitle: "", strBody: "Error in inserting record.", delegate: nil)
                }
            }
        }
        
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
