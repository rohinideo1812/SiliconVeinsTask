//
//  ViewController.swift
//  Task
//
//  Created by Rohini Deo on 12/08/20.
//  Copyright © 2020 Taxgenie. All rights reserved.
//

import UIKit

struct JsonStruct:Decodable {
    var data : [EmployeeDetails]
}

struct EmployeeDetails : Decodable{
    let employee_name: String?
    let employee_salary : String?
    let employee_age : String?
    let id : String?
}

class ViewController: UIViewController,UISearchControllerDelegate,UISearchBarDelegate {
    
    //Mark:IBOutlet:
    @IBOutlet weak var tableView: UITableView!
    
    //Mark:Properties:
    var arrData : JsonStruct!
    var noOfRows = 0
    let searchController = UISearchController(searchResultsController: nil)
    var temparrData : JsonStruct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarSetup()
        getData()
    }
    
    func getData(){
        let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees")
        URLSession.shared.dataTask(with: url!){ (data,response,error) in
            do{
                if error == nil{
                    self.arrData = try JSONDecoder().decode(JsonStruct.self, from: data!)
                    self.temparrData = try JSONDecoder().decode(JsonStruct.self, from: data!)
                    self.noOfRows = self.temparrData.data.count
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }catch(let error){
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    private func searchBarSetup(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
}

extension ViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {return}
        if searchText == ""{
            self.temparrData = self.arrData
        }else{
            self.temparrData = self.arrData
            self.temparrData.data = self.arrData.data.filter{($0.employee_name?.contains(searchText))!}
        }
        self.noOfRows = self.temparrData.data.count
        self.tableView.reloadData()
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.name.text = self.temparrData.data[indexPath.row].employee_name ?? "---"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noOfRows
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = self.storyboard?.instantiateViewController(identifier: "EmployeeDetailsVC") as! EmployeeDetailsVC
        detail.strname = self.temparrData.data[indexPath.row].employee_name ?? "---"
        detail.strsalary = self.temparrData.data[indexPath.row].employee_salary ?? "---"
        detail.strage = self.temparrData.data[indexPath.row].employee_age ?? "---"
        detail.strid = self.temparrData.data[indexPath.row].id ?? "---"
        self.navigationController?.pushViewController(detail, animated: true)
    }
}

