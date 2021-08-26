//
//  MainVC.swift
//  Scorp_Case
//
//  Created by İlkay Sever on 25.08.2021.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var peopleListTableView: UITableView!
    
    var nextPage: String?
    var personData: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        getData()
        
    }
    
    private func getData() {
        DataSource.fetch(next: nextPage) { response, error in
            if (error != nil) {
                print(error?.errorDescription as Any)
            } else {
                self.personData = response?.people
                self.peopleListTableView.reloadData()
                print(self.personData as Any)
            }
        }
    }
    
    //    private func upComingMovieRequest() {
    //        group.enter()
    //        UpComingRequest.init(page: page).request(success: { (object) in
    //            self.upComingData = object
    //            self.group.leave()
    //        }) { (error) in
    //            self.group.leave()
    //            print(#function,"******************* UPS!!! BEKLENMEDİK BİR HATA OLUŞTU. *******************")
    //        }
    //    }
    
    private func setDelegates() {
        peopleListTableView.dataSource = self
        peopleListTableView.delegate = self
        peopleListTableView.register(PeopleListTableViewCell.self)
    }
    
}

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PeopleListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.fillPerson(personData: self.personData?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

