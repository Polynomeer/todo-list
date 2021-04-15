//
//  ViewController.swift
//  ToDoListApp
//
//  Created by 이다훈 on 2021/04/06.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var containerViewCollection: [UIView]!
    
    override func viewDidLoad() {
        setViewControllerInContainerView()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func setViewControllerInContainerView(){
        let identifier : String = "ColumnView"
        var columnTitles : [String] = ["완료한 일", "하고 있는 일", "해야할 일"]
        let columnViewStoryboard = UIStoryboard.init(name: identifier, bundle: nil)
        for i in 0..<containerViewCollection.count {
            let columnVC = columnViewStoryboard.instantiateViewController(identifier: identifier) as ColumnViewController
            columnVC.columnID = i
            self.addChild(columnVC)
            containerViewCollection[i].addSubview(columnVC.view)
            columnVC.set(title: columnTitles.popLast()!)
        }
    }
}
