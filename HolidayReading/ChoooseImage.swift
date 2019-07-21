//
//  ChoooseImage.swift
//  HolidayReading
//
//  Created by Paula Leite on 19/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class ChooseImage: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var book: Book?
    
    var select = UIImagePickerController();
    
    var alert = UIAlertController(title: "Escolha uma opção", message: nil, preferredStyle: .actionSheet)
    
    var tableViewController: UITableViewController?
    
    // Creates  callback @escaping
    var callback : ((UIImage) -> ())?;
    
    
    // Main func
    func imageSelector(_ tableViewController: UITableViewController, _ retorno: @escaping ((UIImage) -> ())) {
        
        callback = retorno;
        
        self.tableViewController = tableViewController;
        
        let camera = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galery = UIAlertAction(title: "Galeria", style: .default){
            UIAlertAction in
            self.openGalery()
        }
        
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel){
            UIAlertAction in
        }
        
        select.delegate = self
        
        alert.addAction(camera)
        alert.addAction(galery)
        alert.addAction(cancel)
        
        alert.popoverPresentationController?.sourceView = self.tableViewController!.view
        tableViewController.present(alert, animated: true, completion: nil)
    }
    
    
    // Opens Camera
    func openCamera(){
       
        alert.dismiss(animated: true, completion: nil)
        
        // Checks permission for opening the Camera
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            
            select.sourceType = .camera
            // Camera
            self.tableViewController?.present(select, animated: true, completion: nil)
        } else {
        
            let alert = UIAlertController(title: "Alert", message: "You don't have a camera", preferredStyle: .actionSheet)
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel){
                UIAlertAction in
            }
           
            alert.addAction(cancel)
            self.tableViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    
    // Opens the Galary
    func openGalery(){
        alert.dismiss(animated: true, completion: nil)
        
        select.sourceType = .photoLibrary
        
        // Galary
        self.tableViewController?.present(select, animated: true, completion: nil)
    }
    
    
    // Cancel choise
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    // Function called when the user chooses an image
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        // Checks if the opened file is an image
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("An image was expected: \(info)")
        }
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            // handle failed conversion
            print("jpg error")
            return
        }
        book?.image = imageData as NSData
        
        //Retorna o callback da função principal
        callback?(image)
    }
}

