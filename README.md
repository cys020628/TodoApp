# TodoApp 예제 - SwiftUI & SwiftData 학습 정리

이 문서는 SwiftUI와 SwiftData를 사용하여 Todo 앱을 구현한 예제를 정리한 것입니다.  
프로젝트는 아래와 같이 구성되어 있습니다.

- **ContentView.swift**: 메인 화면과 Todo 목록 표시, 추가/삭제 기능
- **TodoDetailView.swift**: 선택된 Todo의 상세 정보를 편집하는 화면
- **TodoAppApp.swift**: 앱의 진입점 및 ModelContainer 설정
- **Todo.swift**: Todo 데이터를 정의하는 모델 클래스

---

## 앱 화면 이미지

### 메인 화면 (Todo 리스트)

<img width="440" alt="Image" src="https://github.com/user-attachments/assets/a9631cab-5622-4299-ba15-c529d25efe45" />

- 사용자는 할 일 목록을 확인하고, 각 항목을 클릭하여 세부 정보를 확인하거나 수정할 수 있습니다.
- 할 일의 완료 여부에 따라 체크박스 모양이 변하며, 이를 클릭하여 완료 상태를 변경할 수 있습니다.
- 리스트 항목을 왼쪽으로 스와이프하여 삭제할 수 있습니다.

### Todo 상세 화면 (수정)

<img width="440" alt="Image" src="https://github.com/user-attachments/assets/aedf029f-d7bc-4491-b6f8-4466da2e50b6" />

- 선택된 Todo 항목의 세부 정보를 수정할 수 있는 화면입니다.
- 제목을 입력하고, 텍스트 편집기에서 상세 내용을 추가하거나 변경할 수 있습니다.

---

## 1. SwiftUI 및 SwiftData 기본 개념

### SwiftUI
- **View**: 사용자 인터페이스의 구성 요소로, 선언형 문법을 사용하여 UI를 구성합니다.
- **NavigationStack**: 네비게이션 기반 화면 전환을 쉽게 구현할 수 있는 컨테이너 뷰입니다.
- **List**: 데이터를 리스트 형태로 표시하며, 각 항목에 대해 ForEach를 활용합니다.
- **Toolbar**: 네비게이션 바에 버튼이나 기타 뷰를 추가할 수 있습니다.
- **@State, @Environment, @Query**: 상태 및 환경 데이터를 관리하기 위한 프로퍼티 래퍼입니다.

### SwiftData
- **ModelContainer**: 앱 전체에서 공유되는 데이터 모델 저장소 역할을 하며, 데이터의 영속성을 관리합니다.
- **@Model 어노테이션**: 클래스를 데이터 모델로 사용하기 위한 어노테이션으로, SwiftData에서 관찰 가능한 객체로 취급합니다.
- **modelContext**: 데이터베이스와 상호작용할 때 사용하는 컨텍스트입니다.
- **insert(_:)와 delete(_:)**: 모델 객체를 추가 및 삭제할 때 사용합니다.

---

## 2. 파일별 상세 설명

### ContentView.swift
- **목적**: Todo 리스트를 표시하고, 추가 및 삭제 기능을 제공합니다.
- **주요 구성요소**:
  - `@Environment(\.modelContext)`: SwiftData의 데이터 모델 컨텍스트를 환경에서 가져옵니다.
  - `@Query var todoList: [Todo]`: 초기 Todo 목록을 선언하고, SwiftData를 통해 자동으로 데이터 바인딩을 관리합니다.
  - **추가 기능 (`addTodo`)**: 새로운 Todo 객체를 생성하고, 데이터 컨텍스트에 추가합니다.
    - 예시 코드:
      ```swift
      func addTodo() {
          withAnimation {
              let newTodo = Todo(title: "새로운 할일")
              modelContext.insert(newTodo)
          }
      }
      ```
  - **삭제 기능 (`delsteTodo`)**: List에서 선택된 항목을 삭제합니다.
    - 예시 코드:
      ```swift
      func delsteTodo(indexSet: IndexSet) {
          withAnimation {
              for index in indexSet {
                  modelContext.delete(todoList[index])
              }
          }
      }
      ```
  - **NavigationStack & List**: Todo 항목을 리스트 형식으로 표시하고, 각 항목을 클릭하면 상세 화면으로 이동하도록 구성합니다.
  - **EditButton와 + 버튼**: 리스트 편집 모드와 새로운 Todo 추가 기능을 툴바에 배치합니다.

  **예시 코드 (ContentView)**:
  ```swift
  NavigationStack {
      List {
          ForEach(todoList) { todo in
              HStack {
                  Image(systemName: todo.isCompleted ? "circle.fill" : "circle")
                      .foregroundColor(.pink)
                      .onTapGesture {
                          todo.isCompleted.toggle()
                      }

                  NavigationLink {
                      TodoDetailView(todo: todo)
                  } label: {
                      Text(todo.title)
                          .strikethrough(todo.isCompleted, color: .gray)
                          .foregroundStyle(todo.isCompleted ? .gray : .primary)
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
              Button(action: addTodo, label: {
                  Image(systemName: "plus")
              })
          }
      }
  }
