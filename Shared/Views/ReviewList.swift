import SwiftUI
import CoreData

struct ReviewList: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Review.timestamp, ascending: false)
        ]
    )
    private var reviews: FetchedResults<Review>
    
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(reviews, id: \.self) { review in
                    NavigationLink(destination: ReviewDetail(review: review)) {
                        ReviewRow(review: review)
                    }
                }
                .onDelete(perform: deleteReviews)
            }
            .navigationTitle("Reviews")
            .maybeSearchable(text: $searchText)
            .keyboardShortcut(.delete, modifiers: [])
            .toolbar {
#if os(macOS)
                ToolbarItemGroup(placement: .automatic) {
                    Spacer()

                    Button(action: addReview, label: {
                        Image(systemName: "plus")
                        Text("Write review")
                    })
                }
#elseif os(iOS)
                Button(action: addReview, label: {
                    Image(systemName: "plus")
                })
#endif
            }
        }
    }

    private func addReview() {
        withAnimation {
            let newReview = Review(context: viewContext)
            newReview.timestamp = Date()
            viewContext.saveChanges()
        }
    }

    private func deleteReviews(offsets: IndexSet) {
        withAnimation {
            offsets.map { reviews[$0] }.forEach(viewContext.delete)
            viewContext.saveChanges()
        }
    }
}

extension View {
    func maybeSearchable(text: Binding<String>, prompt: Text? = nil) -> some View {
        if #available(macOS 12.0, iOS 15.0, *) {
            return AnyView(searchable(text: text, prompt: prompt))
        } else {
            return AnyView(self)
        }
    }
}
