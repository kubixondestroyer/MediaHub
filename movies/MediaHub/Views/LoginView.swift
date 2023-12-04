import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewViewModel()

    var body: some View {
        NavigationView {
            VStack {
                HeaderView(title: "MediaHub", subtitle: "Your personal media library", backgroundColor: .blue)
        
                Form {
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }

                    TextField("Email Address", text: $viewModel.email)
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    SecureField("Password", text: $viewModel.password)
                    CustomButtonView(text: "Log In", color: .blue) {
                        viewModel.login()
                    }
                    .padding(.top)
                    .padding(.bottom)
                }
                .offset(y: -50)

                VStack {
                    Text("Don't have account yet?")
                    NavigationLink("Create an account", destination: RegisterView())
                }
                .padding(.bottom, 50)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
