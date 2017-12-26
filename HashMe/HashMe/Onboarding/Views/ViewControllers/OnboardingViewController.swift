//
//  OnboardingViewController.swift
//  HashMe
//
//  Created by Dheeru on 9/23/17.
//  Copyright © 2017 Dheeru. All rights reserved.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    
    var flowDelegate: HashTagFlowDelegate?
    
    var getstartedButton: UIButton!
    
    var pageControl = UIPageControl()
    
    lazy var orderedViewControllers: [UIViewController] = {
        return [self.newVc(viewController: Constants.onboardingViewController1),
                self.newVc(viewController: Constants.onboardingViewController2),
                self.newVc(viewController: Constants.onboardingViewController3)]
    }()
    
    var viewModel: OnboardingViewConfigurable? {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateNavControllerProperties()
    }
    
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        let customUserDefaults = CustomUserDefault()
        customUserDefaults.setOnboardingWithValue()
        
        self.flowDelegate?.showPredictionsView()
    }
}

//MARK: UI
extension OnboardingViewController {
    fileprivate func configureUI() {
        showTheFirstViewController()
        self.view.setupMediumBluredViewOnImage(UIImage.SunshineGreenery)
        self.viewModel = OnboardingViewModel()
        configureGetStartedButton()
        configurePageControl()
    }
    
    fileprivate func showTheFirstViewController() {
        //following will help setting up the first view controller to show
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
    
    fileprivate func updateNavControllerProperties() {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 20)]
    }
    
    fileprivate func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.maxY - 50,width: UIScreen.main.bounds.width,height: 50))
        self.pageControl.numberOfPages = orderedViewControllers.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.white
        self.view.addSubview(pageControl)
    }
    
    fileprivate func configureGetStartedButton() {
        getstartedButton = UIButton(frame:  CGRect(x: 0, y: UIScreen.main.bounds.maxY - 100,width: 150, height: 50))
        getstartedButton.center.x = self.view.center.x
        getstartedButton.center.y = self.view.frame.size.height/1.15
        getstartedButton.layer.cornerRadius = 14.0
        getstartedButton.layer.borderWidth = 2
        getstartedButton.layer.borderColor = UIColor.white.cgColor
        getstartedButton.titleLabel?.textColor = UIColor.white
        getstartedButton.addTarget(self, action: #selector(OnboardingViewController.getStartedButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        self.getstartedButton.setTitle(viewModel?.getStartedButtonTitle ?? LocalizedString.getStartedButtonTitle, for: UIControlState.normal)
        self.scaleButtonToZero()
        self.view.addSubview(getstartedButton)
    }
    
    fileprivate func scaleButtonToZero() {
        getstartedButton.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    fileprivate func showGetStartedButton() {
        self.animateGetStartedButton()
    }
    
    fileprivate func hideGetStartedButton() {
        UIView.animate(withDuration: OnboardingAnimationDuration.getStartedButton.rawValue,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1,
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        self.getstartedButton.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        }, completion: { (success) in
            self.scaleButtonToZero()
        })
    }
    
    fileprivate func animateGetStartedButton() {
        UIView.animate(withDuration: OnboardingAnimationDuration.getStartedButton.rawValue,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 1,
                       options: UIViewAnimationOptions.allowUserInteraction,
                       animations: {
                        self.getstartedButton.transform = .identity
        }, completion: nil)
    }
    
    fileprivate func newVc(viewController: String) -> UIViewController {
        return UIStoryboard(name: Constants.mainStoryboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
}

//MARK: UIPageViewControllerDelegate
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let validViewController = pageViewController.viewControllers else { return }
        let pageContentViewController = validViewController[0]
        self.pageControl.currentPage = orderedViewControllers.index(of: pageContentViewController)!
        
        shouldShowGetStartedButton()
    }
    
    fileprivate func shouldShowGetStartedButton() {
        let lastPage = self.pageControl.numberOfPages - 1
        pageControl.currentPage == lastPage ? showGetStartedButton() : hideGetStartedButton()
    }
}

//MARK: UIPageViewControllerDataSource
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1

        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
//            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
             return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
//            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
             return nil
        }
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
}
