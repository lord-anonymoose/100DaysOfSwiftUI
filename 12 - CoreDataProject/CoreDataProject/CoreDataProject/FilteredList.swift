//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Philipp on 05.02.2021.
//

import SwiftUI

struct FilteredList: View {
    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer> {fetchRequest.wrappedValue}
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
    
    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %%", filter))
    }
}

/*
struct FilteredList_Previews: PreviewProvider {
    static var previews: some View {
        FilteredList()
    }
}
*/
