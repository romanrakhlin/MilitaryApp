//
//  ScrollOffsetReader.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import UIKit

/// Reports the enclosing scroll view's offset by observing the backing
/// `UIScrollView` directly. GeometryReader/preference-based tracking stopped
/// updating during scrolling on newer iOS runtimes, so the Home header reads
/// the offset straight from UIKit. Reports 0 at rest, negative when scrolled
/// down (matching the old `minY` semantics).
struct ScrollOffsetReader: UIViewRepresentable {
    var onChange: (CGFloat) -> Void

    func makeUIView(context: Context) -> DetectorView {
        let view = DetectorView()
        view.onChange = onChange
        return view
    }

    func updateUIView(_ uiView: DetectorView, context: Context) {
        uiView.onChange = onChange
    }

    final class DetectorView: UIView {
        var onChange: ((CGFloat) -> Void)?
        private var observation: NSKeyValueObservation?

        override func didMoveToWindow() {
            super.didMoveToWindow()
            guard window != nil, observation == nil else { return }
            var ancestor = superview
            while ancestor != nil, !(ancestor is UIScrollView) { ancestor = ancestor?.superview }
            guard let scrollView = ancestor as? UIScrollView else { return }
            observation = scrollView.observe(\.contentOffset, options: [.initial, .new]) { [weak self] sv, _ in
                let offset = -(sv.contentOffset.y + sv.adjustedContentInset.top)
                DispatchQueue.main.async { self?.onChange?(offset) }
            }
        }

        deinit { observation?.invalidate() }
    }
}
