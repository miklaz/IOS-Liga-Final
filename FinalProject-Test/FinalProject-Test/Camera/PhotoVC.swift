//
//  PhotoVC.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 09.04.2022.
//

import UIKit
import AVFoundation

final class PhotoVC: UIViewController  {
    
    private var photoView = PhotoView()
    private var photo: UIImage?
    
    init(_ touchCardView: PhotoView) {
        self.photoView = touchCardView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = photoView
        view.isOpaque = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoView.takePhotoButton.addTarget(self, action: #selector(takePicture), for: .touchUpInside)
        photoView.savePhotoButton.addTarget(self, action: #selector(savePicture), for: .touchUpInside)
        photoView.savePhotoButton.alpha = 0
        photoView.dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.subviews.first?.frame = self.view.frame
    }
    
    private func photoSelect(type: UIImagePickerController.SourceType) {
        // Проверка, поддерживает ли устройство камеру
        guard UIImagePickerController.isSourceTypeAvailable(type) else { return showAlert("Your device does not have a camera!")}
        // Создаём контроллер и настраиваем его
        let imagePickerController = UIImagePickerController()
        // Источник изображений
        imagePickerController.sourceType = type
        // Изображение можно редактировать
        imagePickerController.allowsEditing = false
        imagePickerController.delegate = self
        // Показываем контроллер
        present(imagePickerController, animated: true)
    }
    
    private func showAlert(_ title: String) {   //  Выводит сообщения в виде alert
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // Обработка результата сохранения фото
    @objc private func image(_ image: UIImage,
                             didFinishSavingWithError error: Error?,
                             contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("ERROR: \(error)")
            showAlert("ERROR: \(error)")
        }
    }
    
    @objc private func takePicture() {
        self.photoSelect(type: .camera)
    }
    
    @objc private func savePicture() {
        UIImageWriteToSavedPhotosAlbum(photo!,
                                       self,
                                       #selector(image(_:didFinishSavingWithError:contextInfo:)),
                                       nil)
        showAlert("Photo saved!")
    }
    
    @objc private func dismissAction() {
        self.dismiss(animated: true, completion: nil)
        print("dismis")
    }
}

extension PhotoVC: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // MARK: - Methods
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Если нажали на кнопку Отмена, то UIImagePickerController надо закрыть
        picker.dismiss(animated: true)
    }
    
    func imagePickerController( _ picker: UIImagePickerController,
                                didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        // Мы получили медиа от контроллера
        // Изображение надо достать из словаря info
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.photoView.photoImage.image = image
            photo = self.photoView.photoImage.image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoView.photoImage.image = image
            photo = self.photoView.photoImage.image
        }
        
        self.photoView.savePhotoButton.alpha = 1
        self.photoView.photoImage.backgroundColor = UIColor.init(named: ".default")
        
        // Закрываем UIImagePickerController
        picker.dismiss(animated: true)
    }
}
