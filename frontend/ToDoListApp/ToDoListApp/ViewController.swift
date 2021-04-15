//
//  ViewController.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/06.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var containerViewCollection: [UIView]!
    
    let transitionDelegate = SideBarTransitionDelegate()
    
    @IBAction func showSideBar(_ sender: Any) {
        let sideBarStoryBoard = UIStoryboard.init(name: "SideBar", bundle: nil)
        
        NetworkService.shared.getRequest(needs: [HistoryData].self, api: .readHistory, closure: { result in
            switch result {
            case .success(let data) :
                DispatchQueue.main.async {
                    let sideBarVC = sideBarStoryBoard.instantiateViewController(identifier: "SideBar") as SideBarViewController
                    sideBarVC.transitioningDelegate = self.transitionDelegate
                    sideBarVC.modalPresentationStyle = .custom
                    sideBarVC.historyData = data
                    self.present(sideBarVC, animated: true, completion: nil)
                }
            case .failure(let error) :
                print(error.localizedDescription)
                break
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.shared.getRequest(needs: [CellData].self, api: .readCells, closure: { result in
            switch result {
            case .success(let data):
                DataManager.shared.setData(cells: data)
            case .failure(let error):
                break
            }
            self.setViewControllerInContainerView()
        })
    }
    
    private func setViewControllerInContainerView(){
        let identifier : String = "ColumnView"
        var columnTitles : [String] = ["완료한 일", "하고 있는 일", "해야할 일"]
        let columnViewStoryboard = UIStoryboard.init(name: identifier, bundle: nil)
        
        DispatchQueue.main.async {
            for i in 0..<self.containerViewCollection.count {
                let columnVC = columnViewStoryboard.instantiateViewController(identifier: identifier) as ColumnViewController
                columnVC.columnID = i + 1
                self.addChild(columnVC)
                self.containerViewCollection[i].addSubview(columnVC.view)
                columnVC.set(title: columnTitles.popLast()!)
            }
        }
    }
}
