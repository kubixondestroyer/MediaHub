import SwiftUI

struct CustomButtonView: View {
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(color)
                Text(text)
                    .foregroundColor(Color.white)
                    .bold()
            }
        }
    }
}

struct CustomButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonView(text: "Button", color: .blue) {
            
        }
    }
}
