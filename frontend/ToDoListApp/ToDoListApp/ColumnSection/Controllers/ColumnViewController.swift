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
            self.badge.text = "\(self.columnTableView.numberOfSections)"
        }
    }
    
    @objc func modifyCardButton(sender: Notification){
        guard let userInfo = sender.userInfo?["CardData"] as? CellData else {
            return
        }
        guard let ModalVC : ModalViewController = storyboard?.instantiateViewController(withIdentifier: "newCard") as? ModalViewController else {
            return
        }
        ModalVC.view.isOpaque = false
        ModalVC.preferredContentSize = CGSize(width: 400, height: 175)
        ModalVC.modalPresentationStyle = .formSheet
        ModalVC.activemodifyButton()
        ModalVC.activeModifyCardTitle()
        ModalVC.titleTextField.placeholder = userInfo.title
        ModalVC.contentTextField.placeholder = userInfo.content
        ModalVC.modifyTargetData = userInfo
        ModalVC.set(delegate: self)
        present(ModalVC, animated: true, completion: nil)
    }
    
    @IBAction func addCardButton(_ sender: Any) {
        guard let ModalVC : ModalViewController = storyboard?.instantiateViewController(withIdentifier: "newCard") as? ModalViewController else {
            return
        }
        ModalVC.view.isOpaque = false
        ModalVC.preferredContentSize = CGSize(width: 400, height: 175)
        ModalVC.modalPresentationStyle = .formSheet
        ModalVC.activeaddButton()
        ModalVC.activeNewCardTitle()
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
    
    @objc private func updateSectionInTableViewCaseInsert(sender: Notification) -> Void {
        guard let receiveId : Int = sender.userInfo?["columnId"] as? Int else {
            return
        }
        if receiveId != self.columnID {
            return
        }
        self.columnTableView.insertSections(IndexSet(integer: columnTableView.numberOfSections), with: .automatic)
        self.badge.text = "\(columnTableView.numberOfSections)"
    }
    
    @objc private func updateSectionInTableViewCaseDelete(sender: Notification) -> Void{
        guard let receiveData : [Int] = sender.userInfo?["delete"] as? [Int] else {
            return
        }
        if receiveData[1] != self.columnID {
            return
        }
        self.columnTableView.deleteSections(IndexSet(integer: receiveData[0]), with: .automatic)
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
        columnDelegate.columnId = self.columnID
        self.badge.text = "\(columnTableView.numberOfSections)"
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .reloadAllColumnTable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSectionInTableViewCaseInsert(sender:)), name: Notification.Name.addData, object: DataManager.shared)
        NotificationCenter.default.addObserver(self, selector: #selector(updateSectionInTableViewCaseDelete(sender:)), name: Notification.Name.deleteData, object: DataManager.shared)
        NotificationCenter.default.addObserver(self, selector: #selector(modifyCardButton(sender:)), name: .modifyCard, object: columnDelegate)
    }
}
