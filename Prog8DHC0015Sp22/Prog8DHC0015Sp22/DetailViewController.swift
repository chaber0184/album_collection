//
//  DetailViewController.swift
//  Prog8DHC0015Sp22
//
//  Created by Dimitri Chaber on 3/24/22.
//

import UIKit
import MobileCoreServices

class DetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return masterViewController.items[itemIndex].tracks.count
    }
    
    @IBAction func pickPressed(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        self.present(imagePicker,animated: true,completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        picker.dismiss(animated:true){
            self.imageView.image = image
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let object = masterViewController.items[itemIndex].tracks[indexPath.row]
        cell.textLabel!.text = object.title
        cell.detailTextLabel?.text = object.length
        return cell
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let objectToBeMoved = masterViewController.items[sourceIndexPath.row]
        masterViewController.items.remove(at: sourceIndexPath.row)
        masterViewController.items.insert(objectToBeMoved, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            masterViewController.items.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    var masterViewController: MasterViewController!
    var itemIndex = 0

    @IBAction func cancelPressed(_ sender: UIButton) {
        if masterViewController.newFlag == true{
            masterViewController.items.remove(at: 0)
            masterViewController.tableView.reloadData()
            masterViewController.newFlag = false
        }
    }
    @IBAction func savePressed(_ sender: UIButton) {
        masterViewController.items[itemIndex].title = albumText.text!
        masterViewController.items[itemIndex].artist = artistText.text!
        masterViewController.items[itemIndex].year = yearText.text!
        masterViewController.items[itemIndex].label = labelText.text!
        masterViewController.items[itemIndex].review = reviewText.text!
        masterViewController.items[itemIndex].cover = imageView.image?.jpegData(compressionQuality: 1.0)
        masterViewController.tableView.reloadData()
    }
    @IBOutlet weak var reviewText: UITextView!
    @IBOutlet weak var labelText: UITextField!
    @IBOutlet weak var albumText: UITextField!
    @IBOutlet weak var artistText: UITextField!
    @IBOutlet weak var yearText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(itemIndex)
        
        albumText.text = masterViewController.items[itemIndex].title
        artistText.text = masterViewController.items[itemIndex].artist
        yearText.text = masterViewController.items[itemIndex].year
        labelText.text = masterViewController.items[itemIndex].label
        reviewText.text = masterViewController.items[itemIndex].review
        if let img = masterViewController.items[itemIndex].cover{
        imageView.image = UIImage(data: img)
        }
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
