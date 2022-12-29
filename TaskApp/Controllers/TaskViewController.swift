//
//  TaskViewController.swift
//  TaskApp
//
//  Created by Junaid on 29/12/2022.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet weak var segmmentedControl: UISegmentedControl!
    @IBOutlet weak var ongoingContainerView: UIView!
    @IBOutlet weak var doneContainerView: UIView!
    private var selectedSection: MenuSection = .ongoing
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSegmentedControl()
        showContainerView()

    }

    private func setupSegmentedControl() {
        segmmentedControl.removeAllSegments()

        MenuSection.allCases.enumerated().forEach { index, section in
            segmmentedControl.insertSegment(withTitle: section.rawValue, at: index, animated: false)
        }

        segmmentedControl.selectedSegmentIndex = 0
    }

    private func showContainerView() {
        switch selectedSection {
        case .ongoing:
            ongoingContainerView.isHidden = false
            doneContainerView.isHidden = true
        case .done:
            ongoingContainerView.isHidden = true
            doneContainerView.isHidden = false
        }
    }

    @IBAction func segmentedControllerDidTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSection = .ongoing
        default:
            selectedSection = .done
        }

        showContainerView()
    }

}

