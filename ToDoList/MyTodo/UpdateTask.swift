//
//  UpdateTask.swift
//  TodoListApp
//
//  Created by Wejdan Alkhaldi on 01/04/1443 AH.
//

import SwiftUI

struct UpdateTask: View {
    var task:Task?
    @Environment(\.managedObjectContext) private var ViewContext
    @State var title : String = ""
    @State var content : String = ""
    @State var isCheck : Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    
    init(task: Task? = nil){
        self.task = task
        _title = State(initialValue: task?.title ?? "")
        _content = State(initialValue: task?.content ?? "")
        _isCheck = State(initialValue: task?.isCheck ?? false)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter new itle", text: $title)
                TextField("Enter new content", text: $content)
                    .padding(.vertical)
                Toggle(isOn: $isCheck) {}.labelsHidden()
                Button {
                    do {
                        if let task = task {
                            task.title = title
                            task.content = content
                            task.isCheck = isCheck
                            try ViewContext.save()
                        }
                    } catch {}
                    presentationMode.wrappedValue.dismiss()
                }label: {
                    Text("SAVE 💾 ")
                        .padding(.vertical)
                }.navigationTitle("Edit 🛠")
                
            }.padding()
        }
    }
    
    struct UpdateTaskyView_Previews: PreviewProvider {
        static var previews: some View {
            UpdateTask()
            let persistantContainer = CoreDataManager.shared.persistentContainer
            ContentView()
                .environment(\.managedObjectContext, persistantContainer.viewContext)
        }
    }
}

