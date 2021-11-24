//
//  MyToDoApp.swift
//  MyToDo
//
//  Created by Wejdan Alkhaldi on 09/04/1443 AH.
//

import SwiftUI

@main
struct MyToDoApp: App {
    let persistentContainer = CoreDataManager.shared.persistentContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext,persistentContainer.viewContext)
        }
    }
}

