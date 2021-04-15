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
    @IBOutlet weak var badge: Badge!
    
    private var columnDataSource : ColumnDataSource = ColumnDataSource()
    private var columnDelegate : ColumnDelegate = ColumnDelegate()
    private let columnViewDragDelegate = ColumnViewDragDelegate()
    private let columnViewDropDelegate = ColumnViewDropDelegate()
    private let delegate : ViewDataProtocol? = nil
    
    var columnID = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
    }
    
    @objc func reload() {
        DispatchQueue.main.async {
            self.columnTableView.reloadData()
        }
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
        let createdCellData : CellData = DataManager.shared.makeCellData(columnID: self.columnID, titleTextField: titleText, contentTextField: contentText)
        DataManager.shared.add(cellData:createdCellData)
        NetworkService.shared.postRequest(input: createdCellData, post: .createCell, closure: { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
            
        })
    }
    
    @objc private func updateSectionInTableView(sender: Notification) -> Void {
        guard let receiveId : Int = sender.userInfo?["columnId"] as? Int else {
            return
        }
        if receiveId != self.columnID {
            return
        }
        self.columnTableView.insertSections(IndexSet(integer: columnTableView.numberOfSections), with: .automatic)
        self.badge.text = "\(columnTableView.numberOfSections)"
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
        columnTableView.dragDelegate = columnViewDragDelegate
        columnTableView.dragInteractionEnabled = true
        columnViewDropDelegate.columnId = self.columnID
        columnTableView.dropDelegate = columnViewDropDelegate
        columnTableView.reloadData()
        self.badge.text = "\(columnTableView.numberOfSections)"
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .reloadAllColumnTable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSectionInTableView(sender:)), name: Notification.Name.addData, object: DataManager.shared)
    }
}
