//
//  MapPage.swift
//  Lessons
//
//  Created by Kamila on 10/19/19.
//  Copyright © 2019 Kamila. All rights reserved.
//

import UIKit
import MapKit

class MapPage: UIViewController {
    private var mapView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
        configurationMapView()
    }
    
    private func layoutUI() {
        view.addSubview(mapView)
        mapView.frame = view.frame
    }
    
    private func configurationMapView() {
          mapView.delegate = self
          mapView.showsUserLocation = true
          mapView.mapType = .standard
      }
}

extension MapPage: MKMapViewDelegate {
    
}
