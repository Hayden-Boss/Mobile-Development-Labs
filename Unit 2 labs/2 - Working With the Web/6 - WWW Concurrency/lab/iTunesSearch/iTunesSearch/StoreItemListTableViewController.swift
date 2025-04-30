
import UIKit

@MainActor
class StoreItemListTableViewController: UITableViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filterSegmentedControl: UISegmentedControl!
    
    let storeItemController = StoreItemController()
    
    var items = [StoreItem]()
    var imageLoadTasks: [IndexPath: Task<Void, Never>] = [:]
    
    let queryOptions = ["movie", "music", "software", "ebook"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchMatchingItems() {
        
        self.items = []
        self.tableView.reloadData()
        
        let searchTerm = searchBar.text ?? ""
        let mediaType = queryOptions[filterSegmentedControl.selectedSegmentIndex]
        
        if !searchTerm.isEmpty {
            let query: [String: String] = [
                "term": searchTerm,
                "media": mediaType,
                "limit": "20",
                "lang": "en-us"
            ]
            // set up query dictionary
            Task {
                do {
                    let fetchedItems = try await storeItemController.fetchItems(matching: query)
                    self.items = fetchedItems
                    self.tableView.reloadData()
                } catch {
                    print("Error fetching items: \(error)")
                }
            }
        }
    }
    
    func configure(cell: ItemCell, forItemAt indexPath: IndexPath) {
        let item = items[indexPath.row]

        // Log the item to verify that the artworkURL exists
        print("Item: \(item)")  // Log the whole item to inspect its properties
        print("Artwork URL: \(String(describing: item.artworkURL))")  // Log the URL

        // Set the name and artist
        cell.name = item.trackName
        cell.artist = item.artistName  // Adjust to correct property
        cell.artworkImage = nil

        if let artworkURL = item.artworkURL {
            print("Valid Artwork URL: \(artworkURL)")  // Log the valid URL here

            imageLoadTasks[indexPath] = Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: artworkURL)
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.artworkImage = image
                        }
                    }
                } catch {
                    print("Error loading image: \(error)")
                }
            }
        } else {
            print("No artwork URL available")
        }
    }


    @IBAction func filterOptionUpdated(_ sender: UISegmentedControl) {
        
        fetchMatchingItems()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath) as! ItemCell
        configure(cell: cell, forItemAt: indexPath)

        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // cancel the image fetching task if we no longer need it
        imageLoadTasks[indexPath]?.cancel()
    }
}

extension StoreItemListTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}

extension String {
    func isValidURL() -> Bool {
        if let url = URL(string: self), UIApplication.shared.canOpenURL(url) {
            return true
        }
        return false
    }
}
