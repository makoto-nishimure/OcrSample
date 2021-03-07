//
//  textEditController.swift
//  StackViewSample
//
//  Created by makoto on 2021/03/04.
//

import Foundation
import UIKit
import RealmSwift
import Photos
import SwiftyTesseract

enum ViewType: Int {
    case title = 1
    case note = 2
}

class textEditViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var titleView: UITextView!
    @IBOutlet weak var noteView: UITextView!
    @IBOutlet weak var imageSelectButton: UIBarButtonItem!

    var memo: Memos!
    let memosDao: MemosDao = MemosDao.sharedInstance
    
    var button: UIBarButtonItem!

    override func viewDidLoad() {
        titleView.delegate = self
        noteView.delegate  = self
        
        button = UIBarButtonItem(title: "imageSelect", style: .done, target: self, action: #selector(imageSelectButtonTapped(_:)))
        self.navigationItem.rightBarButtonItem = button
    
        titleView.text = memo.getTitle()
        titleView.font = UIFont.boldSystemFont(ofSize: 24)
        noteView.text  = memo.getContents()
        noteView.font  = UIFont.boldSystemFont(ofSize: 18)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var title: String
        var note: String
        switch textView.tag {
        case ViewType.title.rawValue:
            title = textView.text
            note  = memo.getContents()
        case ViewType.note.rawValue:
            note  = textView.text
            title = memo.getTitle()
        default:
            print("Unexpected err: textViewDidChange")
            return
        }
        if (!memosDao.update(memo: memo, title: title, contents: note)) {
            print("realm write failed.")
            return
        }
    }
    
    @available(iOS 14, *)
    func checkPhotoLibrary(handler: @escaping (PHAccessLevel) -> Void) {
        let readWrite = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch (readWrite) {
        case .authorized:
            handler(.readWrite)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { (_: PHAuthorizationStatus) in
                self.checkPhotoLibrary(handler: handler)
            }
        default:
            print("TMP")
        }
    }
    
    @objc func imageSelectButtonTapped(_ sender: UIBarButtonItem) {
        print("imageSelectButtonTapped")

        if #available(iOS 14, *) {
            checkPhotoLibrary { [weak self] (status) in
                switch status {
                case .readWrite:
                    print("case readWrite")
                    let c = UIImagePickerController()
                    c.delegate = self
                    self?.present(c, animated: true)
                default:
                    break
                }
            }
        } else {
            print("Unsapported iOS")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("imagePickerControllerDidCancel.")
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: nil)
        print("imagePickerController.")

        let swiftyTesseract = Tesseract(language: .japanese)
        if let pickedImage = info[.originalImage] as? UIImage {

            let recorgnizedString = swiftyTesseract.performOCR(on: pickedImage)
            switch recorgnizedString {
            case .success(let text):
                print("\(text)")
                let noteText = memo.getContents() + "\n" + text
                noteView.text = noteText
                if (!memosDao.update(memo: memo, title: memo.getTitle(), contents: noteText)) {
                    print("realm write failed.")
                }
            case .failure(let err):
                print("error")
                print(err)
            }
        } else {
            print("pickedImage failed.")
        }
    }
    
    func ocr(img: UIImage) {
        
    }
}
