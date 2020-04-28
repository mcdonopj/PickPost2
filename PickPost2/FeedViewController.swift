//
//  FeedViewController.swift
//  PickPost2
//
//  Created by Ann McDonough on 4/25/20.
//  Copyright © 2020 Patrick McDonough. All rights reserved.
//


import UIKit

class FeedViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate
{
    fileprivate lazy var pages: [UIViewController] = {
        return [
            self.getViewController(withIdentifier: "TextPostFeedVC"),
            self.getViewController(withIdentifier: "PickPostFeedVC")
        ]
    }()
    
    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController
    {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        
        if let firstVC = pages.first
        {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension FeedViewController
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0          else { return pages.last }
        
        guard pages.count > previousIndex else { return nil        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = pages.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < pages.count else { return pages.first }
        
        guard pages.count > nextIndex else { return nil         }
        
        return pages[nextIndex]
    }
}

extension FeedViewController { }














//
//import UIKit
//
//class FeedViewController:  UIPageViewController, UIPageViewControllerDataSource {
//    var vcArray: [UIViewController] = [TextPostFeedViewController(), PickPostFeedViewController()]
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        dataSource = self
//
//        if let firstViewController = vcArray.first {
//            setViewControllers([firstViewController],
//                               direction: .forward,
//            animated: true,
//            completion: nil)
//        }
//    }
//
////    func pageViewController(pageViewController: UIPageViewController,
////    viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
////       // guard let viewControllerIndex = vcArray.indexOf(viewController) else {
////
////            return nil
////        }
//
//     //   let previousIndex = viewControllerIndex - 1
//
////       guard previousIndex >= 0 else {
////            return nil
////        }
////
////        guard vcArray.count > previousIndex else {
////            return nil
////        }
////
////        return vcArray[previousIndex]
////    }
//
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        return vcArray[0]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//     return vcArray[1]
//    }
//
//
//
//}
//
//
//
//
//
//////class FeedViewController:  UIPageViewController, UIPageViewControllerDataSource {
//////private(set) lazy var orderedViewControllers: [UIViewController] = {
//////    return [self.newColoredViewController("RedViewController"),
//////    self.newColoredViewController("GreenViewController")]
//////}()
////
////private func newColoredViewController(color: String) -> UIViewController {
////
////return UIStoryboard(name: "Main", bundle: nil) .
////    instantiateViewControllerWithIdentifier("\(color)ViewController")
////}
////
////override func viewDidLoad() {
////    super.viewDidLoad()
////
////    dataSource = self
////
////    if let firstViewController = orderedViewControllers.first {
////        setViewControllers([firstViewController],
////                           direction: .forward,
////        animated: true,
////        completion: nil)
////    }
////}
////
////func pageViewController(pageViewController: UIPageViewController,
////viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
////    guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
////        return nil
////    }
////
////    let previousIndex = viewControllerIndex - 1
////
////    guard previousIndex >= 0 else {
////        return nil
////    }
////
////    guard orderedViewControllers.count > previousIndex else {
////        return nil
////    }
////
////    return orderedViewControllers[previousIndex]
////}
////
////func pageViewController(pageViewController: UIPageViewController,
////viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
////    guard let viewControllerIndex = orderedViewControllers.indexOf(viewController) else {
////        return nil
////    }
////
////    let nextIndex = viewControllerIndex + 1
////    let orderedViewControllersCount = orderedViewControllers.count
////
////    guard orderedViewControllersCount != nextIndex else {
////        return nil
////    }
////
////    guard orderedViewControllersCount > nextIndex else {
////        return nil
////    }
////
////    return orderedViewControllers[nextIndex]
////}
//////}
////
////
