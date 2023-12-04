import SwiftUI

struct MoviesListItemView: View {
    let title: String
    let isWatched: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isWatched ? "checkmark.circle.fill" : "circle").foregroundColor(Color.blue)
            Text(title)
        }
    }
}

// to daje jedynie ten znaczek zaznaczenia w kółeczku obok tytułu

struct MoviesListItemView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListItemView(title: "Jaws", isWatched: true)
    }
}
	
