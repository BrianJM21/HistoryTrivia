//
//  WelcomeViewController.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 09/02/23.
//

import UIKit

class WelcomeViewController: UIViewController {
                
    @IBOutlet var welcomeView: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var quickGameSwitch: UISwitch!
    
    @IBOutlet weak var numberOfQuestionsLabel: UILabel!
    
    @IBOutlet weak var numberOfQuestionsTextField: UITextField!
    
    @IBOutlet weak var quickGameLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    let alert = UIAlertController(title: "ERROR", message: "", preferredStyle: .alert)
    let alertOKButton = UIAlertAction(title: "OK", style: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()

    }
    
    func setupView() {
        
        CoreDataService.shared.load()
        self.alert.addAction(self.alertOKButton)
        self.hideKeyboardWhenTappedAround()
        
        self.welcomeView.backgroundColor = GameColors.main
        
        self.descriptionLabel.textColor = GameColors.text
        self.descriptionLabel.font = .boldSystemFont(ofSize: 22.0)
        self.descriptionLabel.text = "¡Pongamos a prueba tus conocimientos de Historia!\n\nSelecciona la respuesta correcta a cada una de las preguntas dadas. Al final, te mostraremos tu resultado."
        
        self.quickGameSwitch.isOn = false
        self.quickGameLabel.textColor = GameColors.text
        self.numberOfQuestionsLabel.textColor = GameColors.text
        self.numberOfQuestionsLabel.isHidden = true
        self.numberOfQuestionsTextField.isHidden = true
        
        self.playButton.configuration?.titlePadding = 5
        self.playButton.tintColor = GameColors.text
        self.playButton.configuration?.background.backgroundColor = GameColors.accent
        self.playButton.setTitle("¡A jugar!", for: .normal)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+Preguntas", style: .done, target: self, action: #selector(self.addQuestion))
    }
    
    @objc func addQuestion() {
        
        self.navigationController?.pushViewController(AddQuestionViewController(), animated: true)
    }
    
    @IBAction func quickGameSwitchAction(_ sender: Any) {
        
        if self.quickGameSwitch.isOn {
            
            self.numberOfQuestionsLabel.isHidden = false
            self.numberOfQuestionsTextField.isHidden = false
            self.numberOfQuestionsTextField.placeholder = "max. \(QuestionModel.allQuestions.count)"
        } else {
            
            self.numberOfQuestionsLabel.isHidden = true
            self.numberOfQuestionsTextField.isHidden = true
        }
    }
    
    
    @IBAction func playButtonAction(_ sender: Any) {
        
        GameModel.gameQuestions = QuestionModel.allQuestions.count
        if self.quickGameSwitch.isOn {
            
            guard !self.numberOfQuestionsTextField.text!.isEmpty else {
                self.alert.message = QError.numberOfQuestionsIsEmpty.localizedDescription
                self.present(self.alert, animated: true); return }
            if let numberOfQuestion = Int(self.numberOfQuestionsTextField.text!) {
                
                guard numberOfQuestion > 0 && numberOfQuestion <= QuestionModel.allQuestions.count else {
                    self.alert.message = QError.invalidNumberOfQuestions.localizedDescription
                    self.present(self.alert, animated: true); return }
                GameModel.gameQuestions = numberOfQuestion
            } else {
                
                self.alert.message = QError.invalidNumberOfQuestions.localizedDescription
                self.present(self.alert, animated: true)
            }
        }
        self.navigationController?.pushViewController(GameViewController(), animated: true)
    }
    

}

extension WelcomeViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
}
