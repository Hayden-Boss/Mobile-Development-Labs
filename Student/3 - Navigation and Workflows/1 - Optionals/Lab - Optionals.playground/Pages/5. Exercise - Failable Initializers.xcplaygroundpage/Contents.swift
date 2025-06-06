/*:
## Exercise - Failable Initializers

 Create a `Computer` struct with two properties, `ram` and `yearManufactured`, where both parameters are of type `Int`. Create a failable initializer that will only create an instance of `Computer` if `ram` is greater than 0, and if `yearManufactured` is greater than 1970, and less than 2020.
 */
struct Computer {
    var ram: Int
    var yearManufactured: Int
    
    init?(ram: Int, yearManufactured: Int) {
        if ram <= 0 || yearManufactured <= 1970 || yearManufactured >= 2020 {
            return nil
        }
        self.ram = ram
        self.yearManufactured = yearManufactured
    }
}

//:  Create two instances of `Computer?` using the failable initializer. One instance should use values that will have a value within the optional, and the other should result in `nil`. Use if-let syntax to unwrap each of the `Computer?` objects and print the `ram` and `yearManufactured` if the optional contains a value.
if let computer1 = Computer(ram: 16, yearManufactured: 2015) {
    print("Computer 1: \(computer1.ram)GB RAM, manufactured in \(computer1.yearManufactured).")
} else {
    print("Computer 1 could not be initialized.")
}
if let computer2 = Computer(ram: 0, yearManufactured: 2025) {
    print("Computer 2: \(computer2.ram)GB RAM, manufactured in \(computer2.yearManufactured).")
} else {
    print("Computer 2 could not be initialized.")
}


/*:
[Previous](@previous)  |  page 5 of 6  |  [Next: App Exercise - Workout or Nil](@next)
 */
