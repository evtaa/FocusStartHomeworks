//
//  CoreDataService.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 23.12.2021.
//

import CoreData

protocol ICoreDataService {
    func saveContext ()
}

protocol IUserStorage {
    func save (user: UserModel,
               completion: @escaping (Error?) -> Void)
    func loadUser(user: UserModel, completion: @escaping (Result<UserModel?, Error>) -> Void)
}

final class CoreDataService {
    
    // MARK: - Properties
    var mainContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    // MARK: - Container
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CurrencyConverter")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
// MARK: - ICoreDataService
extension CoreDataService: ICoreDataService {
    
    func saveContext () {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK: - ICoreDataService
extension CoreDataService: IUserStorage {
    func save(user: UserModel,
              completion: @escaping (Error?) -> Void) {
        container.performBackgroundTask { context in
            let object = User(context: context)
            object.uid = user.uid
            object.username = user.username
            object.password = user.password
            do {
                try context.save()
                DispatchQueue.main.async { completion(nil) }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(error) }
            }
        }
    }
    
    func loadUser(user: UserModel, completion: @escaping (Result<UserModel?, Error>) -> Void) {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "\(#keyPath(User.username)) = %@ AND \(#keyPath(User.password)) = %@",
                                        user.username,
                                        user.password)
        do {
            let usersModel = try mainContext.fetch(request).compactMap{
                UserModel(user: $0) }.first
            DispatchQueue.main.async{ completion(.success(usersModel)) }
        }
        catch {
            print(error.localizedDescription)
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
    
}
