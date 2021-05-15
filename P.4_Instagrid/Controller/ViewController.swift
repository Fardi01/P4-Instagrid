//
//  ViewController.swift
//  P.4_Instagrid
//
//  Created by fardi Clk on 17/03/2021.

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
// MARK: - Outlets
    
    @IBOutlet weak var swipUpLabel: UILabel!
    @IBOutlet weak var arrowUpImage: UIImageView!
    @IBOutlet weak var arrowLeftImage: UIImageView!
    @IBOutlet weak var gridStackView: UIStackView!
    
// Change Grid Buttons
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
// Top Stack View
    @IBOutlet weak var topLeftView: UIView!
    @IBOutlet weak var topLeftImage: UIImageView!
    @IBOutlet weak var topRightView: UIView!
    @IBOutlet weak var topRightImage: UIImageView!
    @IBOutlet weak var topLeftButton: UIButton!
    
// Bottom Stack View
    @IBOutlet weak var bottomleftView: UIView!
    @IBOutlet weak var bottomLeftImage: UIImageView!
    @IBOutlet weak var bottomRightView: UIView!
    @IBOutlet weak var bottomRightImage: UIImageView!
    @IBOutlet weak var bottomRightButton: UIButton!
    
    
    
// MARK: - View Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Swipe Up, Portraits mode
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        view.addGestureRecognizer(swipeUp)
        
        // Swipe left, Landscape mode
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        view.addGestureRecognizer(swipeLeft)
    }
    

    
// MARK: - Change Grid View

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
        bottomleftView.isHidden = false
    }
    
    private func changeGridCenterButton(){
        bottomleftView.isHidden = true
        topRightView.isHidden = false
    }
    
    private func changeGridRightButton(){
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
    
    
// MARK: - Image Picker
    
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
    
    
   func pickerImageDelegate(){
        let image = UIImagePickerController()
        image.sourceType = .photoLibrary
        image.delegate = self
        image.allowsEditing = false
        self.present(image, animated: true)
    }


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
    
    
// MARK: - Swipe Animation
    

    @objc func swipeAction(_ sender: UISwipeGestureRecognizer){
        if UIDevice.current.orientation.isLandscape {
            sender.direction = .left
                animateSwipe(translationX: -view.frame.width, y: 0)
        } else {
            sender.direction = .up

            animateSwipe(translationX: 0, y: -view.frame.height)
        }
    }
    

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
    
    
    
    private func imageShare(){
        UIGraphicsBeginImageContext(gridStackView.frame.size)
        gridStackView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let activityController = UIActivityViewController(activityItems: [image!], applicationActivities: nil)
        activityController.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                print("share done")
                self.animateBackToCenter()
                return
            } else {
                print("cancel")
                self.animateBackToCenter()
            }
        }
        present(activityController, animated: true, completion: nil)
    }
    
    
    private func animateBackToCenter(){
        UIView.animate(withDuration: 0.5, animations: {
            self.gridStackView.transform = .identity
            self.arrowUpImage.transform = .identity
            self.arrowLeftImage.transform = .identity
            self.swipUpLabel.transform = .identity
        }, completion: nil)
    }

}
