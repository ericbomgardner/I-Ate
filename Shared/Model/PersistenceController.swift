import CoreData

struct PersistenceController {
    /// TODO: Remove the `inMemory: true` once the app is ready to test
    static let shared = PersistenceController(inMemory: true)

    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    private let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "I_Ate")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("\(error.localizedDescription), \(error.userInfo)")
            }
        })
    }

    func save() {
        if viewContext.hasChanges {
            try! viewContext.save()
        }
    }
}
