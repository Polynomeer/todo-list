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
    @IBOutlet weak private var titleTextField: UITextField!
    @IBOutlet weak private var contentTextField: UITextField!
    
    private var delegate : ViewDataProtocol!
    
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
    
    @IBAction func cancelButtonPushed(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    func set(delegate: ViewDataProtocol){
        self.delegate = delegate
    }
}

extension ModalViewController {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if titleTextField.text == "" || contentTextField.text == "" {
            self.addButton.isEnabled = false
        }
        else {
            self.addButton.isEnabled = true
        }
    }
}
