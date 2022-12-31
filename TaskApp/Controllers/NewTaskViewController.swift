//
//  NewTaskViewController.swift
//  TaskApp
//
//  Created by Junaid on 31/12/2022.
//

import UIKit
import Combine
class NewTaskViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var saveTask: UIButton!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var bottomContainerViewBottomConstraint: NSLayoutConstraint!

     // MARK: - Properties
    private var subscribers = Set<AnyCancellable>()
    @Published private  var  taskString: String?
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        bottomContainerViewBottomConstraint.constant = -bottomContainerView.frame.height
        addTapGesture()
        ObserveKeyBoard()
        observeNewTaskTextField()
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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        let keyboardHeight = getKeyboardHeight(notification)

        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5) { [unowned self] in
            self.bottomContainerViewBottomConstraint.constant = keyboardHeight - (200 + 8)
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        bottomContainerViewBottomConstraint.constant = -bottomContainerView.frame.height

    }

    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        guard let height = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else { return 0.0}
        return height
    }

     // MARK: - Observe TextField

    private func observeNewTaskTextField() {
        NotificationCenter.default.publisher(for:UITextField.textDidChangeNotification)
            .map { (notification) -> String? in
                return (notification.object as? UITextField)?.text
            }.sink { [unowned self] text in
                self.taskString = text
            }.store(in: &subscribers)


    }
}
