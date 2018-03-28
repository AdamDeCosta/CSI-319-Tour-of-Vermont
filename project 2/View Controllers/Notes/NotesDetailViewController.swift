//
//  NotesDetailViewController.swift
//  project 2
//
//  Created by Adam DeCosta on 3/28/18.
//  Copyright © 2018 Adam DeCosta. All rights reserved.
//

import UIKit

class NotesDetailViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var note : Note? {
        didSet {
            noteText.text = note?.description
        }
    }
    
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var noteText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        noteImage.image = image
        
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func changeImage(_ sender: UIButton) {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
