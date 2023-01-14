//
//  NewTaskViewController.swift
//  TaskApp
//
//  Created by Junaid on 31/12/2022.
//

import UIKit
import Combine
import CombineCocoa
class NewTaskViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var saveTaskButton: UIButton!
    @IBOutlet weak var bottomContainerView: UIView!
    @IBOutlet weak var bottomContainerViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    private var subscribers = Set<AnyCancellable>()
    @Published private  var  taskString: String?

     // MARK: - ViewModel
    let viewModel = NewTaskViewModel()

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupView()
        addTapGesture()
        ObserveKeyBoard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskTextField.becomeFirstResponder()
    }
    
    // MARK: -  SetupView
    fileprivate func setupView() {
        self.view.backgroundColor = UIColor(white: 0.3, alpha: 0.4)
        bottomContainerViewBottomConstraint.constant = -bottomContainerView.frame.height
    }
    
    // MARK: - Tap Gesture
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleKeyBoard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleKeyBoard() {
        self.dismiss(animated: true)
    }
    
    @IBAction func calendarButtonDidTapped(){
        print("calendarButton did tapped")
    }

    func bind() {

        let input = NewTaskViewModel.Input(textFieldPublihser: taskTextField.textPublisher.eraseToAnyPublisher(),
                                           saveButtonTapPublisher: saveTaskButton.tapPublisher.eraseToAnyPublisher())
        let output = viewModel.transfor(input: input)

        output.validator.sink {[unowned self] isTrue in
            self.saveTaskButton.isEnabled = isTrue
        }.store(in: &subscribers)
    }
}

 // MARK: - Keyboard hide And show
extension NewTaskViewController {

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

}
