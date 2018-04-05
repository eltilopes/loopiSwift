//
//  GoogleDirectionsResponse.swift
//  Loopi
//
//  Created by Loopi on 12/03/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import Foundation

class GoogleDirectionsResponse : NSObject {
    var rawJson: String
    var routes : [Route]
    
    override init() {
    }
    
    func getDuration() -> String{
        ensureNotRaw();
        return routes.isEmpty() ? "1 min" : routes.get(0).legs.get(0).duration.text;
    }
    
    func getDistance()-> String{
        ensureNotRaw();
        if(routes.isEmpty()){
            return "Alguns metros";
        }
        var bairro :String = getBairro(routes.get(0).legs.get(0).end_address);
        var distancia :String = routes.get(0).legs.get(0).distance.text;
        return bairro+ " - " + distancia;
    }
    
    func getDistanceMeters() -> Int{
        ensureNotRaw();
        return routes.isEmpty() ? 0 : routes.get(0).legs.get(0).distance.value;
    }
    
    func getBairro( endereco :String) -> String{
        var enderecos : [String] = endereco.split(",");
        endereco = enderecos[1].substring(enderecos[1].lastIndexOf("-")+1,enderecos[1].length()).trim();
        return  endereco;
    }
    
    func ensureNotRaw() {
        
        if rawJson != nil{
            initFromRawJson()
        }
    }
    
    func   fromRawJson( json:String) -> GoogleDirectionsResponse{
        var result =  GoogleDirectionsResponse();
        result.rawJson = json;
        return result;
    }
    
    // <Parcelable>
    
    @Override
    public int describeContents() {
        return 0;
    }
    
    @Override
    public void writeToParcel(Parcel out, int flags) {
        if (rawJson == null) {
            throw new UnsupportedOperationException("Can't parcel object because raw json form is not available");
        }
        out.writeString(rawJson);
    }
    
    public static final Parcelable.Creator<GoogleDirectionsResponse> CREATOR = new Parcelable.Creator<GoogleDirectionsResponse>() {
        public GoogleDirectionsResponse createFromParcel(Parcel in) {
            return new GoogleDirectionsResponse(in);
        }
        
        public GoogleDirectionsResponse[] newArray(int size) {
            return new GoogleDirectionsResponse[size];
        }
    };
    
    private GoogleDirectionsResponse(Parcel in) {
        rawJson = in.readString();
        initFromRawJson();
    }
    
    private void initFromRawJson() {
        Gson gson = new Gson();
        GoogleDirectionsResponse aux = gson.fromJson(rawJson, GoogleDirectionsResponse.class);
        routes = aux.routes;
        rawJson = null;
    }
    
    // </Parcelable>
}
