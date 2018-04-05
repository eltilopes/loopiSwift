//
//  MapViewController.swift
//  Loopi
//
//  Created by Loopi on 08/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController,CLLocationManagerDelegate,GMSMapViewDelegate, UISearchBarDelegate ,LocateOnTheMap,GMSAutocompleteFetcherDelegate,FloatyDelegate  {
    
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var addressLabel: UILabel!
    var addressString:String! = nil
    var searchResultController: SearchMapResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!
    var marker = GMSMarker()
    
    @IBOutlet weak var googleMapsContainer: UIView!
    /**
     * Called when an autocomplete request returns an error.
     * @param error the error that was received.
     */
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    /**
     * Called when autocomplete predictions are available.
     * @param predictions an array of GMSAutocompletePrediction objects.
     */
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //self.resultsArray.count + 1
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
    open let floaty = Floaty()
    
    var statusBarStyle: UIStatusBarStyle = .default
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return statusBarStyle
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // self.loadingMapView(maptype:.normal)
        layoutFAB()
        searchButton.tintColor = GMColor.cyan100Color()
        searchButton.title = "Pesquisar"
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        
        let camera = GMSCameraPosition.camera(withLatitude: -3.730688,
                                              longitude: -38.495810,
                                              zoom: 5)
        
        mapView.camera=camera
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.isIndoorEnabled = false
        delay(seconds: 1) { () -> () in
            let zoomOut = GMSCameraUpdate.zoom(to: 15)
            self.mapView.animate(with: zoomOut)
        }
        
        marker.position = camera.target
        marker.snippet = "Hello World"
        marker.appearAnimation = .pop
        marker.icon = GMSMarker.markerImage(with: UIColor.cyan)
        marker.map = mapView
        addressLabel.layer.backgroundColor = GMColor.cyan100Color().cgColor
        addressLabel.layer.borderColor = GMColor.cyan700Color().cgColor
        addressLabel.layer.borderWidth = 3.0
        addressLabel.layer.masksToBounds = true
        addressLabel.layer.cornerRadius = 5
        mapView.addSubview(addressLabel)
        mapView.bringSubview(toFront: addressLabel)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //        self.mapView = GMSMapView(frame: self.googleMapsContainer.frame)
        //        self.view.addSubview(self.mapView)
        // self.addressLabel.text = "test text"
        
        searchResultController = SearchMapResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
        // self.addressLabel.text = self.addressString
    }
    
    
    @IBAction func endEditing() {
        view.endEditing(true)
    }
    
    @IBAction func customImageSwitched(_ sender: UISwitch) {
        if sender.isOn == true {
            floaty.buttonImage = UIImage(named: "custom-add")
        } else {
            floaty.buttonImage = nil
        }
    }
    
    func layoutFAB() {
        let item = FloatyItem()
        item.hasShadow = false
        item.buttonColor = UIColor.blue
        item.circleShadowColor = UIColor.red
        item.titleShadowColor = UIColor.blue
        item.titleLabelPosition = .right
        item.title = "titlePosition right"
        item.handler = { item in
            
        }
        
        floaty.hasShadow = false
        floaty.addItem(title: "I got a title")
        floaty.addItem("I got a icon", icon: UIImage(named: "icShare"))
        floaty.addItem("I got a handler", icon: UIImage(named: "icMap")) { item in
            let alert = UIAlertController(title: "Hey", message: "I'm hungry...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Me too", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        floaty.addItem(item: item)
        //floaty.paddingX = self.view.frame.width/2 - floaty.frame.width/2
        floaty.fabDelegate = self
        
        self.view.addSubview(floaty)
        
    }
    
    // MARK: - Floaty Delegate Methods
    func floatyWillOpen(_ floaty: Floaty) {
        print("Floaty Will Open")
    }
    
    func floatyDidOpen(_ floaty: Floaty) {
        print("Floaty Did Open")
    }
    
    func floatyWillClose(_ floaty: Floaty) {
        print("Floaty Will Close")
    }
    
    func floatyDidClose(_ floaty: Floaty) {
        print("Floaty Did Close")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.addressLabel.text = self.addressString
    }
    /**
     action for search location by address
     
     - parameter sender: button search location
     */
    @IBAction func searchWithAddress(_ sender: AnyObject) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchBar.delegate = self
        
        
        
        self.present(searchController, animated:true, completion: nil)
        
        
    }
    
    /**
     Locate map with longitude and longitude after search location on UISearchBar
     
     - parameter lon:   longitude location
     - parameter lat:   latitude location
     - parameter title: title of address location
     */
    func locateWithLongitude(_ lon:Double, andLatitude lat:Double, andTitle title: String)
    {
        
        
        
        DispatchQueue.main.async { () -> Void in
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.mapView.camera = camera
            marker.icon = UIImage(named: "MarkerImage")
            marker.title = "Address : \(title)"
            marker.map = self.mapView
            
        }
        
    }
    
    /**
     Searchbar when text change
     
     - parameter searchBar:  searchbar UI
     - parameter searchText: searchtext description
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        let placeClient = GMSPlacesClient()
        //
        //
        //        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in
        //           // NSError myerr = Error;
        //            print("Error @%",Error.self)
        //
        //            self.resultsArray.removeAll()
        //            if results == nil {
        //                return
        //            }
        //
        //            for result in results! {
        //                if let result = result as? GMSAutocompletePrediction {
        //                    self.resultsArray.append(result.attributedFullText.string)
        //                }
        //            }
        //
        //            self.searchResultController.reloadDataWithArray(self.resultsArray)
        //
        //        }
        
        
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
        
        
    }
    
    
    
    
    func delay(seconds: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            closure()
        }
    }
    
    
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let location = CLLocationCoordinate2D(latitude: position.target.latitude, longitude: position.target.longitude)
        marker.position = location
        marker.map = mapView
        reverseGeocodeCoordinate(coordinate: position.target)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //    override func loadView() {
    ////        let panoramaNear = CLLocationCoordinate2D(latitude: 50.059139, longitude: -122.958391)
    ////
    ////        let panoView = GMSPanoramaView.panorama(withFrame: .zero,
    ////                                                nearCoordinate: panoramaNear)
    ////
    ////        view = panoView;
    //    }
    
    
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        // 3
        if status == .authorizedWhenInUse {
            
            // 4
            locationManager.startUpdatingLocation()
            
            //5
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    // 6
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            
            // 7
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            // 8
            locationManager.stopUpdatingLocation()
        }
        
    }
    
    func reverseGeocodeCoordinate(coordinate: CLLocationCoordinate2D) {
        
        
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            
            if let response = response {
                let  address = response.firstResult()
                
                if  let lines = address?.lines{
                    DispatchQueue.main.async {
                        self.addressLabel.text=lines.joined(separator: "\n")
                    }
                }
                
            }
            
            // 4
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func loadingMapView(maptype:GMSMapViewType)  {
        navigationItem.title = "Hello Map"
        
        
        let camera = GMSCameraPosition.camera(withLatitude: -3.730688,
                                              longitude: -38.495810,
                                              zoom: 8.0)
        
        mapView.camera=camera
        mapView.settings.myLocationButton = true
        mapView.mapType=maptype
        let marker = GMSMarker()
        marker.position = camera.target
        marker.snippet = "Hello World"
        marker.appearAnimation = .pop
        marker.icon = GMSMarker.markerImage(with: UIColor.blue)
        marker.map = mapView
        
        view = mapView
    }
    @IBAction func changeModesButtonClicked(_ sender:UIBarButtonItem) {
        // Create the AlertController and add its actions like button in ActionSheet
        let actionSheetController = UIAlertController(title: "Please select", message: "Option to select", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let normalActionButton = UIAlertAction(title: "Normal", style: .default) { action -> Void in
            //self.loadingMapView(maptype:.normal)
            self.mapView.mapType = .normal
            print("Normal")
        }
        actionSheetController.addAction(normalActionButton)
        
        let terrainActionButton = UIAlertAction(title: "Terrain", style: .default) { action -> Void in
            self.mapView.mapType = .terrain
            //self.loadingMapView(maptype:.terrain)
            print("Terrain")
        }
        actionSheetController.addAction(terrainActionButton)
        let hybridActionButton = UIAlertAction(title: "Hybrid", style: .default) { action -> Void in
            self.mapView.mapType = .hybrid
            //   self.loadingMapView(maptype:.hybrid)
            print("Hybrid")
        }
        actionSheetController.addAction(hybridActionButton)
        
        let satelliteActionButton = UIAlertAction(title: "Satellite", style: .default) { action -> Void in
            self.mapView.mapType = .satellite
            //  self.loadingMapView(maptype:.satellite)
            
            print("satellite")
        }
        actionSheetController.addAction(satelliteActionButton)
        let noneActionButton = UIAlertAction(title: "None", style: .default) { action -> Void in
            self.mapView.mapType = .none
            //  self.loadingMapView(maptype:.none)
            print("none")
        }
        actionSheetController.addAction(noneActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    @IBAction func optionsButtonClicked(_ sender: UIBarButtonItem) {
        // Create the AlertController and add its actions like button in ActionSheet
        let actionSheetController = UIAlertController(title: "Please select", message: "Option to select", preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            print("Cancel")
        }
        actionSheetController.addAction(cancelActionButton)
        
        let stylingActionButton = UIAlertAction(title: "Styling", style: .default) { action -> Void in
            self.stylingSelected()
            print("Styling")
        }
        actionSheetController.addAction(stylingActionButton)
        
        let streetViewActionButton = UIAlertAction(title: "StreetView", style: .default) { action -> Void in
            self.streeViewSelected()
            print("streetView")
        }
        actionSheetController.addAction(streetViewActionButton)
        let polylinesActionButton = UIAlertAction(title: "Polylines", style: .default) { action -> Void in
            self.polyLinesSelected()
            print("Polylines")
        }
        actionSheetController.addAction(polylinesActionButton)
        
        let cameraActionButton = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            self.cameraSelected()
            print("Camera")
        }
        actionSheetController.addAction(cameraActionButton)
        let indoorActionButton = UIAlertAction(title: "Indoor", style: .default) { action -> Void in
            self.indoorSelected()
            print("Indoor")
        }
        actionSheetController.addAction(indoorActionButton)
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    //MARK: styling
    func stylingSelected() {
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("The style definition could not be loaded: \(error)")
        }
    }
    //MARK: streeView
    func streeViewSelected(){
        let panoramaNear = CLLocationCoordinate2D(latitude: 50.059139, longitude: -122.958391)
        
        let panoView = GMSPanoramaView.panorama(withFrame: .zero,
                                                nearCoordinate: panoramaNear)
        
        view = panoView;
    }
    //MARK: polylines
    func polyLinesSelected() {
        //        let camera = GMSCameraPosition.camera(withLatitude: 0,
        //                                              longitude: -165,
        //                                              zoom: 2)
        //        mapView.camera=camera
        let path = GMSMutablePath()
        path.addLatitude(-33.866, longitude:151.195) // Sydney
        path.addLatitude(-18.142, longitude:178.431) // Fiji
        path.addLatitude(21.291, longitude:-157.821) // Hawaii
        path.addLatitude(37.423, longitude:-122.091) // Mountain View
        
        let polyline = GMSPolyline(path: path)
        polyline.strokeColor = .red
        polyline.strokeWidth = 5.0
        polyline.map = mapView
        
        view = mapView
    }
    
    func cameraSelected(){
        let camera = GMSCameraPosition.camera(withLatitude: -37.809487,
                                              longitude: 144.965699,
                                              zoom: 17.5,
                                              bearing: 30,
                                              viewingAngle: 40)
        
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        view = mapView
    }
    func indoorSelected()
    {
        let camera = GMSCameraPosition.camera(withLatitude: 37.78318,
                                              longitude: -122.40374,
                                              zoom: 18)
        
        let mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        view = mapView
    }
}



