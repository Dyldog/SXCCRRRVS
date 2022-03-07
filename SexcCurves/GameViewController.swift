//
//  GameViewController.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import UIKit

class GameViewController: UIViewController, LevelDelegate {
    let levels: [LevelViewController.Type] = [
        LevelOneBabeeViewController.self,
//        FakeLevelTwoBabee.self
    ] + [GameSuccessViewController.self]
    
    var currentLevel = 0
    var currentLevelViewController: LevelViewController!
    let levelContainer: UIView
    let levelTitleLabel: UILabel
    let levelScoreLabel: UILabel
    
    required init?(coder: NSCoder) {
        levelContainer = UIView()
        levelTitleLabel = UILabel()
        levelScoreLabel = UILabel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isUserInteractionEnabled = true
        
        levelContainer.embed(in: view)
        
        levelTitleLabel.text = "LEVEL TITLE"
        levelTitleLabel.numberOfLines = 0
        levelTitleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        levelScoreLabel.text = "LEVEL SCORE"
        let textStackView = UIStackView(arrangedSubviews: [levelTitleLabel, levelScoreLabel])
        textStackView.axis = .vertical
        textStackView.pinToBottom(of: view, padding: .init(horizontal: 20))
        initialiseCurrentLevel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentLevelViewController.start()
    }
    
    func initialiseCurrentLevel() {
        if let currentVC = currentLevelViewController {
            currentVC.delegate = nil
            currentVC.willMove(toParent: nil)
            currentVC.view.removeFromSuperview()
            currentVC.didMove(toParent: nil)
        }
        
        let currentType = levels[currentLevel]
        levelTitleLabel.text = currentType.levelTitle
        let viewController = currentType.init()
        viewController.delegate = self
        addChild(viewController)
        viewController.view.isUserInteractionEnabled = true
        viewController.view.embed(in: levelContainer)
        viewController.didMove(toParent: self)
        currentLevelViewController = viewController
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        currentLevelViewController.handleTouchesBegan(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        currentLevelViewController.handleTouchesMoved(touches)
    }
    
    // MARK: - Level Delegate
    
    func didUpdateProgress(to progress: String) {
        levelScoreLabel.text = progress
    }
    func didFinish() {
        currentLevel += 1
        initialiseCurrentLevel()
    }
}

protocol LevelViewController: UIViewController {
    static var levelTitle: String { get }
    init()
    func start()
    var delegate: LevelDelegate? { get set }
    func handleTouchesBegan(_ touches: Set<UITouch>)
    func handleTouchesMoved(_ touches: Set<UITouch>)
}

protocol LevelDelegate: AnyObject {
    func didFinish()
    func didUpdateProgress(to progress: String)
}
