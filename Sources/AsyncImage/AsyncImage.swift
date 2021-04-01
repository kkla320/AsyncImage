import SwiftUI

public struct AsyncImage<Source, Cache, Content, Loading, Failure>: View where Source: ImageSource, Cache: ImageCache, Source.Key == Cache.Key, Content: View, Loading: View, Failure: View {
    @StateObject private var loader: ImageLoader<Source, Cache>
    
    private let content: (UIImage) -> Content
    private let loading: () -> Loading
    private let failure: (Error) -> Failure
    
    public init(
        imageSource: Source,
        imageCache: Cache? = nil,
        @ViewBuilder content: @escaping (UIImage) -> Content,
        @ViewBuilder loading: @escaping () -> Loading,
        @ViewBuilder failure: @escaping (Error) -> Failure
    ) {
        _loader = StateObject(wrappedValue: ImageLoader(source: imageSource, cache: imageCache))
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

extension AsyncImage where Source == URLImageSource {
    public init(
        url: URL,
        imageCache: Cache? = nil,
        @ViewBuilder content: @escaping (UIImage) -> Content,
        @ViewBuilder loading: @escaping () -> Loading,
        @ViewBuilder failure: @escaping (Error) -> Failure
    ) {
        self.init(imageSource: URLImageSource(url: url), imageCache: imageCache, content: content, loading: loading, failure: failure)
    }
}
