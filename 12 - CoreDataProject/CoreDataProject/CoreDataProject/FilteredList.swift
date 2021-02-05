//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Philipp on 05.02.2021.
//

import CoreData
import SwiftUI


struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> {fetchRequest.wrappedValue}
    let content: (T) -> Content
    var descriptors: [NSSortDescriptor]
    var predicate: String
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    init(filterKey: String, filterValue: String, descriptors: [NSSortDescriptor], predicate: String, @ViewBuilder content: @escaping (T) -> Content) {
        self.descriptors = descriptors
        self.predicate = predicate
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: descriptors, predicate: NSPredicate(format: predicate, filterKey, filterValue))
        self.content = content
    }
}


