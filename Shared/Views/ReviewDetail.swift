import CoreData
import SwiftUI

struct ReviewDetail: View {
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var review: Review

    @State var placeholderText: String = "Notes"

    var body: some View {
        VStack(alignment: .leading) {
            TextField("Restaurant", text: $review.restaurantName ?? "")
                .font(.title)
                .foregroundColor(.primary)
                .onChange(of: review.restaurantName) { _ in
                    viewContext.saveChanges()
                }

            Divider()

            StarRatingView(rating: $review.starRating)

            ZStack {
                if (review.body ?? "").isEmpty {
                    TextEditor(text: $placeholderText)
                        .font(.body)
                        .foregroundColor(.gray)
                        .disabled(true)
                }
                TextEditor(text: $review.body ?? "")
                    .font(.body)
                    .opacity((review.body ?? "").isEmpty ? 0.8 : 1)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                           maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .onChange(of: review.body) { _ in
                        viewContext.saveChanges()
                    }
            }
        }
        .padding()
    }
}

func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding(
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )
}
