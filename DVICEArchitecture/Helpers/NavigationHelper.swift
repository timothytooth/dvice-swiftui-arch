import Foundation
import Combine
import SwiftUI

struct NavigationHandler: ViewModifier {
    let navigationPublisher: AnyPublisher<NavigationDirection, Never>
    
    @State private var destination: NavigationDestination?
    @State private var sheetActive = false
    @State private var linkActive = false
    @Environment(\.presentationMode) var presentation
    
    let viewFactory: ViewFactory = ViewFactory()
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $sheetActive) {
                buildDestination()
            }
            .background(
                NavigationLink(destination: buildDestination(), isActive: $linkActive) {
                    EmptyView()
                }
            )
            .onReceive(navigationPublisher) { direction in
                switch direction {
                case .forward(let destination, let style):
                    self.destination = destination
                    switch style {
                    case .present:
                        sheetActive = true
                    case .push:
                        linkActive = true
                    }
                case .back:
                    presentation.wrappedValue.dismiss()
                }
            }
    }

    @ViewBuilder
    private func buildDestination() -> some View {
        if let destination = destination {
            viewFactory.makeView(destination: destination)
        } else {
            EmptyView()
        }
    }
}

extension View {
    func handleNavigation(_ publisher: AnyPublisher<NavigationDirection, Never>) -> some View {
        self.modifier(NavigationHandler(navigationPublisher: publisher))
    }
}
