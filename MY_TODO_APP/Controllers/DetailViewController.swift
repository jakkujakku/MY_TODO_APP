//
//  DetailViewController.swift
//  MY_TODO_APP
//
//  Created by (^ㅗ^)7 iMac on 2023/08/31.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!

    let service = MediaService(configuration: .default)
    let apiKey = "live_cvQixQ9hpKO5HQ05AGdsH2kPlR1FTwbPJuvUN4iGpNovqY1eoQnXUY0m5m8iBvWa"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        indicatorView.startAnimating()
        service.fetchProfile(apiKey: apiKey, completion: { result in
            switch result {
            case .success(let completion):
                guard let completionImage = completion.first else { return }
                DispatchQueue.main.async {
                    self.imageView.load(url: URL(string: completionImage.url) ?? URL(fileURLWithPath: ""))
                    self.indicatorView.stopAnimating()
                    self.indicatorView.isHidden = true
                }
                print("### \(completion)")
            case .failure(let error):
                print("### \(error.localizedDescription)")
            }
        })
    }

    private func setupUI() {
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.frame.size = .init(width: 400, height: 400)
        
        indicatorView.isHidden = false
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
