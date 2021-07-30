import Foundation
import Combine
import SwiftUI

struct ExampleView: View {
    @ObservedObject var director: ExampleDirector
    var navigationPublisher: AnyPublisher<NavigationDirection, Never>
    
    var body: some View {
        VStack {
            if director.viewModel.isAlertShowing {
                Text(director.viewModel.errorString)
                
                Button(action: {
                    director.handleAction(.mainButtonTapped)
                }, label: {
                    Text("")
                })
            } else {
                EmptyView()
            }
        }
        .handleNavigation(navigationPublisher)
    }
}
