//
//  ContentView.swift
//  TodoApp
//
//  Created by 영석 on 3/20/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Query var todoList:[Todo] = [
        Todo(title: "친구 만나기"),
        Todo(title: "과재 재출하기"),
        Todo(title: "푹쉬기")
    ]
    
    
    // 새로운 할일 추가
    func addTodo() {
        withAnimation {
            let newTodo = Todo(title: "새로운 할일")
            modelContext.insert(newTodo)
        }
    }
    
    // 할일 삭제
    func delsteTodo(indexSet:IndexSet) {
        withAnimation {
            for index in indexSet {
                modelContext.delete(todoList[index])
            }
        }
    }

    var body: some View {
        
        EmptyView()
        
        NavigationStack {
            List {
                
                ForEach(todoList) { todo in
                    HStack {
                        
                        Image(systemName: todo.isCompleted ==
                              true  ? "circle.fill" : "circle")
                            .foregroundColor(.pink)
                            .onTapGesture {
                                todo.isCompleted.toggle()
                            }
                        
                        
                        NavigationLink {
                            // 세부 Todo
                            TodoDetailView(todo: todo)
                            
                            
                        } label: {
                            Text(todo.title)
                                .strikethrough(todo.isCompleted,
                                               color : Color.gray)
                                .foregroundStyle(todo.isCompleted == true ? .gray : .primary)
                        }
                        
                    }
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: delsteTodo)
              
            }
            .listStyle(.plain)
            .navigationTitle(Text("Todo 🏓"))
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                
                ToolbarItem {
                    Button(action : addTodo,
                           label : {
                        Image(systemName: "plus")
                    })
                }
            }
        }
        
    }
}

#Preview {
    ContentView()}
