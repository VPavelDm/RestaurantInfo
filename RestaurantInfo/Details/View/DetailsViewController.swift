//
//  DetailsViewController.swift
//  RestaurantReservation
//
//  Created by VAITSIKHOUSKAYA on 30/08/2021.
//

import UIKit

class DetailsViewController: UIViewController, WidgetDelegate {

    // MARK: - Outlets
    @IBOutlet var leadingConstraints: [NSLayoutConstraint]!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var nameResto: UILabel!
    @IBOutlet weak var imageResto: UIImageView!
    @IBOutlet weak var topContaintConstraint: NSLayoutConstraint!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var personalInfo: PersonalInfoView!
    
    // MARK: - Properties
    var restaurant: RestaurantInfo!
    var shouldInitConstraints = true
    var widgetDataSourceDelegate = WidgetsDataSourceDelegate()

    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        widgetDataSourceDelegate.delegate = self
        setupUI()
        collectionView.delegate = widgetDataSourceDelegate
        collectionView.dataSource = widgetDataSourceDelegate
        registerForKeyboardNotification()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if shouldInitConstraints {
            for constraint in leadingConstraints {
                constraint.constant = view.safeAreaLayoutGuide.layoutFrame.width
            }
            leadingConstraints[0].constant = 0
        }
        shouldInitConstraints = false
    }
    
    // MARK: - Setup UI
    func setupUI() {
        nameResto.text = restaurant.name
        navigationItem.title = restaurant.name
        activityIndicator.startAnimating()
        loadRestaurantPhoto()
    }
    func loadRestaurantPhoto() {
        let imageLoader = ImageLoader()
        imageLoader.load(url: restaurant.image) { image in
            self.imageResto.image = image
            self.activityIndicator.stopAnimating()
        }
    }
    
    // MARK: - Keyboard
    func registerForKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardDidShow(_ notification: Notification) {
        let keyboardSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        personalInfo.scrollView.contentInset.bottom = keyboardSize.height - view.safeAreaInsets.bottom + 12
    }
    @objc func keyboardWillHide(_ notification: Notification) {
        personalInfo.scrollView.contentInset.bottom = .zero
    }
    
    // MARK: - Actions
    @IBAction func continueIsPressed(_ button: UIButton) {
        widgetDataSourceDelegate.showNextWidget(collectionView: collectionView)
    }
    
    // MARK: - WidgetDelegate
    func widgetIsChanged() {
        if widgetDataSourceDelegate.visibleWidget == .pensonInfo {
            actionButton.titleLabel?.text = "Reserve"
        } else {
            actionButton.titleLabel?.text = "Continue"
        }
    }
    func layoutViewIfNeeded() {
        view.layoutIfNeeded()
    }
    var screenWidth: CGFloat {
        view.safeAreaLayoutGuide.layoutFrame.width
    }
}
