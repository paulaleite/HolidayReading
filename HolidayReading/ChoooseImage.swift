//
//  ChoooseImage.swift
//  HolidayReading
//
//  Created by Paula Leite on 19/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

import UIKit

class ChooseImage: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Instância o controle do sistema de imagens
    var select = UIImagePickerController();
    
    //Cria um alerta
    var alert = UIAlertController(title: "Escolha uma opção", message: nil, preferredStyle: .actionSheet)
    
    //Cria um UIViewController
    var viewController: UIViewController?
    
    //Cria um callback @escaping
    var callback : ((UIImage) -> ())?;
    
    
    //Função principal
    func imageSelector(_ viewController: UIViewController, _ retorno: @escaping ((UIImage) -> ())) {
        
        /* Declara o callback dessa funcao como sendo a variavel externa pickImageCallback,
         isso serve para o retorno dessa funcao estar em outro metodo,
         no caso, apos a escolha da imagem */
        callback = retorno;
        
        //Declara o viewController como o passado como parâmetro, isso serve para as transições de tela.
        self.viewController = viewController;
        
        //Cria uma ação que chama o método "openCamera"
        let camera = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        //Cria uma acao que chama o método "abrirGaleria"
        let galery = UIAlertAction(title: "Galery", style: .default){
            UIAlertAction in
            self.openGalery()
        }
        
        //Cria uma outra ação
        let cancel = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }
        
        //Declara que o novo delegate do piker são os métodos abaixo
        select.delegate = self
        
        
        // Adiciona ações ao alerta
        alert.addAction(camera)
        alert.addAction(galery)
        alert.addAction(cancel)
        
        //Exibe o alerta na tela
        alert.popoverPresentationController?.sourceView = self.viewController!.view
        viewController.present(alert, animated: true, completion: nil)
    }
    
    
    //Abre a câmera
    func openCamera(){
        //Desfaz o alerta de seleção gerado anteriormente
        alert.dismiss(animated: true, completion: nil)
        
        //Aqui verificamos se temos a permissão para acessar a câmera
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            //Define o tipo que queremos selecionar como a câmera
            select.sourceType = .camera
            //Vai para a tela da câmera
            self.viewController?.present(select, animated: true, completion: nil)
        } else {
            //Gera alerta se a pessoa não possue câmera no dispositivo ou caso você rode em um simulador.
            let alert = UIAlertController(title: "Alert", message: "You don't have a camera", preferredStyle: .actionSheet)
            //Cria uma outra ação
            let cancel = UIAlertAction(title: "Cancel", style: .cancel){
                UIAlertAction in
            }
            //Mostra alerta
            alert.addAction(cancel)
            self.viewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    
    //Abre a Galeria
    func openGalery(){
        //Desfaz o alerta gerado
        alert.dismiss(animated: true, completion: nil)
        
        //Por default o tipo de abertura do selecionador em cena é a Galeria
        select.sourceType = .photoLibrary
        
        //Vai para a tela da Galeria
        self.viewController?.present(select, animated: true, completion: nil)
    }
    
    
    //Metodo chamado quando a pessoa cancela a escolha
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Desfaz a tela da Galeria que foi gerada
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //Metodo chamado quando a pessoa escolhe uma imagem
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //Desfaz a tela da Galeria que foi gerada
        picker.dismiss(animated: true, completion: nil)
        
        //Verifica o arquivo averto é realmente uma imagem
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("An image was expected: \(info)")
        }
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            // handle failed conversion
            print("jpg error")
            return
        }
        
        //Book.image = imageData as NSData
        
        //Retorna o callback da função principal
        callback?(image)
    }
}

