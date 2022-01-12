//
//  AddPhotoViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/5.
//

import UIKit


class AddPhotoViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var menuIndex = 0
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takePhotoBtn: UIButton!
    @IBOutlet weak var albumBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    private var backBotton = UIBarButtonItem()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackgroundColor()
        self.navigationController?.navigationBar.barTintColor = .navigation()
        navigationItem.backBarButtonItem = backBotton
        backBotton = UIBarButtonItem(title: "＜返回", style: .done, target: self, action: #selector(backButtonTapped(_:)))
        navigationItem.setLeftBarButton(backBotton, animated: false)
//        self.navigationController?.navigationBar.delegate = self
    }

    @objc func backButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    @IBAction func tapTakePhoto(_ sender: Any) {
        let sourceType:UIImagePickerController.SourceType =
            UIImagePickerController.SourceType.camera
        // カメラが利用可能かチェック
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera){
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
            
        }
    }
    
    //　撮影が完了時した時に呼ばれる
    func imagePickerController(_ imagePicker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        //閉じる処理
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    // 撮影がキャンセルされた時に呼ばれる
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapAlbumBtn(_ sender: Any) {
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            // インスタンスの作成
            let cameraPicker = UIImagePickerController()
            cameraPicker.sourceType = sourceType
            cameraPicker.delegate = self
            self.present(cameraPicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapSaveBtn(_ sender: Any) {
        saveImage()
    }
    
    private func saveImage() {
        guard let image = imageView.image else { return }
        let imageData = image.jpegData(compressionQuality: 0.6)
        
        let nav = self.navigationController
        //MARK: - 一つ前のViewControllerを取得する
        let targetVC = nav?.viewControllers[(nav?.viewControllers.count)! - 2] as! AddMenuDetailViewController
        targetVC.imageData = imageData!

        self.navigationController?.popViewController(animated: true)
    }
    
}
