//
//  EmployeeDetailsVC.swift
//  Task
//
//  Created by Rohini Deo on 12/08/20.
//  Copyright © 2020 Taxgenie. All rights reserved.
//

import UIKit

class EmployeeDetailsVC: UIViewController {
    
    //Mark:IBOutlets:
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var salary: UILabel!
    @IBOutlet weak var age: UILabel!
    
    //Mark:Properties:
    var strname = ""
    var strid = ""
    var strsalary = ""
    var strage = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.name.text = "Name- " + self.strname
        self.id.text = "ID- " + self.strid
        self.age.text = "Age- " + self.strage
        self.salary.text = "Salary- " + self.strsalary
    }
}
