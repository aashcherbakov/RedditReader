//
//  ImageViewController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/18/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit
import Photos

/// Controller responsible for displaying and saving image from URL
public class ImageViewController: BaseViewController {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var saveButton: UIButton!

    var viewModel: ImageViewViewModel!

    // MARK: - Overridden

    public override func viewDidLoad() {
        super.viewDidLoad()
        imageView.loadImageFrom(url: viewModel.imageUrl)
    }

    // MARK: - Private functions
    
    @IBAction private func onSaveTap(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization({ [weak self] (newStatus) in
            DispatchQueue.main.async {
                guard let weakSelf = self, let image = weakSelf.imageView.image else {
                    return
                }

                if newStatus ==  PHAuthorizationStatus.authorized {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                }
            }
        })
    }
}
