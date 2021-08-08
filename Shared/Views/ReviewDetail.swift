import CoreData
import SwiftUI

struct ReviewDetail: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var review: Review
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Restaurant", text: $review.restaurantName ?? "")
                .font(.title)
                .foregroundColor(.primary)

            Divider()

            TextEditor(text: $review.body ?? "")
                .font(.body)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        }
    }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
