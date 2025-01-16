
import SwiftUI

struct ProfileView: View {
    @State private var profileImage: UIImage
    var name: String
    var title: String
    var years: Int
    var coffees: Int
    var bugs: Int
    var quote: String

    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage? = nil

    init(profileImage: UIImage, name: String, title: String, years: Int, coffees: Int, bugs: Int, quote: String) {
        _profileImage = State(initialValue: profileImage)
        self.name = name
        self.title = title
        self.years = years
        self.coffees = coffees
        self.bugs = bugs
        self.quote = quote
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .center, spacing: 16) {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 5)
                    .onTapGesture {
                        showingImagePicker = true
                    }

                VStack(alignment: .leading, spacing: 4) {
                    Text(name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text(title)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }

                Spacer()
            }

            HStack {
                StatView(title: "Years", value: "\(years)")
                StatView(title: "Coffees", value: "\(coffees)")
                StatView(title: "Bugs", value: "\(bugs)")
            }

            HStack {
                Image(systemName: "quote.bubble")
                    .foregroundColor(.white)
                Text(quote)
                    .font(.body)
                    .foregroundColor(.white)
            }
            Spacer()
        }
        .padding()
        .background(Color.black)
        .cornerRadius(12)
        .shadow(radius: 5)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .onChange(of: selectedImage) { newImage in
            if let newImage = newImage {
                profileImage = newImage
                updateTableViewCellWithImage(newImage)
            }
        }
    }

    private func updateTableViewCellWithImage(_ newImage: UIImage) {

    }
}

struct StatView: View {
    var title: String
    var value: String

    var body: some View {
        VStack {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)

            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

