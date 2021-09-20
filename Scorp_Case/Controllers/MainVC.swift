//
//  MainVC.swift
//  Scorp_Case
//
//  Created by İlkay Sever on 25.08.2021.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var peopleListTableView: UITableView!
    
    @IBOutlet weak var emptyContainerView: UIView!
    @IBOutlet weak var sadImgView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    var nextPage: String?
    var group = DispatchGroup()
    var personData: [Person]?
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyContainerView.isHidden = true
        refreshButton.isHidden = true
        setDelegates()
        setLayouts()
        getData()
        group.notify(queue: .main) {
            self.peopleListTableView.reloadData()
        }
        
    }
    
    private func setLayouts() {
        refreshButton.layer.cornerRadius = 8
        refreshButton.backgroundColor = .orange
        refreshButton.clipsToBounds = true
        refreshButton.setTitle("Y E N İ L E", for: .normal)
        refreshButton.tintColor = .white
    }
    
    /// UISetups
    private func setListHidden(_ isHidden: Bool) {
        if isHidden {
            self.peopleListTableView.isHidden = true
            self.emptyContainerView.isHidden = false
            self.refreshButton.isHidden = false
        } else {
            self.peopleListTableView.isHidden = false
            self.emptyContainerView.isHidden = true
            self.refreshButton.isHidden = true
        }
    }
    
    /// Get All Datas from DataSource.swift
    private func getData() {
        group.enter()
        DataSource.fetch(next: nextPage) { response, error in
            guard error == nil else {
                self.showSingleAlertAction(title: "UUPPSS!!!", message: error?.errorDescription ?? "") {
                    self.getData()
                    self.group.leave()
                }
                return
            }
            self.setListHidden(response?.people.count == 0 ? true : false)
            if self.personData == nil {
                self.personData = response?.people
                self.group.leave()
            } else {
                guard let personData = self.personData else { return }
                self.personData?.append(contentsOf: personData)
                self.group.leave()
            }
            self.nextPage = response?.next
            self.peopleListTableView.reloadData()
        }
    }
    
    @objc func refreshList(sender: AnyObject) {
        getData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        getData()
        setListHidden(false)
    }
    
    private func setDelegates() {
        peopleListTableView.dataSource = self
        peopleListTableView.delegate = self
        peopleListTableView.register(PeopleListTableViewCell.self)
        refreshControl.addTarget(self, action: #selector(refreshList), for: UIControl.Event.valueChanged)
    }
    
}

//MARK: - TableView Datasource & Delegate
extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PeopleListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        self.peopleListTableView.addSubview(self.refreshControl)
        cell.fillPerson(personData: self.personData?[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == personData!.endIndex - 1  {
            getData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

