//
//  ColumnViewController.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/07.
//

import UIKit



class ColumnViewController : UIViewController, ViewDataProtocol {
    
    @IBOutlet weak var columnTitle: UILabel!
    @IBOutlet weak var columnTableView: UITableView!
    
    private var columnDataSource : ColumnDataSource = ColumnDataSource()
    private var columnDelegate : ColumnDelegate = ColumnDelegate()
    private let delegate : ViewDataProtocol? = nil
    var columnID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
    }
    
    @IBAction func addCardButton(_ sender: Any) {
        guard let ModalVC : ModalViewController = storyboard?.instantiateViewController(withIdentifier: "newCard") as? ModalViewController else {
            return
        }
        ModalVC.view.isOpaque = false
        ModalVC.preferredContentSize = CGSize(width: 400, height: 175)
        ModalVC.modalPresentationStyle = .formSheet
        ModalVC.set(delegate: self)
        present(ModalVC, animated: true, completion: nil)
    }
    
    func set(title: String){
        guard let tempTitle = columnTitle else {
            return
        }
        tempTitle.text = title
    }
    
    func receiveData(titleText: String, contentText: String) -> Void {
        let createdCellData : CellData = DataManager.shared.makeCellData(ColumnID: self.columnID, titleTextField: titleText, contentTextField: contentText)
        DataManager.shared.add(cellData:createdCellData)
    }
    
    @objc private func updateSectionInTableView(sender: Notification) -> Void {
        guard let receiveId : Int = sender.userInfo?["columnId"] as? Int else {
            return
        }
        if receiveId != self.columnID {
            return
        }
        self.columnTableView.insertSections(IndexSet(integer: columnTableView.numberOfSections), with: .automatic)
    }
    
}

extension ColumnViewController {
    
    func viewInit(){
        guard columnTableView != nil else {
            return
        }
        columnTableView.delegate = columnDelegate
        columnDataSource.columnId = columnID
        columnTableView.dataSource = columnDataSource
        columnTableView.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(updateSectionInTableView(sender:)), name: Notification.Name.addData, object: DataManager.shared)
    }
}
