
import UIKit

class FurnitureDetailViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var furniture: Furniture?
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var choosePhotoButton: UIButton!
    @IBOutlet var furnitureTitleLabel: UILabel!
    @IBOutlet var furnitureDescriptionLabel: UILabel!
    
    init?(coder: NSCoder, furniture: Furniture?) {
            self.furniture = furniture
            super.init(coder: coder)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            updateView()
        }
        
    func updateView() {
        guard let furniture = furniture else { return }
        
        // Check if we have image data and set the image
        if let imageData = furniture.imageData, let image = UIImage(data: imageData) {
            photoImageView.image = image
        } else {
            photoImageView.image = nil
        }
        
        // Set the other labels
        furnitureTitleLabel.text = furniture.name
        furnitureDescriptionLabel.text = furniture.description
    }

        
        @IBAction func choosePhotoButtonTapped(_ sender: UIView) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            
            let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                    imagePicker.sourceType = .camera
                    self.present(imagePicker, animated: true, completion: nil)
                })
                alertController.addAction(cameraAction)
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                    imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker, animated: true, completion: nil)
                })
                alertController.addAction(photoLibraryAction)
            }
            
            alertController.popoverPresentationController?.sourceView = sender
            
            present(alertController, animated: true, completion: nil)
        }
        
        // Delegate method for UIImagePickerController
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let selectedImage = info[.originalImage] as? UIImage else { return }
            
            if let imageData = selectedImage.pngData() {
                    furniture?.imageData = imageData
                }
            
            photoImageView.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
        
        // Delegate method to handle cancellation
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
        
        @IBAction func actionButtonTapped(_ sender: Any) {
            guard let image = photoImageView.image else { return }
            let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = sender as? UIView
            present(activityController, animated: true, completion: nil)
        }
    }
