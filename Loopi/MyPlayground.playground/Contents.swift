//: Playground - noun: a place where people can play

import UIKit
var str = "Hello, playground"


func carregarCards(){
    let dict =   ["distanciaMenor": true,  "menorValor": true,  "minhaLatLng": [    "latitude": -3.76264212,    "longitude": -38.49189353  ],  "ordemAlfabeticaCrescente": true] as [String: Any]
    if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
        
        
        let url = NSURL(string: "http://192.168.2.5:8080/allinoneserver/servico/listar")!
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.timeoutInterval = 10.0
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){ data,response,error in
            if error != nil{
                print(error?.localizedDescription as Any)
                return
            }
            
            do {
                let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                var servico : ServicoCard = ServicoCard()
                if let responseJSON = responseJSON as? [AnyObject] {
                    
                    for sc in responseJSON  {
                        let dir = sc as? [String : AnyObject]
                        var anyDict = [String: AnyObject]()
                        for key in (dir?.keys)! {
                            anyDict.updateValue(dir![key]!, forKey: key)
                        }
                        print(anyDict)
                        var r  = String(describing: sc)
                        print(r)
                        r = "{\n" +
                            "    \"categoria\": {\n" +
                            "      \"descricao\": \"Saúde\",\n" +
                            "      \"id\": 1\n" +
                            "    },\n" +
                            "    \"subCategoria\": {\n" +
                            "      \"categoria\": {\n" +
                            "        \"descricao\": \"Saúde\",\n" +
                            "        \"id\": 1\n" +
                            "      },\n" +
                            "      \"descricao\": \"Médicos\",\n" +
                            "      \"id\": 1\n" +
                            "    },\n" +
                            "    \"estrelas\": 2,\n" +
                            "    \"favorito\": false,\n" +
                            "    \"id\": 3,\n" +
                            "    \"latitude\": -3.75829,\n" +
                            "    \"longitude\": -38.480949,\n" +
                            "    \"thumbnail\": \"http://urologistasanchotene.com.br/wp-content/uploads/2015/02/Foto-Urologista-Elton-Sanchotene.jpg\",\n" +
                            "    \"title\": \"ELTON LOPES\"\n" +
                        "  }\n"
                        print(r)
                        servico = ServicoCard.deserialize(from: r)!
                        print(servico.toJSON()!)
                        servicoCards.append(servico)
                        
                        
                    }
                    print(responseJSON)
                    print(servicoCards.count)
                    
                }else{
                    ActivityIndicator().StopActivityIndicator(obj: self,indicator: indicator);
                }
            }
        }
        task.resume()
    }
}

