
import UIKit

private let tag = 0xCAFE

enum LoadingView {

    private static func get(from view: UIView) -> UIView? {
       return view.viewWithTag(tag)
    }

    static func show(on view: UIView) {

        guard get(from: view) == nil else { return }

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.tag = tag
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.translatesAutoresizingMaskIntoConstraints = false

        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white

        vibrancyEffectView.contentView.addSubview(indicator)
        blurEffectView.contentView.addSubview(vibrancyEffectView)

        indicator.startAnimating()

        view.addSubview(blurEffectView)

        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            vibrancyEffectView.topAnchor.constraint(equalTo: blurEffectView.topAnchor),
            vibrancyEffectView.leadingAnchor.constraint(equalTo: blurEffectView.leadingAnchor),
            vibrancyEffectView.trailingAnchor.constraint(equalTo: blurEffectView.trailingAnchor),
            vibrancyEffectView.bottomAnchor.constraint(equalTo: blurEffectView.bottomAnchor),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

    }

    static func stopAndShowMessage(_ message: String, on view: UIView) {

        guard let view = get(from: view) as? UIVisualEffectView,
              let vibrancyView = view.contentView.subviews.first as? UIVisualEffectView,
              let indicator = vibrancyView.contentView.subviews.first as? UIActivityIndicatorView else { return }

        indicator.removeFromSuperview()

        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        label.textColor = .white

        vibrancyView.contentView.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: vibrancyView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: vibrancyView.centerYAnchor)
        ])

    }

    static func hide(from view: UIView) {

        get(from: view)?.removeFromSuperview()

    }

}
