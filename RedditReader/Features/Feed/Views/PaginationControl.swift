//
//  PaginationControl.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/18/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import UIKit

public class PaginationControl: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!

    var onNextButtonTap: (() -> Void)?
    var onPreviousButtonTap: (() -> Void)?

    // MARK: - Overridden functions

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: - Public functions

    func layout(withPreviousHidden previousHidden: Bool) {
        nextButton.setTitle("NEXT", for: .normal)
        previousButton.setTitle("PREVIOUS", for: .normal)
        previousButton.isHidden = previousHidden
    }

    // MARK: - Actions

    @IBAction private func onPreviousTap(_ sender: Any) {
        onPreviousButtonTap?()
    }

    @IBAction private func onNextTap(_ sender: Any) {
        onNextButtonTap?()
    }

    // MARK: - Private functions

    private func commonInit() {
        Bundle.main.loadNibNamed("PaginationControl", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}

