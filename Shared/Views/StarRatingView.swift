import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int16

    let starImage = Image(systemName: "star.fill")

    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                starImage
                    .foregroundColor(index >= rating ? Color.gray : Color.blue)
                    .onTapGesture {
                        rating = Int16(index + 1)
                    }
            }
        }
    }
}
