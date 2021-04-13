//
//  ViewController.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/06.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var containerViewCollection: [UIView]!
    
    
    @IBAction func showSideBar(_ sender: Any) {
        let sideBarStoryBoard = UIStoryboard.init(name: "SideBar", bundle: nil)
        let sideBarVC = sideBarStoryBoard.instantiateViewController(identifier: "SideBar")
        present(sideBarVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllerInContainerView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
