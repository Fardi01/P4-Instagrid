//
//  ViewController.swift
//  P.4_Instagrid
//
//  Created by fardi Clk on 17/03/2021.
//
// ⚠️ Le fichier teste !

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
//MARK: - Outlets
    
    @IBOutlet weak var swipUpLabel: UILabel!
    @IBOutlet weak var arrowUpImage: UIImageView!
    @IBOutlet weak var arrowLeftImage: UIImageView!
    @IBOutlet weak var gridStackView: UIStackView!
    
//Pour Les boutons de switch entre les 3 vues
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
// Les vue superieurs de la grille
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topLeftImage: UIImageView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var topRightImage: UIImageView!
    @IBOutlet weak var topLeftButton: UIButton!
    
//Les vues inferieurs de la grille
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var bottomleftView: UIView!
    @IBOutlet weak var bottomLeftImage: UIImageView!
    @IBOutlet weak var bottomRightView: UIView!
    @IBOutlet weak var bottomRightImage: UIImageView!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    
    
//MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Swipe Up pour la grille du bouton centrale en mode Portrait
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        gridStackView.addGestureRecognizer(swipeUp)
        view.addGestureRecognizer(swipeUp)
        
        //Swipe Up pour la grille du bouton centrale en mode Portrait
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        gridStackView.addGestureRecognizer(swipeLeft)
        view.addGestureRecognizer(swipeLeft)
    }
    

    
//MARK: - Switch Grid buttons

    @IBAction func didTappedLeftButton(_ sender: UIButton) {
        selectedButton(tappedButton.leftButton)
        changeGridLeftButton()
    }

    
    @IBAction func didTappedCenterButton(_ sender: UIButton) {
        selectedButton(tappedButton.centerButton)
        changeGridCenterButton()
    }

    
    @IBAction func didTappedRightButton(_ sender: UIButton) {
        selectedButton(tappedButton.rightButton)
        changeGridRightButton()
    }

    private func changeGridLeftButton(){
        topRightView.isHidden = true
        topLeftView.frame.size.width = 270
        topLeftButton.frame.size.width = 270
        topLeftImage.frame.size.width = 270
        bottomRightView.frame.size.width = 127
        bottomRightButton.frame.size.width = 127
        bottomRightImage.frame.size.width = 127
        bottomleftView.isHidden = false
    }
    
    private func changeGridCenterButton(){
        bottomleftView.isHidden = true
        bottomRightView.frame.size.width = 270
        bottomRightButton.frame.size.width = 270
        bottomRightImage.frame.size.width = 270
        topLeftView.frame.size.width = 127
        topLeftButton.frame.size.width = 127
        topLeftImage.frame.size.width = 127
        topRightView.isHidden = false
    }
    
    private func changeGridRightButton(){
        topLeftView.frame.size.width = 127
        topLeftButton.frame.size.width = 127
        topLeftImage.frame.size.width = 127
        bottomRightView.frame.size.width = 127
        bottomRightButton.frame.size.width = 127
        bottomRightImage.frame.size.width = 127
        bottomleftView.isHidden = false
        topRightView.isHidden = false
    }
    
    enum tappedButton {
        case leftButton, centerButton, rightButton
    }
    
    private func selectedButton(_ isSelected: tappedButton) {
        switch isSelected {
        case .leftButton:
            leftButton.isSelected = true
            centerButton.isSelected = false
            rightButton.isSelected = false
        case .centerButton:
            centerButton.isSelected = true
            leftButton.isSelected = false
            rightButton.isSelected = false
        case .rightButton:
            rightButton.isSelected = true
            centerButton.isSelected = false
            leftButton.isSelected = false
        }
    }
    
    
//MARK: - Image Picker
    
    var index = 0
    
    @IBAction func topLeftButton(_ sender: UIButton) {
        index = 1
        pickerImageDelegate()
    }
    
    @IBAction func topRightButton(_ sender: UIButton) {
        index = 2
        pickerImageDelegate()
    }
    
    @IBAction func bottomLeftButton(_ sender: UIButton) {
        index = 3
        pickerImageDelegate()
    }
    
    @IBAction func bottomRightButton(_ sender: UIButton) {
        index = 4
        pickerImageDelegate()
    }
    
// Ouvrir la bibliothèque d'image de l'utilisateur !
   func pickerImageDelegate(){
        let image = UIImagePickerController()
        image.sourceType = .photoLibrary
        image.delegate = self
        image.allowsEditing = false
        self.present(image, animated: true)
    }

// J'affecte l'image à la vue correspondante.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            if index == 1 {
                topLeftImage.image = image
            }else if index == 2{
                topRightImage.image = image
            }else if index == 3{
                bottomLeftImage.image = image
            }else if index == 4{
                bottomRightImage.image = image
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
//MARK: - Swipe Animation
    
//L'utilisateur swipe en mode portrait ou en mode paysage.
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer){
        if UIDevice.current.orientation.isLandscape {
            sender.direction = .left
                animateSwipe(translationX: -view.frame.width, y: 0)
        } else {
            sender.direction = .up

            animateSwipe(translationX: 0, y: -view.frame.height)
        }
    }
    
//La translation de la grille pour quitter l'écran.
    private func animateSwipe(translationX x: CGFloat, y: CGFloat){
        UIView.animate(withDuration: 0.5) {
            self.gridStackView.transform = CGAffineTransform(translationX: x, y: y)
            self.arrowUpImage.transform = CGAffineTransform(translationX: x, y: y)
            self.arrowLeftImage.transform = CGAffineTransform(translationX: x, y: y)
            self.swipUpLabel.transform = CGAffineTransform(translationX: x, y: y)
        } completion: { (Bool) in
            self.imageShare()
        }
    }
    
    
    
//Genere l'image qui sera partagée
    private func imageShare(){
        UIGraphicsBeginImageContext(gridStackView.frame.size)
        gridStackView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let activityController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        activityController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                print("share completed")
                self.animateBackToCenter()
                return
            } else {
                print("cancel")
                self.animateBackToCenter()
            }
        }
        present(activityController, animated: true, completion: nil)
    }
    
    
//Pour faire revenir la grille à son emplacement initiale.
    private func animateBackToCenter(){
        UIView.animate(withDuration: 0.5, animations: {
            self.gridStackView.transform = .identity
            self.arrowUpImage.transform = .identity
            self.arrowLeftImage.transform = .identity
            self.swipUpLabel.transform = .identity
        }, completion: nil)
    }

}
