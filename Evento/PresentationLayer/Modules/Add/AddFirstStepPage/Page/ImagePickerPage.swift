//
//  ImagePickerPage.swift
//  Evento
//
//  Created by Ramir Amrayev on 07.05.2023.
//

import UIKit

final class ImagePickerPage: UIImagePickerController {
    var didPickImage: Callback<UIImage?>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        delegate = self
    }
}

extension ImagePickerPage: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            didPickImage?(image)
        } else {
            didPickImage?(nil)
        }
        
        dismiss(animated: true)
    }
}

extension ImagePickerPage: UINavigationControllerDelegate {}
