//
//  ViewController.swift
//  P.4_Instagrid
//
//  Created by fardi Clk on 17/03/2021.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
//MARK: - Outlets
    
    @IBOutlet weak var swipUpLabel: UILabel!
    @IBOutlet weak var arrowUpImage: UIImageView!
    @IBOutlet weak var arrowLeftImage: UIImageView!
    
//Pour Les boutons de switch entre les 3 vues
    @IBOutlet weak var centerButtonGrid: UIView!
    @IBOutlet weak var rightButtonGrid: UIView!
    @IBOutlet weak var leftButtonGrid: UIView!
    
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var centerButtonIsSelected: UIImageView!
    @IBOutlet weak var rightButtonIsSelected: UIImageView!
    @IBOutlet weak var leftButtonIsSelected: UIImageView!
    
//Les images des 3 vues !
    @IBOutlet weak var centerGridLeftImage: UIImageView!
    @IBOutlet weak var centerGridRightImage: UIImageView!
    @IBOutlet weak var centerGridBottomImage: UIImageView!
    
    @IBOutlet weak var leftGridTopImage: UIImageView!
    @IBOutlet weak var leftGridLeftImage: UIImageView!
    @IBOutlet weak var leftGridRightImage: UIImageView!
    
    @IBOutlet weak var rightGridTopLeftImage: UIImageView!
    @IBOutlet weak var rightGridTopRightImage: UIImageView!
    @IBOutlet weak var rightGridBottomLeftImage: UIImageView!
    @IBOutlet weak var rightGridBottomRightImage: UIImageView!
    
    @IBOutlet var gridButtons: [UIButton]!
    
    
//MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Swipe Up pour la grille du bouton centrale en mode Portrait
        let swipeUpCenterGrid = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(_:)))
        swipeUpCenterGrid.direction = UISwipeGestureRecognizer.Direction.up
        centerButtonGrid.addGestureRecognizer(swipeUpCenterGrid)
        
        //Swipe up pour la grille du bouton gauche en mode Portrait
        let swipeUpLeftGrid = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(_:)))
        swipeUpLeftGrid.direction = UISwipeGestureRecognizer.Direction.up
        leftButtonGrid.addGestureRecognizer(swipeUpLeftGrid)

        //Swipe up pour la grille du bouton droit en mode Portrait
        let swipeUpRightGrid = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(_:)))
        swipeUpRightGrid.direction = UISwipeGestureRecognizer.Direction.up
        rightButtonGrid.addGestureRecognizer(swipeUpRightGrid)
        
        
        
        //Swipe left pour la grille du bouton central en mode paysage
        let swipeLeftCenterGrid = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(_:)))
        swipeLeftCenterGrid.direction = UISwipeGestureRecognizer.Direction.left
        centerButtonGrid.addGestureRecognizer(swipeLeftCenterGrid)
        
        //Swipe left pour la grille du bouton gauche en mode paysage
        let swipeLeftLeftGrid = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(_:)))
        swipeLeftLeftGrid.direction = UISwipeGestureRecognizer.Direction.left
        leftButtonGrid.addGestureRecognizer(swipeLeftLeftGrid)
        
        //Swipe left pour la grille du bouton droite en mode paysage
        let swipeLeftRightGrid = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeAction(_:)))
        swipeLeftRightGrid.direction = UISwipeGestureRecognizer.Direction.left
        rightButtonGrid.addGestureRecognizer(swipeLeftRightGrid)
        
    }
    

    
//MARK: - Switch view buttons
    
//Quand l'utilisateur clique sur 1 des boutons : la grille change et le bouton est marqué !
    @IBAction func didTapLeftButton() {
        changeGridAndMarkButton(tappedButton.leftButton)
    }
    
    @IBAction func didTapCenterButton() {
        changeGridAndMarkButton(tappedButton.centerButton)
    }
    
    @IBAction func didTapRightButton() {
        changeGridAndMarkButton(tappedButton.rightButton)
    }
    
    
    var index = 0
    
