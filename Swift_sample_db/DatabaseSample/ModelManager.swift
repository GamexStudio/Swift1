//
//  ModelManager.swift
//  DatabaseSample
//
//  Created by   on 28/04/18.
//  Copyright © 2018  . All rights reserved.
//

import UIKit
import FMDB

let sharedInstance = ModelManager()
class ModelManager: NSObject {
    
    var database: FMDatabase? = nil
    
    class func getInstance() -> ModelManager {
        if sharedInstance.database == nil {
            sharedInstance.database = FMDatabase(path: Utility.getPath(fileName: "Student.sqlite"))
        }
        return sharedInstance
    }

    func addStudentData(studentInfo: StudentInfo) -> Bool {
        
        sharedInstance.database?.open()
        
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO student_info (Name, Marks, profilePic) VALUES (?, ?, ?)", withArgumentsIn: [studentInfo.Name, studentInfo.Marks, studentInfo.image])
        sharedInstance.database?.close()
        return isInserted
    }
    
    func getAllStudentData() -> [StudentInfo] {
        sharedInstance.database?.open()
        do {
            let resultSet = try! sharedInstance.database?.executeQuery("SELECT * FROM student_info", withArgumentsIn: [])
            var arrStudentInfo: [StudentInfo] = []
            if resultSet != nil {
                while resultSet!.next() {
                    let studentInfo = StudentInfo()
                    studentInfo.RollNo = resultSet!.string(forColumn: "RollNo")!
                    studentInfo.Name = resultSet!.string(forColumn: "Name")!
                    studentInfo.Marks = resultSet!.string(forColumn: "Marks")!
                    studentInfo.image = resultSet!.string(forColumn: "ProfilePic")!
                    arrStudentInfo.append(studentInfo)
                }
            }
            sharedInstance.database?.close()
            return arrStudentInfo
        }
    }
    
    func updateStudentData(studentData: StudentInfo) -> Bool {
        sharedInstance.database?.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE student_info SET Name=?, Marks=? WHERE RollNo=?", withArgumentsIn: [studentData.Name, studentData.Marks, studentData.RollNo])
        sharedInstance.database?.close()
        return isUpdated
    }
    
    func deleteStudentData(studentInfo: StudentInfo) -> Bool {
        sharedInstance.database?.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM student_info WHERE RollNo=?", withArgumentsIn: [studentInfo.RollNo])
        sharedInstance.database?.close()
        return isDeleted
    }
    
}
