//
//  ViewController.swift
//  0918PinPlist
//
//  Created by D7702_10 on 2017. 9. 18..
//  Copyright © 2017년 D7702_10. All rights reserved.
//

import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var maps: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocateToCenter()
        
        // plist data 가져오기
        let path = Bundle.main.path(forResource: "ViewPoint", ofType: "plist")
        print("path= \(String(describing: path))")
        
        //NSArray는 컬랙션 타입 any타입
        let contents = NSArray(contentsOfFile: path!)
        print("content = \(String(describing: contents))")
        
        // pint point를 저장하기 위한 배열 선언
        var annotations = [MKPointAnnotation]()
        
        //contents(딕셔너리의 배열)에서 데이터 뽑기
        //any타입을 사용하기위해 as anyobject를 적용
        if let myItems = contents {
            for item in myItems {
                let lat = (item as AnyObject).value(forKey: "lat")
                let long = (item as AnyObject).value(forKey: "long")
                let title = (item as AnyObject).value(forKey: "title")
                let subTitle = (item as AnyObject).value(forKey: "subTitle")
                
                print("lat = \(String(describing: lat))")
                
                //핀 꼽기
                let anno = MKPointAnnotation()
                
                //데이터 변환
                let myLat = (lat as! NSString).doubleValue
                let myLong = (long as! NSString).doubleValue
                let mytitle = title as! String
                let mysub = subTitle as! String
                
                anno.coordinate.latitude = myLat
                anno.coordinate.longitude = myLong
                anno.title = mytitle
                anno.subtitle = mysub
                
                annotations.append(anno)
            }
        } else {
            print("content = nil")
        }
        
        maps.showAnnotations(annotations, animated: true)
        maps.addAnnotations(annotations)
        
        maps.delegate = self
    }

    func LocateToCenter(){
        let center = CLLocationCoordinate2DMake(35.166197, 129.072594)
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegionMake(center, span)
        
        maps.setRegion(region, animated: true)
    }

}

