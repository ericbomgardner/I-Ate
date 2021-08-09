import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    private let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "I_Ate")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("\(error.localizedDescription), \(error.userInfo)")
            }
        })
    }
}
