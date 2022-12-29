//
//  TaskViewController.swift
//  TaskApp
//
//  Created by Junaid on 29/12/2022.
//

import UIKit

class TaskViewController: UIViewController {
    @IBOutlet weak var segmmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupSegmentedControl()
    }

    private func setupSegmentedControl() {
        segmmentedControl.removeAllSegments()

        MenuSection.allCases.enumerated().forEach { index, section in
            segmmentedControl.insertSegment(withTitle: section.rawValue, at: index, animated: false)
        }

        segmmentedControl.selectedSegmentIndex = 0
    }

}