//les boutons qui vont permettre de choisir une image dans picker image
    @IBAction func gridButtonTapped(_ sender: UIButton) {
        pickerImageDelegate()
        let buttonTag = sender.tag
        
        if buttonTag == 0{
            index = 1
        }else if buttonTag == 1 {
            index = 2
        }else if buttonTag == 2 {
            index = 3
        }else if buttonTag == 3 {
            index = 4
        } else if buttonTag == 4 {
            index = 5
        }else if buttonTag == 5 {
            index = 6
        }else if buttonTag == 6 {
            index = 7
        }else if buttonTag == 7 {
            index = 8
        }else if buttonTag == 8 {
            index = 9
        }else if buttonTag == 9 {
            index = 10
        }
    }
    
// Ouvrir la bibliothèque d'image de l'utilisateur !
   private func pickerImageDelegate(){
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
                centerGridBottomImage.image = image
            } else if index == 2 {
                centerGridLeftImage.image = image
            } else if index == 3 {
                centerGridRightImage.image = image
            } else if index == 4 {
                leftGridTopImage.image = image
            } else if index == 5 {
                leftGridLeftImage.image = image
            } else if index == 6 {
                leftGridRightImage.image = image
            } else if index == 7 {
                rightGridTopLeftImage.image = image
            } else if index == 8 {
                rightGridTopRightImage.image = image
            } else if index == 9 {
                rightGridBottomLeftImage.image = image
            } else if index == 10 {
                rightGridBottomRightImage.image = image
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    enum tappedButton {
        case leftButton, centerButton, rightButton
    }
    
    private func changeGridAndMarkButton(_ display: tappedButton){
        switch display {
        case .leftButton :
            leftButtonIsSelected.isHidden = false
            leftButtonGrid.isHidden = false
            centerButtonIsSelected.isHidden = true
            centerButtonGrid.isHidden = true
            rightButtonIsSelected.isHidden = true
            rightButtonGrid.isHidden = true
            
        case .centerButton :
            centerButtonIsSelected.isHidden = false
            centerButtonGrid.isHidden = false
            rightButtonIsSelected.isHidden = true
            leftButtonIsSelected.isHidden = true
            rightButtonGrid.isHidden = true
            leftButtonGrid.isHidden = true
            
        case .rightButton :
            rightButtonIsSelected.isHidden = false
            rightButtonGrid.isHidden = false
            centerButtonIsSelected.isHidden = true
            centerButtonGrid.isHidden = true
            leftButtonIsSelected.isHidden = true
            leftButtonGrid.isHidden = true
        }
    }
    
    
//MARK: - Swipe method
    
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
        UIView.animate(withDuration: 0.5, animations: {
            self.centerButtonGrid.transform = CGAffineTransform(translationX: x, y: y)
            self.leftButtonGrid.transform = CGAffineTransform(translationX: x, y: y)
            self.rightButtonGrid.transform = CGAffineTransform(translationX: x, y: y)
        }) { (completed) in
            if completed {
                self.imageShare()
            }
        }
    }
    
    
    private func imageShare(){
        //Genere l'image qui sera partagée
        UIGraphicsBeginImageContext(centerButtonGrid.frame.size)
        UIGraphicsBeginImageContext(leftButtonGrid.frame.size)
        UIGraphicsBeginImageContext(rightButtonGrid.frame.size)
        centerButtonGrid.layer.render(in: UIGraphicsGetCurrentContext()!)
        leftButtonGrid.layer.render(in: UIGraphicsGetCurrentContext()!)
        rightButtonGrid.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        //Permet d'initialiser le partage de la photo
        let activityController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        
        //Une fois le partage términé, (completionHandler), Je fait l'animation inverse pour remettre la grille à sa place.
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
        
//Permet d'ouvrire le gestionnaire de partage.
        present(activityController, animated: true, completion: nil)
    }
    
    
//Pour faire revenir la grille à son emplacement initiale.
    private func animateBackToCenter(){
        UIView.animate(withDuration: 0.5, animations: {
            self.centerButtonGrid.transform = .identity
            self.leftButtonGrid.transform = .identity
            self.rightButtonGrid.transform = .identity
        }, completion: nil)
    }
    
}


