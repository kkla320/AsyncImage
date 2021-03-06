import SwiftUI

public struct AsyncImage<Source, Content, Loading, Failure>: View where Source: ImageSource, Content: View, Loading: View, Failure: View {
    @StateObject private var loader: ImageLoader<Source>
    
    private let content: (Image) -> Content
    private let loading: () -> Loading
    private let failure: (Error) -> Failure
    
    public init(
        imageSource: Source,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder loading: @escaping () -> Loading,
        @ViewBuilder failure: @escaping (Error) -> Failure
    ) {
        _loader = StateObject(wrappedValue: ImageLoader(source: imageSource, cache: Environment(\.imageCache).wrappedValue))
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
        .onAppear {
            loader.load()
        }
    }
}

extension AsyncImage where Source == URLImageSource {
    public init(
        url: URL,
        @ViewBuilder content: @escaping (Image) -> Content,
        @ViewBuilder loading: @escaping () -> Loading,
        @ViewBuilder failure: @escaping (Error) -> Failure
    ) {
        self.init(imageSource: URLImageSource(url: url), content: content, loading: loading, failure: failure)
    }
}
