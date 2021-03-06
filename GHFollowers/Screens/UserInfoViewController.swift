//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Ahmed Nagy on 21/04/2022.
//

import UIKit

protocol UserInfoViewControllerDelegate: AnyObject {
    func didTapGithubProfile(for user: User)
    func didTapGetFollower(for user: User)
}

class UserInfoViewController: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    
    var username: String!
    
    weak var delegate: FollowerListViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        LayoutUI()
        getUserInfo()
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        
        let repoItemViewController = GFRepoItemViewController(user: user)
        let followerItemViewController = GFFollowerItemViewController(user: user)
        repoItemViewController.delegate = self
        followerItemViewController.delegate = self
        
        
        self.add(childVC: repoItemViewController, to: self.itemViewOne)
        self.add(childVC: followerItemViewController, to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
        self.dateLabel.text = "Github since \(user.createdAt.convertToDispalyFormat())"
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func LayoutUI() {
        
        let padding: CGFloat = 30
        let itemHeight: CGFloat = 140
        

        [headerView, itemViewOne, itemViewTwo, dateLabel].forEach { container in
            view.addSubview(container)
            container.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }

        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame =  containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true)
    }
    
}

extension UserInfoViewController: UserInfoViewControllerDelegate {
    
    func didTapGithubProfile(for user: User) {
        // show safari viwe controller
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The URL attached to this user in invalid.", buttonTitle: "Ok")
            return
        }
        presentSafariViewController(with: url)
    }
    
    func didTapGetFollower(for user: User) {
        // tell follower list screen the new user
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers. What a shame ????", buttonTitle: "So sad")
            return
        }
        delegate.didRequestFollower(for: user.login)
        dismissViewController()
    }
    
}
