/*:
## Exercise - Methods
 
 A `Book` struct has been created for you below. Add an instance method on `Book` called `description` that will print out facts about the book. Then create an instance of `Book` and call this method on that instance.
 */
struct Book {
    var title: String
    var author: String
    var pages: Int
    var price: Double
    
    func description(){
        print("This book is called \(title), by \(author). It has \(pages) pages, and costs $\(price)")
    }
}

let harryPotter1 = Book(title:"Harry Potter and the Sorcerers Stone", author: "J.K Rowling", pages: 320, price: 5.98)
harryPotter1.description()
//:  A `Post` struct has been created for you below, representing a generic social media post. Add a mutating method on `Post` called `like` that will increment `likes` by one. Then create an instance of `Post` and call `like()` on it. Print out the `likes` property before and after calling the method to see whether or not the value was incremented.
struct Post {
    var message: String
    var likes: Int
    var numberOfComments: Int

    mutating func like() {
        likes += 1
    }
}

var hawaii = Post(message: "Vacation in Hawaii!", likes: 0, numberOfComments: 0)
print(hawaii.likes)
hawaii.like()
print(hawaii.likes)

/*:
[Previous](@previous)  |  page 5 of 10  |  [Next: App Exercise - Workout Functions](@next)
 */
