//
//  ColumnViewController.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import UIKit

class ColumnViewController : UIViewController {
    @IBOutlet weak var columnTitle: UILabel!
    @IBOutlet weak var columnTableView: UITableView!
    
    private var columnDataSource : ColumnDataSource = ColumnDataSource()
    private var columnDelegate : ColumnDelegate = ColumnDelegate()
    private var currentModalViewController : ModalViewController? = nil
    private let columnViewDragDelegate = ColumnViewDragDelegate()
    private let columnViewDropDelegate = ColumnViewDropDelegate()
    var columnID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
    }
    
    @objc func reload() {
        self.columnTableView.reloadData()
    }
    
    @IBAction func addCardButton(_ sender: Any) {
        guard let tempVC : ModalViewController = storyboard?.instantiateViewController(withIdentifier: "newCard") as? ModalViewController else {return}
        tempVC.view.isOpaque = false
        tempVC.preferredContentSize = CGSize(width: 400, height: 175)
        tempVC.modalPresentationStyle = .formSheet
        present(tempVC, animated: true, completion: nil)
        currentModalViewController = tempVC
    }
    
    @objc private func addCard(sender: Notification){
        guard let currentModalVC = currentModalViewController else { return }
        DataManager.shared.add(cellData: currentModalVC.makeCellData(columnID: self.columnID))
        columnTableView.insertSections(IndexSet(integer: columnTableView.numberOfSections), with: .automatic)
        currentModalVC.set(active: false)
        self.currentModalViewController = nil
    }
    
    func set(title: String){
        guard let tempTitle = columnTitle else {return}
        tempTitle.text = title
    }
}

extension ColumnViewController {
    
    func viewInit(){
        guard columnTableView != nil else {return}
        columnTableView.delegate = columnDelegate
        columnDataSource.columnId = columnID
        columnTableView.dataSource = columnDataSource
        columnTableView.dragDelegate = columnViewDragDelegate
        columnTableView.dragInteractionEnabled = true
        columnViewDropDelegate.columnId = self.columnID
        columnTableView.dropDelegate = columnViewDropDelegate
        columnTableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(addCard), name: NSNotification.Name("addCard"), object: currentModalViewController)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .reloadAllColumnTable, object: nil)
    }
}
