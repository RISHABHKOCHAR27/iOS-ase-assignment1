import Foundation

enum ItemType: String{
    case raw, manufactured, imported
}

struct Item{
    var name: String
    var price: Double
    var quantity: Int
    var type: ItemType
    
    func taxes() -> Double {
        switch type{
        case .raw:
            return 0.125 * price
        case .manufactured:
            return 0.125 * price + 0.02 * (price + 0.125 * price)
        case .imported:
            let importDuty = 0.1 * price
            let surcharge: Double
            let finalCost = price + importDuty
            if finalCost <= 100 {
                surcharge = 5
            }
            else if finalCost <= 200 {
                surcharge = 10
            }
            else {
                surcharge = 0.05 * finalCost
            }
            return importDuty + surcharge
        }
    }
    
    func finalPrice() -> Double{
        let tax = taxes()
        var price = Double(quantity) * price
        return price + tax
    }
    
    func display() {
        print("Item Name: \(name)")
        print("Item price: \(price)")
        print("sales tax liability per item: \(taxes())")
        print("final prize (sales tax + item prize): \(finalPrice())")
    }
    
}

func addItems() {
    var items = [Item]()
    
    print("Enter the number of items: ")
    if let itemnumber = readLine(), let count = Int(itemnumber){
        for _ in 1...count {
            print("Enter the name of the item")
            guard let itemName = readLine(), !itemName.isEmpty else{
                print("Field can not be empty, give proper input.")
                return
            }
            print("Enter the price of the item")
            guard let pricestring = readLine(), let itemPrice = Double(pricestring), itemPrice > 0 else{
                print("Field can not be empty, give proper input.")
                return
            }
            print("Enter the quantity of the item")
            guard let quan = readLine(), let itemQuantity = Int(quan), itemQuantity > 0 else{
                print("Field can not be empty, give proper input.")
                return
            }
            print("Enter the type of the item (raw/manufactured/imported")
            guard let typestring = readLine(), let itemType = ItemType(rawValue: typestring) else{
                print("Give proper input.Item type is wrong")
                return
            }
            let newItem = Item(name: itemName, price: itemPrice, quantity: itemQuantity, type: itemType)
            items.append(newItem)
        }
        for item in items{
            item.display()
        }
    } else{
        print("Invalid input")
    }
}
addItems()
