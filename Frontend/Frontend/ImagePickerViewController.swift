//
//  ImagePickerViewController.swift
//  Frontend
//
//  Created by Edward on 12/13/20.
//

import UIKit
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

}
