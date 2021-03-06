//
//  SlideInPresentationManager.swift
//  MedalCount
//
//  Created by Samuel Hicks on 12/11/17.
//  Copyright © 2017 Ron Kliffer. All rights reserved.
//

import UIKit

enum PresentationDirection {
  case left
  case top
  case right
  case bottom
}

class SlideInPresentationManager: NSObject {
  var direction = PresentationDirection.left
  var disableCompactHeight = false
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
  func presentationController(forPresented presented: UIViewController,
                              presenting: UIViewController?,
                              source: UIViewController) -> UIPresentationController? {
    let presentationController = SlideInPresentationController(presentedViewController: presented,
                                                               presenting: presenting,
                                                               direction: direction)
    
    presentationController.delegate = self
    return presentationController
  }
  
  func presentationController(_ controller: UIPresentationController,
                              viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle)
    -> UIViewController? {
      guard style == .overFullScreen else { return nil }
      
      return UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "RotateViewController")
  }
  
  func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return SlideInPresentationAnimator(direction: direction, isPresentation: true)
  }
  
  func animationController(forDismissed dismissed: UIViewController)
    -> UIViewControllerAnimatedTransitioning? {
      return SlideInPresentationAnimator(direction: direction, isPresentation: false)
  }
}
