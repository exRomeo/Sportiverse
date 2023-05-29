//
//  LeagueDetails.swift
//  Sportiverse
//
//  Created by Ramy Ashraf on 25/05/2023.
//

import UIKit

private let reuseIdentifier = "Cell"

class LeagueDetails: UIViewController {
    
    private let topCollectionReusableID = "topCell"
    @IBOutlet weak var topCollectionView: UICollectionView!
    private var upComing = [Event]()
    private let centerCollectionReusableID = "centerCell"
    @IBOutlet weak var centerCollectionView: UICollectionView!
    private var liveScore = [Event]()
    private let bottomCollectionReusableID = "bottomCell"
    @IBOutlet weak var bottomCollectionView: UICollectionView!
    private var teams = [Team]()
    private var viewModel: LeagueDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionViews()
        viewModel.getLeagueDetails()
    }
    
    func prepareCollectionViews(){
        topCollectionView.register(UINib(nibName: "TopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: topCollectionReusableID)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        topCollectionView.collectionViewLayout = flowLayout
        topCollectionView.isPagingEnabled = true
        centerCollectionView.register(UINib(nibName: "TopCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: topCollectionReusableID)
        bottomCollectionView.register(UINib(nibName: "BottomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: bottomCollectionReusableID)
    }
    
    func instantiateViewModel(with leagueID: Int, and sportType:String){
        self.viewModel =
        LeagueDetailsViewModel(api: API.shared,
                                                sportType: sportType,
                                                leagueID: leagueID,
                                                onUpComingUpdated: ({[weak self] result in
                                                    self?.renderTopCollection(result)
            
                                                }), onLiveScoreUpdated: ({[weak self] result in
                                                    self?.renderCenterCollection(result)
            
                                                }), onTeamsUpdated: ({[weak self] result in
                                                    self?.renderBottomCollection(result)
            
                                                })
                            )
    }
}


//MARK: Collection View Functions
extension LeagueDetails: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return the number of items in each collection view
        switch collectionView{
            
        case topCollectionView:
            return upComing.count
            
        case centerCollectionView:
            return liveScore.count
            
        case bottomCollectionView:
            return teams.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView{
            
        case topCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCollectionReusableID, for: indexPath) as! TopCollectionViewCell
            
            cell.populateCell(with: upComing[indexPath.row], placeHolder: viewModel.sportType)
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.25)
            return cell
            
        case centerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: topCollectionReusableID, for: indexPath) as! TopCollectionViewCell
            
            cell.populateCell(with: liveScore[indexPath.row], placeHolder: viewModel.sportType)
            cell.backgroundColor = UIColor.green.withAlphaComponent(0.25)
            return cell
            
        case bottomCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bottomCollectionReusableID, for: indexPath) as! BottomCollectionViewCell
            
            cell.populateCell(team: teams[indexPath.row], placeHolder: viewModel.sportType)
            cell.backgroundColor = UIColor.purple.withAlphaComponent(0.25)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
            
        case topCollectionView :
            // Return the item size for the top and bottom collection views (horizontal scrolling)
            let itemWidth = collectionView.bounds.width - 11
            let itemHeight = collectionView.bounds.height
            return CGSize(width: itemWidth, height: itemHeight)
            
        case centerCollectionView:
            // Return the item size for the middle collection view (vertical scrolling)
            let itemWidth = collectionView.bounds.width
            let itemHeight = collectionView.bounds.height
            return CGSize(width: itemWidth, height: itemHeight/2.5)
            
        case bottomCollectionView:
            let itemWidth = 106.0
            let itemHeight = collectionView.bounds.height - 4
            return CGSize(width: itemWidth, height: itemHeight)
            
        default:
            return CGSize()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch collectionView {
            
        case topCollectionView:
            // Adjust the inset for the top collection view (horizontal scrolling)
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            
        case centerCollectionView:
            //Adjust the inset for the middle collection view (vertical scrolling)
            return UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
            
        case bottomCollectionView:
            //Adjust the inset for the bottom collection view (horizontal scrolling)
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            
        default:
            return UIEdgeInsets()
        }
    }
}


//MARK: Rendering data
extension LeagueDetails {
    
    func renderTopCollection(_ result: Result<[Event], Error>){
        switch result{
        case .success(let data):
            upComing = data
            DispatchQueue.main.async {
                self.topCollectionView.reloadData()
            }
            
        case .failure(let error):
            switch error {
            case API.APIError.emptyList:
                print("renderTopCollection errored out -> \((error as! API.APIError).rawValue)")
                showError(collectionView: topCollectionView, message: (error as! API.APIError).rawValue)
            default:
                print("renderTopCollection errored out -> \(error.localizedDescription)")
                
            }
        }
    }
    
    func renderCenterCollection(_ result: Result<[Event], Error>){
        switch result{
        case .success(let data):
            liveScore = data
            DispatchQueue.main.async {
                self.centerCollectionView.reloadData()
            }
            
        case .failure(let error):
            switch error {
            case API.APIError.emptyList:
                print("renderCenterCollection errored out -> \((error as! API.APIError).rawValue)")
            default:
                print("renderCenterCollection errored out -> \(error.localizedDescription)")
                
            }
        }
    }
    
    func renderBottomCollection(_ result: Result<[Team], Error>){
        switch result{
        case .success(let data):
            teams = data
            DispatchQueue.main.async {
                self.bottomCollectionView.reloadData()
            }
        case .failure(let error):
            switch error {
            case API.APIError.emptyList:
                print("renderBottomCollection errored out -> \((error as! API.APIError).rawValue)")
                
            default:
                print("renderBottomCollection errored out -> \(error.localizedDescription)")
                
            }
            
        }
    }
    
    func showError(collectionView: UICollectionView, message: String){
        DispatchQueue.main.async {
            UILabel().show(errorMessage: message, on: collectionView)
        }
    }
}
