import Foundation
import CoreData

// We are using Core Data Model code generation to generate code for the properties and relationships
// of the class that are defined in the Core Data Model.
// Specifically, we are using the 'codegen: category/extension' option.
//
// This means Xcode will automatically generate an class extension that has the properties
// specified in the Core Data Model. You just need to specify the class, since a 
// 'class extension' only extends an existing class.
//
// By specifying the class yourself, you can add additional functions and properties to the class.
// Anything added here will not be reflected in the Core Data Model.
//

@objc(Example)
class Example : NSManagedObject {

}
