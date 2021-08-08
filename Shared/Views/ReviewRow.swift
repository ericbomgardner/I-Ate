import SwiftUI

struct ReviewRow: View {
    @ObservedObject var review: Review

    var body: some View {
        HStack {
            if let restaurantName = review.restaurantName,
               !restaurantName.isEmpty
            {
                Text(restaurantName)
            } else {
                Text("New restaurant").italic()
            }
            
            Spacer()

            if let timestamp = review.timestamp {
                Text({ () -> String in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateStyle = .short
                    dateFormatter.timeStyle = .none
                    dateFormatter.locale = Locale(identifier: "en_US")
                    return dateFormatter.string(from: timestamp)
                }())
            }
        }
    }
}
