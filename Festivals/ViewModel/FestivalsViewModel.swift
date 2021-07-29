//
//  FestivalsViewModel.swift
//  Festivals
//
//  Created by gurjeet singh on 22/7/21.
//

import Foundation

class FestivalsViewModel {
    var festivals = [Festival]()
    var tempFestivals = [RestructFestivals]()
    var sortedFestivalsData = [String: [RestructFestivals]]()
}

extension FestivalsViewModel {
    
    func fetchPetsData(completion: @escaping (Result<[Festival], Error>) -> Void) {
        NetworkManager.shared.get(urlString: FestivalsURL.festivalsURL, completionBlock: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print("\(error.localizedDescription) occured, please re run the app")
            case .success(let dta) :
                let decoder = JSONDecoder()
                do {
                    self.festivals = try decoder.decode([Festival].self, from: dta)
                    for festival in self.festivals {
                        if let bnds = festival.bands {
                            for band in bnds {
                                self.tempFestivals.append(RestructFestivals(bandName:band.name, name: festival.name, recordLabel: band.recordLabel))
                            }
                        }
                    }
                    self.sortedFestivalsData = Dictionary(grouping: self.tempFestivals, by: { $0.recordLabel ?? "" })
                    completion(.success(self.festivals))
                } catch {
                    print("exception occured, please re run the app")
                }
            }
        })
    }
}
