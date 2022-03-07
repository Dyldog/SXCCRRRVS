//
//  ViewController.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import UIKit

class LevelOneBabeeViewController: UIViewController, LevelViewController {
    
    let arrowView: UILabel
    let circleView: UILabel
    var updateTimer: Timer!
    
    weak var delegate: LevelDelegate?
    
    static var levelTitle: String { "This is what you wanted" }
    
    var currentRound = 0
    var totalRounds = 10
    
    var boneState: BoneState {
        let arrowRect = arrowView.frame
        let circleRect = circleView.frame
        
        if arrowRect.intersects(circleRect) == false {
            return .notBoning
        } else if circleRect.verticallyContains(arrowRect) == false {
            return .incorrectlyBoning
        } else {
            return .boning
        }
    }
    
    var coitalState: CoitalState {
        if arrowView.frame.maxX < circleView.frame.minX {
            return .preCoitus
        } else if circleView.frame.maxX < arrowView.frame.minX {
            return .postCoitus
        } else {
            return .midCoitus
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        arrowView = UILabel()
        circleView = UILabel()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        arrowView = UILabel()
        circleView = UILabel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleView.text = "O"
        circleView.backgroundColor = .red
        circleView.font = .systemFont(ofSize: 48)
        circleView.sizeToFit()
        view.addSubview(circleView)
        
        arrowView.text = "~~~>"
        arrowView.backgroundColor = .blue
        arrowView.sizeToFit()
        view.addSubview(arrowView)
    }
    
    func start() {
        updateTimer = Timer.scheduledTimer(
            timeInterval: .frameRate,
            target: self,
            selector: #selector(update),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func update() {
        let didReset = advanceCircleView()
        updateRoundOutcome()
        
        if didReset {
            resetRoundOutcome()
            currentRound += 1
            
            if currentRound == totalRounds {
                finish()
            }
        }
        
        delegate?.didUpdateProgress(to: "Sexc Time \(currentRound) / \(totalRounds)")
        updateBackgroundForCurrentBoneState()
    }
    
    func finish() {
        updateTimer.invalidate()
        delegate?.didFinish()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arrowView.center = view.bounds.center
        circleView.center = view.trailingCenter
    }
    
    func handleTouchesBegan(_ touches: Set<UITouch>) {
        //
    }
    func handleTouchesMoved(_ touches: Set<UITouch>) {
        arrowView.center.y += touches.first!.verticalChange(in: view)
        updateBackgroundForCurrentBoneState()
    }
    
    func updateBackgroundForCurrentBoneState() {
        let color: UIColor
        
        switch boneState {
        case .notBoning: color = .white
        case .boning: color = .green
        case .incorrectlyBoning: color = .red
        }
        
        view.backgroundColor = color
    }
    
    var oscillationPeriod: CGFloat = 500
    var oscillationMagnitude: CGFloat = 10
    var circlePositionStep: CGFloat = 5
    
    /// Used to adjust the oscillation so it animates smoothly.
    var oscillationXOffset: CGFloat = 0

    /// Moves the circle view
    /// - Returns: Whether the view was reset to the edge of the screen or not
    func advanceCircleView() -> Bool {
        circleView.center.x -= circlePositionStep
        
        let oscillationPosition = (circleView.frame.minX + oscillationXOffset).truncatingRemainder(dividingBy: view.frame.width) / oscillationPeriod
        let oscillation = sin(2.0 * .pi * oscillationPosition) * oscillationMagnitude
        print(oscillation)
        circleView.center.y = view.center.y + oscillation
        if circleView.frame.maxX < 0 {
            circleView.frame.origin.x = view.bounds.maxX
            return true
        } else {
            return false
        }
    }
    
    var hasFailedThisRound: Bool = false
    var hasSucceededThisRound: Bool = false
    
    func updateRoundOutcome() {
        guard hasFailedThisRound == false, hasSucceededThisRound == false else { return }
        guard coitalState != .preCoitus else { return }
        
        if coitalState == .postCoitus {
            hasSucceededThisRound = true
            didReachRoundOutcome(true)
        } else if coitalState == .midCoitus, boneState != .boning {
            hasFailedThisRound = true
            didReachRoundOutcome(false)
        }
    }
    
    func resetRoundOutcome() {
        hasFailedThisRound = false
        hasSucceededThisRound = false
    }
    
    func didReachRoundOutcome(_ success: Bool) {
        showOutcomeMessage(success: success)
        applyStat(success: success)
    }
    
    func applyStat(success: Bool) {
        let statFunction: (Bool) -> Void = [
            changeArrowSize,
            changeCircleSize,
            changeOscillationPeriod,
            changeOscillationMagnitude,
            changeSpeed
        ].randomElement()!
        statFunction(success)
    }
    
    func changeArrowSize(success: Bool) {
        // Arrow gets bigger when user succeeds
        arrowView.randomlyAdjustSize(increase: success)
    }
    
    func changeCircleSize(success: Bool) {
        // Circle gets smaller when user succeeds
        circleView.randomlyAdjustSize(increase: success == false)
    }
    
    func changeOscillationMagnitude(success: Bool) {
        // Oscillates more when user succeeds
        oscillationMagnitude += (success ? 1 : -1) * CGFloat((0...10).randomElement()!)
        // TODO: Update oscillation offset so the change animates smoothly
    }
    
    func changeOscillationPeriod(success: Bool) {
        // Shorter period when user succeeds
        oscillationPeriod += (success ? -1 : 1) * CGFloat((0...10).randomElement()!)
        // TODO: Update oscillation offset so the change animates smoothly
    }
    
    func changeSpeed(success: Bool) {
        // Faster when user succeeds
        circlePositionStep += (success ? 1 : -1)
        circlePositionStep = max(circlePositionStep, 1)
    }
    
    func showOutcomeMessage(success: Bool) {
        let text: String
        switch success {
        case true: text = successMessages.randomElement()!
        case false: text = failureMessages.randomElement()!
        }
        
        let label = FadingLabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 48)
        label.text = text
        let size = label.systemLayoutSizeFitting(view.frame.size)
        label.frame.size = size
        label.topCenter = view.bounds.topCenter + (0, view.frame.height / 5)
        view.addSubview(label)
    }
    
    let successMessages: [String] = [
        "Feel like a big man now?",
        "Round 2?"
    ]
    
    let failureMessages: [String] = [
        "Better luck next time, cowboy",
        "Actually, I forgot I had something else on"
    ]
}

enum BoneState {
    case notBoning
    case boning
    case incorrectlyBoning
}

enum CoitalState {
    case preCoitus
    case midCoitus
    case postCoitus
}


class FakeLevelTwoBabee: LevelOneBabeeViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        loadViewIfNeeded()
        view.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
