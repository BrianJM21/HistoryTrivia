//
//  QuestionViewController.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 07/02/23.
//

import UIKit
import Combine

class GameViewController: UIViewController {
    
    var gameViewModel: GameViewModel?
    
    var subscriber: AnyCancellable?
    
    var answerIndex: Int?
    
    // Conexión a los elementos visuales de la Vista.
    
    @IBOutlet var questionView: UIView!
    
    @IBOutlet weak var questionScrollView: UIView!
    
    @IBOutlet weak var questionTextLabel: UILabel!
    
    @IBOutlet weak var answerOneButton: UIButton!
    
    @IBOutlet weak var answerTwoButton: UIButton!
    
    @IBOutlet weak var answerThreeButton: UIButton!
    
    @IBOutlet weak var answerFourButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    // Al hacer referencia a sus mismas propiedades la inicialización debe ser retardada.
    
    lazy var buttons: [UIButton] = [self.answerOneButton,
                                          self.answerTwoButton,
                                          self.answerThreeButton,
                                          self.answerFourButton,
                                          self.nextButton]
    
    override func viewWillAppear(_ animated: Bool) {

        self.setupView()
        self.updateView()
    }
    
    // Configura las propiedades de los elementos visuales de la Vista.
    
    func setupView() {
        
        self.gameViewModel = GameViewModel()
        
        subscriber = self.gameViewModel?.objectWillChange.sink(receiveValue: {
            
            _ in
            
            guard (self.gameViewModel != nil) else { return }
            if self.gameViewModel!.guessWasMade {
                
                for i in stride(from: 0, to: self.gameViewModel!.currentQuestion.possibleAnswers.count, by: 1) {
                    
                    self.buttons[i].isEnabled = false
                }
                
                if self.gameViewModel!.currentQuestion.correctAnswerIndex == self.answerIndex {
                    
                    self.buttons[self.answerIndex!].configuration?.background.backgroundColor = GameColors.correctAnswer
                } else {
                    
                    self.buttons[self.answerIndex!].configuration?.background.backgroundColor = GameColors.incorrectAnswer
                }
                
                self.nextButton.isHidden = false
            }
        })
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: GameColors.text]
        
        self.questionView.backgroundColor = GameColors.main
        
        self.questionScrollView.backgroundColor = GameColors.main
        
        self.questionTextLabel.textColor = GameColors.text
        self.questionTextLabel.font = .boldSystemFont(ofSize: 32.0)
        self.questionTextLabel.textAlignment = .center
        
        for answerButton in self.buttons {
            
            answerButton.configuration?.titlePadding = 5
            answerButton.tintColor = GameColors.text
            answerButton.configuration?.background.backgroundColor = GameColors.accent
        }
        
        self.nextButton.configuration?.title = "Siguiente"
    }
    
    func updateView() {
        
        self.navigationItem.title = self.gameViewModel?.questionProgressText
        
        self.questionTextLabel.text = self.gameViewModel?.currentQuestion.questionText
        
        guard (self.gameViewModel != nil) else { return }
        
        for i in stride(from: 0, to: self.gameViewModel!.currentQuestion.possibleAnswers.count, by: 1) {
            
            self.buttons[i].configuration?.title = self.gameViewModel!.currentQuestion.possibleAnswers[i]
            self.buttons[i].isEnabled = true
            self.buttons[i].configuration?.background.backgroundColor = GameColors.accent

        }
        
        self.nextButton.isHidden = true
    }
    
    func makeGuess(atIndex index: Int) {
        
        self.answerIndex = index
        self.gameViewModel?.makeGuess(atIndex: index)
        self.gameViewModel?.displayNextQuestion()
    }
        
    @IBAction func answerOneActionButton(_ sender: Any) {
        
        self.makeGuess(atIndex: 0)
    }
    
    @IBAction func answerTwoActionButton(_ sender: Any) {
        
        self.makeGuess(atIndex: 1)
    }
    
    @IBAction func answerThreeActionButton(_ sender: Any) {
        
        self.makeGuess(atIndex: 2)
    }
    
    @IBAction func answerFourActionButton(_ sender: Any) {
        
        self.makeGuess(atIndex: 3)

    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        guard (self.gameViewModel != nil) else { return }

        if self.gameViewModel!.gameIsOver {
            
            self.subscriber?.cancel()
            self.navigationController?.pushViewController(ScoreViewController(scoreViewModel: ScoreViewModel(correctGuesses: self.gameViewModel!.correctGuesses, incorrectGuesses: self.gameViewModel!.incorrectGuesses)), animated: true)
            self.gameViewModel = nil
            self.subscriber = nil
        } else {
            
            self.updateView()
        }
    }
    

}
