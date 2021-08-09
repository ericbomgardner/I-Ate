import CoreData

extension NSManagedObjectContext {
    func saveChanges() {
        if hasChanges {
            try! save()
        }
    }
}
