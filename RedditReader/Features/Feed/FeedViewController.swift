//
//  FeedViewController.swift
//  RedditReader
//
//  Created by Alex Shcherbakov on 3/15/18.
//  Copyright © 2018 Oleks Shcherbakov. All rights reserved.
//

import Foundation
import UIKit

public class FeedViewController: BaseViewController {

    var viewModel: FeedViewModel!

    @IBOutlet weak var tableView: UITableView!

    public override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadFeed()
    }
}
