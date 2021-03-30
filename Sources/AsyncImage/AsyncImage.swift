import SwiftUI

public struct AsyncImage<Content, Loading, Failure>: View where Content: View, Loading: View, Failure: View {
    @StateObject private var loader: ImageLoader
    
    private let content: (UIImage) -> Content
    private let loading: () -> Loading
    private let failure: (Error) -> Failure
    
    public init(
        url: URL,
        @ViewBuilder content: @escaping (UIImage) -> Content,
        @ViewBuilder loading: @escaping () -> Loading,
        @ViewBuilder failure: @escaping (Error) -> Failure
    ) {
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
        self.content = content
        self.loading = loading
        self.failure = failure
    }
    
    public var body: some View {
        Group {
            switch loader.result {
            case .failure(let error):
                failure(error)
            case .success(let image):
                content(image)
            default:
                loading()
            }
        }
        .onAppear(perform: loader.load)
    }
}
