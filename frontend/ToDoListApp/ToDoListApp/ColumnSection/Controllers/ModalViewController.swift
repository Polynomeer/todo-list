//
//  ModalView.swift
//  ToDoListApp
//
//  Created by 박정하 on 2021/04/10.
//

import UIKit

protocol ViewDataProtocol {
    func receiveData(titleText: String, contentText: String) -> Void
}

class ModalViewController : UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak private var addButton: UIButton!
    @IBOutlet weak private var cancelButton: UIButton!
    @IBOutlet weak private var modifyButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak private var newCardTItle: UILabel!
    @IBOutlet weak private var cardModifyTitle: UILabel!
    
    private var delegate : ViewDataProtocol!
    var modifyTargetData : CellData!
    
    override func viewDidLoad() {
        self.titleTextField.delegate = self
        self.contentTextField.delegate = self
        super.viewDidLoad()
    }
    
    @IBAction func addButtonPushed(_ sender: Any) {
        guard let tempTitleText = titleTextField.text,
              let tempContentText = contentTextField.text else {
            return
        }
        self.delegate?.receiveData(titleText: tempTitleText, contentText: tempContentText)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func modifyButtonPushed(_ sender: Any) {
        guard let titleText = self.titleTextField.text,
              let contentText = self.contentTextField.text else {
            return
        }
        modifyTargetData.title = titleText
        modifyTargetData.content = contentText
        
        DataManager.shared.modifyCellData(cellData: modifyTargetData)
        NetworkService.shared.putRequest(card: modifyTargetData, api: .deleteOrUpdateCell, closure: {
            result in
                switch result {
                case .success(let data):
                    print(data)
                case .failure(let error):
                    print(error)
                }
        })
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: .reloadAllColumnTable, object: self)
    }
    
    @IBAction func cancelButtonPushed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    func set(delegate: ViewDataProtocol){
        self.delegate = delegate
    }
    
    func setaddButton(title : String){
        self.addButton.setTitle(title, for: .normal)
    }
    
    func activeaddButton(){
        self.addButton.isHidden = false
        self.modifyButton.isHidden = true
    }
    
    func activemodifyButton(){
        self.addButton.isHidden = true
        self.modifyButton.isHidden = false
    }
    
    func activeNewCardTitle(){
        self.newCardTItle.isHidden = false
        self.cardModifyTitle.isHidden = true
    }
    
    func activeModifyCardTitle(){
        self.newCardTItle.isHidden = true
        self.cardModifyTitle.isHidden = false
    }
}

extension ModalViewController {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if titleTextField.text == "" || contentTextField.text == "" {
            self.addButton.isEnabled = false
            self.modifyButton.isEnabled = false
        }
        else {
            self.addButton.isEnabled = true
            self.modifyButton.isEnabled = true
        }
    }
}
