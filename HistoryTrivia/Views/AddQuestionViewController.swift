//
//  AddQuestionViewController.swift
//  HistoryTrivia
//
//  Created by Brian Jiménez Moedano on 10/02/23.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    @IBOutlet var addQuestionView: UIView!
    
    @IBOutlet weak var addQuestionScrollView: UIView!
    
    @IBOutlet weak var guideLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var answersLabel: UILabel!
    
    @IBOutlet weak var answerOneTextField: UITextField!
    
    @IBOutlet weak var answerTwoTextField: UITextField!
    
    @IBOutlet weak var answerThreeTextField: UITextField!
    
    @IBOutlet weak var answerFourTextField: UITextField!
    
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    @IBOutlet weak var correctAnswerTextField: UITextField!
    
    @IBOutlet weak var addQuestionButton: UIButton!
    
    lazy var labels: [UILabel] = [self.guideLabel,
                                  self.questionLabel,
                                  self.answersLabel,
                                  self.correctAnswerLabel]
    
    lazy var textFields: [UITextField] = [self.answerOneTextField,
                                         self.answerTwoTextField,
                                         self.answerThreeTextField,
                                         self.answerFourTextField]
    var textAnswers: [String] = []
    
    let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
    lazy var alertOKButton = UIAlertAction(title: "OK", style: .default) {
        
        [weak self] _ in
        
        if self?.alert.title == "ÉXITO" {
            
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    var viewHeight: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
        self.viewHeight = self.view.frame.size.height
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.viewHeight == self.view.frame.size.height {
                
                self.view.frame.size.height -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notificacion: NSNotification) {
        
        if let keyboardSize = (notificacion.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.viewHeight != self.view.frame.size.height {
                
                self.view.frame.size.height += keyboardSize.height
            }
        }
    }
    
    func setupView() {
        
        self.hideKeyboardWhenTappedAround()
        
        self.alert.addAction(self.alertOKButton)
        
        self.addQuestionView.backgroundColor = GameColors.main
        self.addQuestionScrollView.backgroundColor = GameColors.main
        
        for label in self.labels {
            
            label.textColor = GameColors.text
            label.font = .boldSystemFont(ofSize: 22.0)
            label.textAlignment = .center
        }
        self.guideLabel.text = "Instrucciones: ¡Agregar preguntas personalizadas y reta a tus amigos! (Así harás el juego más interesante 😉).\n\nSólo recuerda rellenar todos los campos con datos válidos, tal como se indica en las guías de ayuda."
        
        self.addQuestionButton.configuration?.titlePadding = 5
        self.addQuestionButton.tintColor = GameColors.text
        self.addQuestionButton.configuration?.background.backgroundColor = GameColors.accent
    }
        
    func presentAlert(title: String, message: String) {
        
        if !self.textAnswers.isEmpty { self.textAnswers.removeAll() }
        self.alert.title = title
        self.alert.message = message
        self.present(self.alert, animated: true)
    }
    
    @IBAction func addQuestionButtonAction(_ sender: Any) {
        
        self.view.endEditing(true)
        for textField in self.textFields {
            
            guard !textField.text!.isEmpty else {
                
                self.presentAlert(title: "ERROR", message: QError.possibleAnswerIsEmpty.localizedDescription)
                return
            }
            
            self.textAnswers.append(textField.text!)
        }
        
        guard !self.correctAnswerTextField.text!.isEmpty else {
            
            self.presentAlert(title: "ERROR", message: QError.correctAnswerIndexIsEmpty.localizedDescription)
            return
        }
        
        if let correctAnswerIndex = Int(self.correctAnswerTextField.text!) {
            
            GameModel.addQuestion(question: self.questionTextField.text!, answers: self.textAnswers, correctAnswerIndex: correctAnswerIndex - 1) {
                
                [weak self] completion in
                
                switch completion {
                    
                case .success(_) : CoreDataService.shared.save(question: (self?.questionTextField.text)!, answers: [(self?.textAnswers[0])!, (self?.textAnswers[1])!, (self?.textAnswers[2])!, (self?.textAnswers[3])!], correctAnswer: correctAnswerIndex - 1)
                                   self?.presentAlert(title: "ÉXITO", message: "¡Se agregó la nueva pregunta!")
                    
                    case .failure(let error) : self?.presentAlert(title: "ERROR", message: error.localizedDescription)
                }
            }
        } else {
            
            self.presentAlert(title: "ERROR", message: QError.invalidCorrectAnswerIndex.localizedDescription)
            return
        }
    }
    
}

extension AddQuestionViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        
        self.view.endEditing(true)
    }
}
