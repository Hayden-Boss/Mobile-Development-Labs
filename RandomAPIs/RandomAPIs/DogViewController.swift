import UIKit

class DogViewController: UIViewController {
    
    // IBOutlet for the ImageView from Storyboard
    @IBOutlet weak var dogImageView: UIImageView!    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fetch a random dog image
        fetchDogImage()
    }
    
    @IBAction func newImageButtonTapped(_ sender: Any) {
        fetchDogImage()
    }
    
    func fetchDogImage() {
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")!
        
        // Create a data task to fetch the image URL from the Dog CEO API
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Ensure we have data and no error
            guard let data = data, error == nil else { return }
            
            // Decode the JSON response
            do {
                let dogResponse = try JSONDecoder().decode(DogResponse.self, from: data)
                // Directly use the message property since it's a non-optional string
                let imageURLString = dogResponse.message
                if let imageURL = URL(string: imageURLString) {
                    // Load the image
                    self.loadImage(from: imageURL)
                }
            } catch {
                print("Error decoding response: \(error)")
            }
        }.resume()
    }
    
    func loadImage(from url: URL) {
        // Fetch the image data
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.dogImageView.image = image
                }
            }
        }.resume()
    }
}

// Struct to decode the JSON response
struct DogResponse: Decodable {
    let message: String
    let status: String
}
