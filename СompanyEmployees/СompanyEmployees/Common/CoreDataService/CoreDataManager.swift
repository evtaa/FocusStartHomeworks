//
//  CoreDataStack.swift
//  СompanyEmployees
//
//  Created by Alexandr Evtodiy on 15.12.2021.
//

import CoreData
import UIKit

protocol ICoreDataManager {
    func saveContext ()
}

protocol ICompanyStorage {
    var updateCompanies: (() -> Void)? { get set }
    
    func save (company: CompanyModel,
               completion: @escaping (Error?) -> Void)
    func remove(company: CompanyModel,
                completion: @escaping (Error?) -> Void)
    func loadCompanies(completion: @escaping (Result<[CompanyModel], Error>) -> Void)
}

protocol IEmployeeStorage {
    var updateEmployees: (() -> Void)? { get set }
    
    func save(employee: EmployeeModel,
               completion: @escaping (Error?) -> Void)
    func remove(employee: EmployeeModel,
                completion: @escaping (Error?) -> Void)
    func update (employee: EmployeeModel,
                 completion: @escaping (Error?) -> Void)
    func loadEmployees(for company: CompanyModel,
                       completion: @escaping (Result<[EmployeeModel], Error>) -> Void)
    
}

final class CoreDataManager {
    
    // MARK: - Properties
    var mainContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    // MARK: - Handlers
    var updateCompanies: (() -> Void)?
    var updateEmployees: (() -> Void)?
    
    // MARK: - Container
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "_ompanyEmployees")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
// MARK: - ICoreDataManager
extension CoreDataManager: ICoreDataManager {
    
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

// MARK: - ICompanyStorage
extension CoreDataManager: ICompanyStorage {
    func save(company: CompanyModel,
                      completion: @escaping (Error?) -> Void) {
        container.performBackgroundTask { [weak self] context in
            let object = Company(context: context)
            object.uid = company.uid
            object.name = company.name
            do {
                try context.save()
                self?.updateCompanies?()
                DispatchQueue.main.async { completion(nil) }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(error) }
            }
        }
    }
    
    func loadCompanies(completion: @escaping (Result<[CompanyModel], Error>) -> Void) {
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            let companiesModels = try mainContext.fetch(request).compactMap{
                CompanyModel(company: $0) }
            DispatchQueue.main.async{ completion(.success(companiesModels)) }
        }
        catch {
            print(error.localizedDescription)
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }
    
    func remove(company: CompanyModel,
                completion: @escaping (Error?) -> Void) {
        container.performBackgroundTask { [weak self] context in
            let fetchRequest: NSFetchRequest<Company> = Company.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "\(#keyPath(Company.uid)) = %@",
                                                 company.uid.uuidString)
            do {
                if let object = try context.fetch(fetchRequest).first {
                    context.delete(object)
                }
                try context.save()
                self?.updateCompanies?()
                DispatchQueue.main.async { completion(nil) }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(error) }
            }
        }
    }
}

// MARK: - IEmployeeStorage
extension CoreDataManager: IEmployeeStorage {
    func save(employee: EmployeeModel,
               completion: @escaping (Error?) -> Void) {
        container.performBackgroundTask { [weak self] context in
            let request: NSFetchRequest<Company> = Company.fetchRequest()
            request.predicate = NSPredicate(format: "\(#keyPath(Company.uid)) = '\(employee.companyUid)'")
            do {
                let company = try context.fetch(request).first
                let object = Employee(context: context)
                object.uid = employee.uid
                object.name = employee.name
                object.age = Int32(employee.age)
                object.experience = Int32(employee.experience ?? 0)
                object.company = company
                try context.save()
                self?.updateEmployees?()
                DispatchQueue.main.async { completion(nil) }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(error) }
            }
        }
    }
    
    
    func remove(employee: EmployeeModel,
                completion: @escaping (Error?) -> Void) {
        container.performBackgroundTask {[weak self] context in
            let request: NSFetchRequest<Employee> = Employee.fetchRequest()
            request.predicate = NSPredicate(format: "\(#keyPath(Employee.uid)) = %@",
                                            employee.uid.uuidString)
            do {
                if let object = try context.fetch(request).first {
                    context.delete(object)
                    try context.save()
                    self?.updateEmployees?()
                    DispatchQueue.main.async { completion(nil) }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(error) }
            }
        }
    }
    
    func update (employee: EmployeeModel,
                 completion: @escaping (Error?) -> Void) {
        container.performBackgroundTask {[weak self] context in
            let request: NSFetchRequest<Employee> = Employee.fetchRequest()
            request.predicate = NSPredicate(format: "\(#keyPath(Employee.uid)) = %@",
                                            employee.uid.uuidString)
            do {
                if let object = try? context.fetch(request).first {
                    object.name = employee.name
                    object.age = Int32(employee.age)
                    object.experience = Int32(employee.experience ?? 0)
                    try context.save()
                    self?.updateEmployees?()
                    DispatchQueue.main.async { completion(nil) }
                }
            } catch {
                print(error.localizedDescription)
                DispatchQueue.main.async { completion(error) }
            }
        }
    }
    
    func loadEmployees(for company: CompanyModel,
                       completion: @escaping (Result<[EmployeeModel], Error>) -> Void) {
        let request: NSFetchRequest<Employee> = Employee.fetchRequest()
        request.predicate = NSPredicate(format: "ANY company.uid = '\(company.uid)'")
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        do {
            let employeesModels = try mainContext.fetch(request).compactMap{
                EmployeeModel(employee: $0) }
            DispatchQueue.main.async{ completion(.success(employeesModels)) }
        }
        catch {
            print(error.localizedDescription)
            DispatchQueue.main.async { completion(.failure(error)) }
        }
    }

}




