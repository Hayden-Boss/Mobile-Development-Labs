import UIKit

class FoodTableViewController: UITableViewController {

    // Computed property that returns an array of Meal objects
    var meals: [Meal] {
        let breakfast = Meal(
            name: "Breakfast",
            food: [
                Food(name: "Pancakes", description: "Fluffy pancakes with syrup"),
                Food(name: "Scrambled Eggs", description: "Eggs cooked to perfection"),
                Food(name: "Orange Juice", description: "Freshly squeezed orange juice")
            ]
        )

        let lunch = Meal(
            name: "Lunch",
            food: [
                Food(name: "Grilled Cheese", description: "Toasted sandwich with melted cheese"),
                Food(name: "Tomato Soup", description: "Warm tomato soup with basil"),
                Food(name: "Iced Tea", description: "Refreshing iced tea with lemon")
            ]
        )

        let dinner = Meal(
            name: "Dinner",
            food: [
                Food(name: "Spaghetti", description: "Spaghetti with marinara sauce"),
                Food(name: "Garlic Bread", description: "Toasted bread with garlic butter"),
                Food(name: "Caesar Salad", description: "Crisp romaine with Caesar dressing")
            ]
        )

        return [breakfast, lunch, dinner]
    }

    // MARK: - UITableViewDataSource

    // 1️⃣ Number of sections = Number of meals
    override func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }

    // 2️⃣ Number of rows in each section = Number of food items in that meal
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals[section].food.count
    }

    // 3️⃣ Configuring the cell for each row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)
        
        // Get the correct meal section
        let meal = meals[indexPath.section]
        
        // Get the correct food item in that meal
        let foodItem = meal.food[indexPath.row]

        // Configure the cell with the food item
        var content = cell.defaultContentConfiguration()
        content.text = foodItem.name
        content.secondaryText = foodItem.description
        cell.contentConfiguration = content

        return cell
    }

    // 4️⃣ Set the section headers to meal names
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return meals[section].name
    }
}
