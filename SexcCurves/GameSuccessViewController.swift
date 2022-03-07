//
//  GameSuccessViewController.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import UIKit

class GameSuccessViewController: UIViewController, LevelViewController {
    
    static var levelTitle: String { "" }
    weak var delegate: LevelDelegate?
    
    func start() { print("Fuck u") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.text = "You Won\nGood Job"
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 80)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.embed(in: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.didUpdateProgress(to: "")
    }
    
    func handleTouchesBegan(_ touches: Set<UITouch>) {
        print("Fuck u")
    }
    
    func handleTouchesMoved(_ touches: Set<UITouch>) {
        print("Fuck u")
    }

}
