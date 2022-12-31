//
//  NewTaskViewController.swift
//  TaskApp
//
//  Created by Junaid on 31/12/2022.
//

import UIKit

class NewTaskViewController: UIViewController {

     // MARK: - IBOutlet
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var saveTask: UIButton!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var bottomContainerViewBottomConstraint: NSLayoutConstraint!
     // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        addTapGesture()
        ObserveKeyBoard()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskTextField.becomeFirstResponder()
    }

     // MARK: - IBAction
    @IBAction func saveButtonDidTapped(){

    }

     // MARK: - Tap Gesture
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func handleKeyBoard() {
        self.dismiss(animated: true)
    }

     // MARK: - Keyboard height

    private func ObserveKeyBoard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification)
        print(keyboardHeight)
    }

    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        guard let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return 0.0}
        return height
    }
}
