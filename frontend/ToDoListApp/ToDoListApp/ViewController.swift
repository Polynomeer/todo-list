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
    let networkService = NetworkService.init()
    
    @IBAction func showSideBar(_ sender: Any) {
        let sideBarStoryBoard = UIStoryboard.init(name: "SideBar", bundle: nil)
        
        networkService.getRequest(needs: [HistoryData].self, api: .readHistory, closure: { result in
            switch result {
            case .success(let data) :
                DispatchQueue.main.async {
                    let sideBarVC = sideBarStoryBoard.instantiateViewController(identifier: "SideBar") as SideBarViewController
                    sideBarVC.transitioningDelegate = self.transitionDelegate
                    sideBarVC.modalPresentationStyle = .custom
                    sideBarVC.historyDatas = data
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
        setViewControllerInContainerView()
    }
    
    private func setViewControllerInContainerView(){
        
        guard containerViewCollection != nil else {
            return
        }
        
        var columnTitles : [String] = ["해야할 일", "하고 있는 일", "완료한 일"]
        let columnViewStoryboard = UIStoryboard.init(name: "ColumnView", bundle: nil)
        columnTitles.reverse()
        
        for containerView in containerViewCollection {
            let columnVC = columnViewStoryboard.instantiateViewController(identifier: "ColumnView") as ColumnViewController
            self.addChild(columnVC)
            containerView.addSubview(columnVC.view)
            columnVC.set(title: columnTitles.popLast()!)
        }
    }
}
