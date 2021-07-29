//
//  ViewController.swift
//  Festivals
//
//  Created by gurjeet singh on 22/7/21.
//

import UIKit

class HomeViewController: UIViewController {
    let festivalsViewModel = FestivalsViewModel()
    @IBOutlet weak var festivalsTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        festivalsTblView.register(UINib(nibName: "FestivalDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        festivalsViewModel.fetchPetsData { [weak self] response in
            DispatchQueue.main.async {
                self?.festivalsTblView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return festivalsViewModel.sortedFestivalsData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let tempSortedFestivals = Array(festivalsViewModel.sortedFestivalsData.keys).sorted(by: <)
        return tempSortedFestivals[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = festivalsTblView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FestivalDetailsTableViewCell
        var details = ""
        for detail in Array(festivalsViewModel.sortedFestivalsData)[indexPath.section].value.sorted(by: { ($0.bandName ?? "") < ($1.bandName ?? "") }) {
            if !details.contains(detail.bandName ?? "") {
                details.append("Band:\(detail.bandName ?? "")\n")
            }
            details.append("Festival:\(detail.name ?? "")\n")
        }
        cell?.detailsLbl.text = details
        return cell ?? UITableViewCell()
    }
}

