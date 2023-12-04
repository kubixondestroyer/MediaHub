//import SwiftUI
//import FirebaseFirestoreSwift
//
//struct MoviesListView: View {
//    @StateObject var viewModel = MoviesListViewViewModel()
//    @FirestoreQuery var movies: [Movie]
//    @State private var searchText: String = ""
//
//    init (userId: String) {
//        self._movies = FirestoreQuery(
//            collectionPath: "users/\(userId)/movies"
//        )
//    }
//
//    var body: some View {
//        NavigationView {
//            if movies.count > 0 {
//                List(searchResults) { movie in
//                    NavigationLink {
//                        EditMovieView(viewModel: EditMovieViewViewModel(id: movie.id, title: movie.title, director: movie.director, created: Date(timeIntervalSince1970: movie.created), isWatched: movie.isWatched))
//                    } label: {
//                        MoviesListItemView(title: movie.title, isWatched: movie.isWatched)
//                            .swipeActions {
//                                Button {
//                                    viewModel.delete(id: movie.id)
//                                } label: {
//                                    Text("Delete")
//                                }
//                            }.tint(.red)
//                    }
//                }
//                .navigationTitle("Movies")
//                .toolbar {
//                    Button {
//                        viewModel.showingAddMovieView = true
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//                Spacer()
//                // dodany kod
//                NavigationLink(destination: AdviceView()) {
//                                Text("Doradź mi, jaki film mam obejrzeć")
//                                    .padding()
//                                    .foregroundColor(.white)
//                                    .background(Color.blue)
//                                    .cornerRadius(10)
//                            }
//                .offset(y: -180)
//                .sheet(isPresented: $viewModel.showingAddMovieView) {
//                    AddMovieView(newItemPresented: $viewModel.showingAddMovieView)
//                }
//            } else {
//                VStack {
//                    Image(systemName: "film.stack")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .foregroundColor(Color.blue)
//                        .frame(width: 125, height: 125)
//                        .padding()
//                        .padding(.top, 100)
//                    Text("Your movies collection is empty :(")
//                    Spacer()
//                    // dodany kod
//                    NavigationLink(destination: AdviceView()) {
//                                    Text("Doradź mi, jaki film mam obejrzeć")
//                                        .padding()
//                                        .foregroundColor(.white)
//                                        .background(Color.blue)
//                                        .cornerRadius(10)
//                                }
//                    .offset(y: -180)
//
//
//
//                }.navigationTitle("Movies")
//                .toolbar {
//                    Text("Tekst dodany")
//                    Button {
//                        viewModel.showingAddMovieView = true
//                    } label: {
//                        Image(systemName: "plus")
//                    }
//                }
//                .sheet(isPresented: $viewModel.showingAddMovieView) {
//                    AddMovieView(newItemPresented: $viewModel.showingAddMovieView)
//
//                }
//
//            }
//
//        }
//        .searchable(text: $searchText)
//
//    }
//
//    var searchResults: [Movie] {
//        if searchText.isEmpty {
//            return movies
//        } else {
//            return movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
//        }
//    }
//}
//
//struct MoviesListItemsView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoviesListView(userId: "hhehGNvEYgbMSssZEean65TtBmh2")
//    }
//}
import SwiftUI
import FirebaseFirestoreSwift

struct MoviesListView: View {
    @StateObject var viewModel = MoviesListViewViewModel() // tworzy instancje widoku
    @FirestoreQuery var movies: [Movie]
    @State private var searchText: String = ""

    init(userId: String) {
        self._movies = FirestoreQuery(
            collectionPath: "users/\(userId)/movies"
        )
       // self.viewModel.fetchUserData()
    }

    var body: some View {
        NavigationView {
            VStack {
                if movies.count > 0 {
                    List(searchResults) { movie in
                        NavigationLink(destination: EditMovieView(viewModel: EditMovieViewViewModel(id: movie.id, title: movie.title, director: movie.director, created: Date(timeIntervalSince1970: movie.created), isWatched: movie.isWatched))) {
                            MoviesListItemView(title: movie.title, isWatched: movie.isWatched)
                                .swipeActions {
                                    Button {
                                        viewModel.delete(id: movie.id)
                                    } label: {
                                        Text("Delete")
                                    }
                                }.tint(.red)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("Movies")
                    .toolbar {
                        Button {
                            viewModel.showingAddMovieView = true

                        } label: {
                            Image(systemName: "plus")
                            // opisuje to przycisk dodawania filmow
                        }
                    }
                    .sheet(isPresented: $viewModel.showingAddMovieView) {
                        AddMovieView(newItemPresented: $viewModel.showingAddMovieView)
                    }
                } else {
                    VStack {
                        Image(systemName: "film.stack")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(Color.blue)
                            .frame(width: 125, height: 125)
                            .padding()
                            .padding(.top, 100)

                        Text("Your movies collection is empty :(")
                    }
                    .navigationTitle("Movies")
                    .toolbar {
                        Button {
                            viewModel.showingAddMovieView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    .sheet(isPresented: $viewModel.showingAddMovieView) {
                        AddMovieView(newItemPresented: $viewModel.showingAddMovieView)
                    }
                }

                Spacer() // Spacer na dole widoku

                NavigationLink(destination: AdviceView(viewModel: viewModel, movies: movies, userData: viewModel.userData)) {
                    Text("Doradź mi, jaki film mam obejrzeć")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .position(x:200, y:250)
                }
                .padding()



            }
        }
        .searchable(text: $searchText)
    }

    var searchResults: [Movie] {
        if searchText.isEmpty {
            return movies
        } else {
            return movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }
}
struct MoviesListItemsView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(userId: "hhehGNvEYgbMSssZEean65TtBmh2")
    }
}
		
