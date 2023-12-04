

//
//struct AdviceView: View {
//    var body: some View {
//        VStack {
//
//            //Spacer()
//            Button(action: {
//                print("Doradź mi, jaki film mam obejrzeć")
//            }) {
//                Text("Doradź mi, jaki film mam obejrzeć")
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//            //Spacer()
//        }
//        .padding()
//        .navigationTitle("Advice")
//        .offset(y: +250)
//
//    }
//
////    .offset(y: -50)
//}
//
//struct AdviceView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdviceView()
//    }
//}

//import SwiftUI
//
//struct AdviceView: View {
//    @ObservedObject var viewModel: MoviesListViewViewModel
//    var movies: [Movie]
//    var userData: User?
//
//    var body: some View {
//        VStack {
//            Text("Hello, \(userData?.name ?? "")!") // Wyświetl nazwę użytkownika
//            Button(action: {
//                printMovieData()
//                print("cst")
//            }) {
//                Text("Doradź mi, jaki film mam obejrzeć")
//                    .padding()
//                    .foregroundColor(.white)
//                    .background(Color.blue)
//                    .cornerRadius(10)
//            }
//        }
//        .padding()
//        .navigationTitle("Advice")
//        .offset(y: +250)
//    }
//
//    func printMovieData() {
//        for movie in movies {
//            print("Movie Title: \(movie.title), Director: \(movie.director)")
//        }
//    }
//}
//

import SwiftUI
import FirebaseFirestoreSwift
struct AdviceView: View {
    @ObservedObject var viewModel: MoviesListViewViewModel
    var movies: [Movie]
    var userData: User?

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Hello, \(userData?.name ?? "")!")
                    .font(.headline) // Wyświetl nazwę użytkownika
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.top, 80)
            

            // Kafelka wyświetlająca wyniki funkcji printMovieData()
            VStack(alignment: .leading) {
                Text("Those are my suggestions\n on the movie\n you should watch:\n")
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                
                ForEach(movies.prefix(5), id: \.id){ movie in
                    Text("Title: \(movie.title), Director: \(movie.director)")
                }
            }.padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
            .padding(.bottom, 200)

            Button(action: {
                printMovieData()
            }) {
                Text("Advice me!")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 150)
            }
        }
        .padding()
        .navigationTitle("Advice")
    }
                            
    

    func printMovieData() {
        for movie in movies {
            print("Movie Title: \(movie.title), Director: \(movie.director)")
        }
    }
}

struct AdviceView_Previews: PreviewProvider {
    static var previews: some View {
        AdviceView(viewModel: MoviesListViewViewModel(), movies: [], userData: nil)
    }
}

//struct AdviceView_Previews: PreviewProvider {
//    static var previews: some View {
//        AdviceView(viewModel: MoviesListViewViewModel(), movies: [], userData: nil)
//    }
//}


