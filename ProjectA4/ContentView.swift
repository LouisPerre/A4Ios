import SwiftUI
import Foundation

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var myCoursesCollection: CoursesCollection
    
    let saveAction: ()->Void

    var body: some View {
        
        NavigationView {
            VStack {
                HStack {
                    Image(systemName: "plus")
                        .font(.system(size: 20))
                        .foregroundColor(.clear)
                    Spacer()
                    Text("Courses")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.black)
                    Spacer()
                    NavigationLink(destination: AddCourse(coursesCollection: myCoursesCollection), label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20))
                    })
                }
                .padding(.horizontal)
                List {
                    ForEach(Array(myCoursesCollection.courses.grouped(by: { $0.urgency })), id: \.key) { groupedCourses in
                        Section(header: Text(groupedCourses.key.rawValue.capitalized)) {
                            ForEach(groupedCourses.value) { course in
                                NavigationLink(destination: SingleCourse(Course: course), label: {
                                    CourseCell(Course: course)
                                })
                            }
                        }
                    }
                    .onDelete { indexSet in
                        myCoursesCollection.courses.remove(atOffsets: indexSet)
                    }
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            print(scenePhase)
            if phase == .inactive {
                saveAction()
            }
        }
//        .onChange(of: scenePhase) {
//            if scenePhase == .inactive { saveAction() } 
//        }
    }
}

extension Array {
    func grouped<Key: Hashable>(by keyForValue: (Element) -> Key) -> [Key: [Element]] {
        var result = [Key: [Element]]()
        for element in self {
            let key = keyForValue(element)
            if result[key] == nil {
                result[key] = [Element]()
            }
            result[key]?.append(element)
        }
        return result
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(myCoursesCollection: CoursesCollection(courses: Course.previewCourse), saveAction: {})
    }
}
