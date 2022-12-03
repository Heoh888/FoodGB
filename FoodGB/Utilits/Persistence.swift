//
//  Persistence.swift
//  FoodGB
//
//  Created by Алексей Ходаков on 19.10.2022.
//

import CoreData

struct PersistenceController {
    
    // MARK: - Properties
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
        }
        do {
            try viewContext.save()
        } catch {
            // TO:DO - Заменить эту реализацию кодом для соответствующей обработки ошибки.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    // MARK: - Initialisation
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FoodGB")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // TO:DO - Заменить эту реализацию кодом для соответствующей обработки ошибки.
                /*
                 Типичные причины ошибки здесь включают:
                    * Родительский каталог не существует, не может быть создан или запрещает запись.
                    * Постоянное хранилище недоступно из-за разрешений или защиты данных, когда устройство заблокировано.
                    * На устройстве не хватает места.
                    * Не удалось перенести хранилище на текущую версию модели.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
