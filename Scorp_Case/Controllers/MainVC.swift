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
    var personData: [Person]?
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyContainerView.isHidden = true
        refreshButton.isHidden = true
        setDelegates()
        setLayouts()
        getData()
        
    }
    
    private func setLayouts() {
        refreshButton.layer.cornerRadius = 8
        refreshButton.backgroundColor = .orange
        refreshButton.clipsToBounds = true
        refreshButton.setTitle("Y E N İ L E", for: .normal)
        refreshButton.tintColor = .white
    }
    
//    private func setupUI() {
//        if personData == nil {
//            peopleListTableView.isHidden = true
//            emptyContainerView.isHidden = false
//            refreshButton.isHidden = false
//        } else {
//            peopleListTableView.isHidden = false
//            emptyContainerView.isHidden = true
//            refreshButton.isHidden = true
//        }
//    }
    
    private func getData() {
        DataSource.fetch(next: nextPage) { response, error in
            if (error != nil) {
                self.showAlertAction(title: "UUPPSS!!!", message: error?.errorDescription ?? "")
                print(error?.errorDescription as Any)
            } else {
                self.personData = response?.people
                if self.personData == nil {
                    self.peopleListTableView.isHidden = true
                    self.emptyContainerView.isHidden = false
                    self.refreshButton.isHidden = false
                } else {
                    self.peopleListTableView.isHidden = false
                    self.emptyContainerView.isHidden = true
                    self.refreshButton.isHidden = true
                    self.peopleListTableView.reloadData()
                }
                
                print(self.personData as Any)
            }
        }
    }
    
    @objc func refreshList(sender: AnyObject) {
        getData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        getData()
        emptyContainerView.isHidden = true
        refreshButton.isHidden = true
        peopleListTableView.isHidden = false
    }
    
    func showAlertAction(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
            self.getData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setDelegates() {
        peopleListTableView.dataSource = self
        peopleListTableView.delegate = self
        peopleListTableView.register(PeopleListTableViewCell.self)
        //refreshControl.attributedTitle = NSAttributedString(string: "Yenileniyor")
        refreshControl.addTarget(self, action: #selector(refreshList), for: UIControl.Event.valueChanged)
    }
    
}

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

