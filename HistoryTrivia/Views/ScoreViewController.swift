//
//  ScoreViewController.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 10/02/23.
//

import UIKit

class ScoreViewController: UIViewController {
    
    let scoreViewModel: ScoreViewModel
    
    var performance: String?
    
    init(scoreViewModel: ScoreViewModel) {
        
        self.scoreViewModel = scoreViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet var scoreView: UIView!
    
    @IBOutlet weak var finalScoreTextLabel: UILabel!
    
    @IBOutlet weak var finalScoreLabel: UILabel!
    
    @IBOutlet weak var answerSummaryLabel: UILabel!
    
    @IBOutlet weak var retakeButton: UIButton!
    
    @IBOutlet weak var homeButton: UIButton!
    
    lazy var buttons: [UIButton] = [self.retakeButton, self.homeButton]
    lazy var labels: [UILabel] = [self.finalScoreTextLabel, self.finalScoreLabel, self.answerSummaryLabel]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    func setupView() {
        
        self.navigationItem.hidesBackButton = true
        
        self.scoreView.backgroundColor = GameColors.main
        
        for label in self.labels {
            
            label.textColor = GameColors.text
            label.textAlignment = .center
        }
        
        self.finalScoreLabel.font = .boldSystemFont(ofSize: 32.0)
        self.finalScoreLabel.text = ("\(scoreViewModel.percentage)%")
        self.answerSummaryLabel.font = .boldSystemFont(ofSize: 22.0)
        self.evaluatePerformance()
        self.answerSummaryLabel.text = ("\(scoreViewModel.correctGuesses) respuestas correctas ✅\n\(scoreViewModel.incorrectGuesses) respuestas incorrectas ❌\n\n\(self.performance ?? "")")
        
        for button in self.buttons {
            
            button.configuration?.titlePadding = 5
            button.tintColor = GameColors.text
            button.configuration?.background.backgroundColor = GameColors.accent
        }
    }
    
    func evaluatePerformance() {
        
        if scoreViewModel.percentage == 0 {
            
            self.performance = "Necesitas ponerte a estudiar... ¡YA! 😳"
            return
        }
        
        if scoreViewModel.percentage <= 25 {
            
            self.performance = "La historia no se te da muy bien ¿eh?... ¡Pero seguro que lo puedes hacer mejor! 😅"
            return
        }
        
        if scoreViewModel.percentage <= 50 {
            
            self.performance = "Conoces lo mínimo indispensable... ¡Animate a conocer más, la historia es fascinante! 😉"
            return
        }
        
        if scoreViewModel.percentage <= 75 {
            
            self.performance = "¡Muy bien! Conoces la historia y seguro que te gusta profundizar en ella regularmente 😏"
            return
        }
        
        if scoreViewModel.percentage < 100 {
            
            self.performance = "¡Excelente! eres un gran conocedor de la historia, lo cual te permite entender el porqué vivimos como lo hacemos actualmente 😎"
            return
        }
        
        if scoreViewModel.percentage == 100 {
            
            self.performance = "¡WOOW! Eres todo un historiador de closet 🤩"
        }
    }
    
    @IBAction func retakeButtonAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func homeButtonAction(_ sender: Any) {
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
