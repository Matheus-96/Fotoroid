//
//  FinalViewController.swift
//  Fotoroid
//
//  Created by Matheus Rodrigues Araujo on 06/01/20.
//  Copyright © 2020 Curso IOS. All rights reserved.
//

import UIKit
import Photos

class FinalViewController: UIViewController {

    @IBOutlet weak var ivPhoto: UIImageView!
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ivPhoto.image = image
        ivPhoto.layer.borderWidth = 10
        ivPhoto.layer.borderColor = UIColor.white.cgColor
    }
    
    func saveToAlbum() {
        PHPhotoLibrary.shared().performChanges({
            
            let creationRequest = PHAssetChangeRequest.creationRequestForAsset(from: self.image)
            let addAssetRequest = PHAssetCollectionChangeRequest()
            addAssetRequest.addAssets([creationRequest.placeholderForCreatedAsset] as NSArray)
            
        }) { (sucess, error) in
            if error == nil {
                print("salvou")
                let alert = UIAlertController(title: "Imagem Salva", message: "Sua imagem foi salva no album de fotos", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    @IBAction func save(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.saveToAlbum()
            default:
                let alert = UIAlertController(title: "ERRO", message: "Você precisa autorizar o acesso ao álbum para poder salvar sua foto", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func restart(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
