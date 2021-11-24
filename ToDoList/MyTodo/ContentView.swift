//
//  ContentView.swift
//  TodoListApp
//
//  Created by Wejdan Alkhaldi on 01/04/1443 AH.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var ViewContext
    @FetchRequest(entity: Task.entity(),sortDescriptors: [NSSortDescriptor(key: "deadline", ascending: false)], animation:.default)
    private var myTask: FetchedResults<Task>
    @State var title: String = ""
    @State var content: String = ""
    @State var isCheck : Bool = false
    @State var deadline =  Date()
    @State var searchText : String = ""
    var body: some View {
        NavigationView {
            ZStack {
                Color.purple
                    .opacity(0.3)
                .ignoresSafeArea()
            
            VStack {
                SearchBar(text: $searchText)
                    .padding(.trailing)
                TextField("Enter title", text:$title)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .padding(.top)
                TextField("Enter content", text: $content)
                    .padding(.horizontal)
                    .padding(.vertical)
                Toggle(isOn: $isCheck) {}.labelsHidden()
                    .padding(.top)
                Button {
                    do {
                        let task = Task(context: ViewContext)
                        task.title = title
                        task.content = content
                        task.deadline = deadline
                        task.isCheck = isCheck
                        try ViewContext.save()
                        
                    } catch {}
                    
                }label: {
                    Text("Add Task")
                }
                
                List{
                    
                    if myTask.isEmpty {
                        Text("ToDos are Empty 🗑")
                    } else {
                        ForEach(myTask) { task in
                            NavigationLink(destination: {
                                UpdateTask(task: task)
                            }, label: {
                                HStack {
                                    VStack{
                                        Text(task.title ?? "")
                                            .font(.title2)
                                        Text(task.content ?? "")
                                            .font(.caption)
                                    }
                                    
                                    Spacer()
                                    Button{
                                        task.isCheck = !task.isCheck
                                        do {
                                            try ViewContext.save()
                                        } catch {
                                            
                                        }
                                    }label: {
                                        Image(systemName: task.isCheck ? "checkmark.circle.fill" : "checkmark.circle")
                                    }.tint(.green)
                                }.buttonStyle(.borderless)
                                    .padding(.trailing)
                            }
                            )
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button {
                                        if let deletedTask = myTask.firstIndex(of: task){
                                            ViewContext.delete(myTask[deletedTask])
                                            do {
                                                try ViewContext.save()
                                            } catch {}
                                        }
                                    }label: {
                                        Image(systemName: "trash")
                                    }.tint(.red)
                                }
                            
                        }
                    }
                    
                }
            }
            
            .navigationTitle("To-Do-List 🗓 📌")
            .padding(.top)

           
            
            
            .navigationBarTitleDisplayMode(.large)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let persistantContainer = CoreDataManager.shared.persistentContainer
        ContentView()
            .environment(\.managedObjectContext, persistantContainer.viewContext)
    }
}
}
