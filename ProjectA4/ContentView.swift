import SwiftUI
import Foundation

struct ContentView: View {
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()
    
    @State private var courses = [
        Course(id: UUID(), name: "Spaghetti", dateToBuy: Date(), imageUrl: nil, price: 20.0, colorToShow: Color.brown, store: Store(id: UUID(), name: "Fnac"), urgency: .low),
        Course(id: UUID(), name: "Steak", dateToBuy: Date(), imageUrl: nil, price: 5.0, colorToShow: Color.red, store: Store(id: UUID(), name: "Carrefour"), urgency: .urgent),
        Course(id: UUID(), name: "Iphone 15 Pro", dateToBuy: Date(), imageUrl: nil, price: 1050.99, colorToShow: Color.black, store: Store(id: UUID(), name: "Apple"), urgency: .normal),
        Course(id: UUID(), name: "Iphone 14 Pro", dateToBuy: Date(), imageUrl: nil, price: 1050.99, colorToShow: Color.black, store: Store(id: UUID(), name: "Apple"), urgency: .normal)
        ]

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
                    NavigationLink(destination: AddCourse(CoursesList: $courses), label: {
                        Image(systemName: "plus")
                            .font(.system(size: 20))
                    })
                }
                .padding(.horizontal)
                List {
                    ForEach(Array(courses.grouped(by: { $0.urgency })), id: \.key) { groupedCourses in
                        Section(header: Text(groupedCourses.key.rawValue.capitalized)) {
                            ForEach(groupedCourses.value) { course in
                                NavigationLink(destination: AddCourse(CoursesList: $courses), label: {
                                    HStack(alignment: .center) {
                                        Circle()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(course.colorToShow)
                                            .padding(4)
                                            .overlay(
                                                Circle()
                                                    .stroke(course.colorToShow, lineWidth: 2)
                                            )
                                        Text("\(course.name)")
                                        Spacer()
                                        Text("\(dateFormatter.string(from: course.dateToBuy))")
                                    }
                                })
                            }
                        }
                    }
                    .onDelete { indexSet in
                        courses.remove(atOffsets: indexSet)
                    }
                    .onMove { indexSet, index in
                        courses.move(fromOffsets: indexSet, toOffset: index)
                      }
                }
            }
        }
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
        ContentView()
    }
}
