//
//  ViewController.swift
//  WKWebView
//
//  Created by Maribel Montejano on 2/23/22.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    var wkWebView: WKWebView

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        wkWebView = WKWebView()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        wkWebView = WKWebView(frame: view.frame)
        view.addSubview(wkWebView)
        wkWebView.uiDelegate = self

        // For Alert
//        let url = URL(string: "https://codepen.io/t263/pen/OJOEGKm")!

        // For Confirm Panel

//        let url = URL(string: "https://codepen.io/t263/pen/jOaKoEx")!

        // For Text Input Panel
        let url = URL(string: "https://codepen.io/t263/pen/eYeKaNx")!

        

        let urlRequest = URLRequest(url: url)
        wkWebView.load(urlRequest)
    }
}

extension ViewController: WKUIDelegate {
    func webView(_ wkWebView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame: WKFrameInfo, completionHandler: () -> Void) {
        print("run javaScript alert panel")
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAlertAction)
        present(alertController, animated: true)
        completionHandler()
    }

    func webView(_ wkWebView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("run javaScript confirm panel")
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        let okAlertAction = UIAlertAction(title: "OK", style: .default) { _ in
            completionHandler(true)
        }
        alertController.addAction(okAlertAction)
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completionHandler(false)
        }
        alertController.addAction(cancelAlertAction)

        present(alertController, animated: true, completion: nil)
    }

    func webView(_ wkWebView: WKWebView, runJavaScriptTextInputPanelWithPrompt message: String, defaultText: String?, initiatedByFrame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print("run javaScript text input panel")
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        alertController.addTextField { textField in
            textField.text = defaultText
        }

        let okAlertAction = UIAlertAction(title: "OK", style: .default) { action in
            if let text = alertController.textFields?.first?.text {
                completionHandler(text)
            } else {
                completionHandler(defaultText)
            }
        }

        alertController.addAction(okAlertAction)
        
        let cancelAlertAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            completionHandler(nil)
        }

        alertController.addAction(cancelAlertAction)

        present(alertController, animated: true, completion: nil)
    }
}
