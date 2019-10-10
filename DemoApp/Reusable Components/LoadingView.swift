
import UIKit

private let tag = 0xCAFE

enum LoadingView {

    private static func get() -> UIView? {
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.viewWithTag(tag)
    }

    static func show(on view: UIView) {

        guard get() == nil else { return }

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.tag = tag
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white

        blurEffectView.contentView.addSubview(indicator)

        indicator.startAnimating()

        view.addSubview(blurEffectView)

        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

    }

    static func hide() {

        get()?.removeFromSuperview()

    }

}
