//
//  ImagePickerViewController.swift
//  Frontend
//
//  Created by Edward on 12/13/20.
//

import UIKit
import ImagePicker

class ImagePickerViewController: UIViewController, ImagePickerDelegate {

  lazy var button: UIButton = self.makeButton()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = UIColor.white
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false

    view.addConstraint(
      NSLayoutConstraint(item: button, attribute: .centerX,
                         relatedBy: .equal, toItem: view,
                         attribute: .centerX, multiplier: 1,
                         constant: 0))

    view.addConstraint(
      NSLayoutConstraint(item: button, attribute: .centerY,
                         relatedBy: .equal, toItem: view,
                         attribute: .centerY, multiplier: 1,
                         constant: 0))
  }

  func makeButton() -> UIButton {
    let button = UIButton()
    button.setTitle("Show ImagePicker", for: .normal)
    button.setTitleColor(UIColor.black, for: .normal)
    button.addTarget(self, action: #selector(buttonTouched(button:)), for: .touchUpInside)

    return button
  }

  @objc func buttonTouched(button: UIButton) {
    let config = Configuration()
    config.doneButtonTitle = "Finish"
    config.noImagesTitle = "Sorry! There are no images here!"
    config.recordLocation = false
    config.allowVideoSelection = true

    let imagePicker = ImagePickerController(configuration: config)
    imagePicker.delegate = self

    present(imagePicker, animated: true, completion: nil)
  }

  // MARK: - ImagePickerDelegate

  func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
    imagePicker.dismiss(animated: true, completion: nil)
  }

  func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
    /*
    guard images.count > 0 else { return }

    let lightboxImages = images.map {
      return LightboxImage(image: $0)
    }

    let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
    imagePicker.present(lightbox, animated: true, completion: nil)
     */
  }

  func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
    imagePicker.dismiss(animated: true, completion: nil)
  }
}



/*import UIKit
import ImagePicker

class ImagePickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationController {

    let imagePicker = UIImagePickerController()
    var image: UIImage
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        
    }
    

    override func viewDidAppear(_ animated: true, completion nil) {
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        <#code#>
    }

}*/
