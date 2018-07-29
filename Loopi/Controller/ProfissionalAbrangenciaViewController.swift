//
//  ProfissionalAbrangenciaViewController.swift
//  Loopi
//
//  Created by Loopi on 19/07/18.
//  Copyright © 2018 Loopi. All rights reserved.
//

import UIKit

class ProfissionalAbrangenciaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let heightHeader : CGFloat = 60.0
    let margin: CGFloat = 5
    let sizeImage = 20
    let sizeUIImage = 30
    @IBOutlet var tblProfissionalBairros : UITableView!
    @IBOutlet var labelProfissionalBairros : UILabel!
    @IBOutlet var buttonConfirmar: UIButton!
    var bairros: [Bairro] = []
    var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBairros()
        addButtonConfirmar()
        self.labelProfissionalBairros.backgroundColor = GMColor.backgroundAppColor()
        self.labelProfissionalBairros.textColor = GMColor.textColorPrimary()
        self.labelProfissionalBairros.font = UIFont.boldSystemFont(ofSize: ConstraintsView.fontBig())
        self.view.backgroundColor = GMColor.backgroundAppColor()
        self.tblProfissionalBairros.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        self.tblProfissionalBairros.layer.masksToBounds = true
        self.tblProfissionalBairros.separatorStyle = .none
        self.tblProfissionalBairros.backgroundColor = GMColor.backgroundAppColor()
        self.tblProfissionalBairros.delegate = self
        self.tblProfissionalBairros.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addButtonConfirmar() {
        
        buttonConfirmar.titleLabel?.text = "Confirmar"
        buttonConfirmar.layer.cornerRadius = ConstraintsView.cornerRadiusApp()
        buttonConfirmar.layer.masksToBounds = true
        buttonConfirmar.tintColor = GMColor.whiteColor()
        buttonConfirmar.titleLabel!.textAlignment = .center
        buttonConfirmar.titleLabel?.lineBreakMode = .byWordWrapping
        buttonConfirmar.setTitleColor(GMColor.whiteColor(), for: .normal)
        buttonConfirmar.translatesAutoresizingMaskIntoConstraints = false
        buttonConfirmar.backgroundColor = GMColor.colorPrimary()
        
    }
    
    
    func updateBairros(){
        bairros.append(Bairro( id :    1    , nome :  "Acaracuzinho"))
        bairros.append(Bairro( id :    2    , nome :  "Aerolândia"))
        bairros.append(Bairro( id :    3    , nome :  "Aeroporto"))
        bairros.append(Bairro( id :    4    , nome :  "Água Fria"))
        bairros.append(Bairro( id :    5    , nome :  "Alagadiço"))
        bairros.append(Bairro( id :    6    , nome :  "Aldeota"))
        bairros.append(Bairro( id :    7    , nome :  "Alto Alegre"))
        bairros.append(Bairro( id :    8    , nome :  "Alto da Balança"))
        bairros.append(Bairro( id :    9    , nome :  "Álvaro Weyne"))
        bairros.append(Bairro( id :    10    , nome :  "Amadeu Furtado"))
        bairros.append(Bairro( id :    11    , nome :  "Ancuri"))
        bairros.append(Bairro( id :    12    , nome :  "Antônio Bezerra"))
        bairros.append(Bairro( id :    13    , nome :  "Antônio Diogo"))
        bairros.append(Bairro( id :    14    , nome :  "Araturi"))
        bairros.append(Bairro( id :    15    , nome :  "Arenópolis"))
        bairros.append(Bairro( id :    16    , nome :  "Autran Nunes"))
        bairros.append(Bairro( id :    17    , nome :  "Barra do Ceará"))
        bairros.append(Bairro( id :    18    , nome :  "Barroso"))
        bairros.append(Bairro( id :    19    , nome :  "Bela Vista"))
        bairros.append(Bairro( id :    20    , nome :  "Benfica"))
        bairros.append(Bairro( id :    21    , nome :  "Boa Vista"))
        bairros.append(Bairro( id :    22    , nome :  "Boa Vista Castelão"))
        bairros.append(Bairro( id :    23    , nome :  "Bom Futuro"))
        bairros.append(Bairro( id :    24    , nome :  "Bom Jardim"))
        bairros.append(Bairro( id :    25    , nome :  "Bonsucesso"))
        bairros.append(Bairro( id :    26    , nome :  "Cais do Porto"))
        bairros.append(Bairro( id :    27    , nome :  "Cajazeiras"))
        bairros.append(Bairro( id :    28    , nome :  "Cambeba"))
        bairros.append(Bairro( id :    29    , nome :  "Canindezinho"))
        bairros.append(Bairro( id :    30    , nome :  "Canto Verde"))
        bairros.append(Bairro( id :    31    , nome :  "Carlito Maia"))
        bairros.append(Bairro( id :    32    , nome :  "Carlito Pamplona"))
        bairros.append(Bairro( id :    33    , nome :  "Casa Porto"))
        bairros.append(Bairro( id :    34    , nome :  "Castelão"))
        bairros.append(Bairro( id :    35    , nome :  "Castelo Encantado"))
        bairros.append(Bairro( id :    36    , nome :  "Centro"))
        bairros.append(Bairro( id :    37    , nome :  "Cidade 2000"))
        bairros.append(Bairro( id :    38    , nome :  "Cidade dos Funcionários"))
        bairros.append(Bairro( id :    39    , nome :  "Coaçu"))
        bairros.append(Bairro( id :    40    , nome :  "Coco"))
        bairros.append(Bairro( id :    41    , nome :  "Conjunto Ceará"))
        bairros.append(Bairro( id :    42    , nome :  "Conjunto Esperança"))
        bairros.append(Bairro( id :    43    , nome :  "Conjunto Habitacional Aeronáutica"))
        bairros.append(Bairro( id :    44    , nome :  "Conjunto Nova Assunção"))
        bairros.append(Bairro( id :    45    , nome :  "Conjunto Nova Perimetral"))
        bairros.append(Bairro( id :    46    , nome :  "Conjunto Novo Oriente"))
        bairros.append(Bairro( id :    47    , nome :  "Conjunto Palmeiras"))
        bairros.append(Bairro( id :    48    , nome :  "Conjunto Parque Ipiranga"))
        bairros.append(Bairro( id :    49    , nome :  "Conjunto Planalto Pici"))
        bairros.append(Bairro( id :    50    , nome :  "Conjunto Prefeito José Walter"))
        bairros.append(Bairro( id :    51    , nome :  "Conjunto Residencial Sítio São João"))
        bairros.append(Bairro( id :    52    , nome :  "Conjunto Santa Maria"))
        bairros.append(Bairro( id :    53    , nome :  "Conjunto Sol Poente"))
        bairros.append(Bairro( id :    54    , nome :  "Conjunto Vila Velha Iv"))
        bairros.append(Bairro( id :    55    , nome :  "Couto Fernandes"))
        bairros.append(Bairro( id :    56    , nome :  "Cristo Redentor"))
        bairros.append(Bairro( id :    57    , nome :  "Curió"))
        bairros.append(Bairro( id :    58    , nome :  "Damas"))
        bairros.append(Bairro( id :    59    , nome :  "Demócrito Rocha"))
        bairros.append(Bairro( id :    60    , nome :  "Dendê"))
        bairros.append(Bairro( id :    61    , nome :  "Dias Macedo"))
        bairros.append(Bairro( id :    62    , nome :  "Dionísio Torres"))
        bairros.append(Bairro( id :    63    , nome :  "Distrito Industrial"))
        bairros.append(Bairro( id :    64    , nome :  "Distrito Industrial I"))
        bairros.append(Bairro( id :    65    , nome :  "Distrito Industrial III"))
        bairros.append(Bairro( id :    66    , nome :  "Dom Lustosa"))
        bairros.append(Bairro( id :    67    , nome :  "Dunas"))
        bairros.append(Bairro( id :    68    , nome :  "Edson Queiroz"))
        bairros.append(Bairro( id :    69    , nome :  "Engenheiro Luciano Cavalcante"))
        bairros.append(Bairro( id :    70    , nome :  "Farias Brito"))
        bairros.append(Bairro( id :    71    , nome :  "Fátima"))
        bairros.append(Bairro( id :    72    , nome :  "Floresta"))
        bairros.append(Bairro( id :    73    , nome :  "Granja Lisboa"))
        bairros.append(Bairro( id :    74    , nome :  "Granja Portugal"))
        bairros.append(Bairro( id :    75    , nome :  "Guajiru"))
        bairros.append(Bairro( id :    76    , nome :  "Guaramiranga"))
        bairros.append(Bairro( id :    77    , nome :  "Guararapes"))
        bairros.append(Bairro( id :    78    , nome :  "Henrique Jorge"))
        bairros.append(Bairro( id :    79    , nome :  "Industrial"))
        bairros.append(Bairro( id :    80    , nome :  "Itaóca"))
        bairros.append(Bairro( id :    81    , nome :  "Itaperi"))
        bairros.append(Bairro( id :    82    , nome :  "Jaboti"))
        bairros.append(Bairro( id :    83    , nome :  "Jacarecanga"))
        bairros.append(Bairro( id :    84    , nome :  "Jangurussu"))
        bairros.append(Bairro( id :    85    , nome :  "Jardim América"))
        bairros.append(Bairro( id :    86    , nome :  "Jardim Cearense"))
        bairros.append(Bairro( id :    87    , nome :  "Jardim das Oliveiras"))
        bairros.append(Bairro( id :    88    , nome :  "Jardim Guanabara"))
        bairros.append(Bairro( id :    89    , nome :  "Jardim Iracema"))
        bairros.append(Bairro( id :    90    , nome :  "Jardim Jatobá"))
        bairros.append(Bairro( id :    91    , nome :  "João Xxiii"))
        bairros.append(Bairro( id :    92    , nome :  "Joaquim Távora"))
        bairros.append(Bairro( id :    93    , nome :  "Jóquei Clube"))
        bairros.append(Bairro( id :    94    , nome :  "José Bonifácio"))
        bairros.append(Bairro( id :    95    , nome :  "José de Alencar"))
        bairros.append(Bairro( id :    96    , nome :  "Lago Verde"))
        bairros.append(Bairro( id :    97    , nome :  "Lagoa Redonda"))
        bairros.append(Bairro( id :    98    , nome :  "Loteamento Alfha Village"))
        bairros.append(Bairro( id :    99    , nome :  "Loteamento Araturi"))
        bairros.append(Bairro( id :    100    , nome :  "Loteamento Esplanada Castelão"))
        bairros.append(Bairro( id :    101    , nome :  "Loteamento Esplanada Messejana"))
        bairros.append(Bairro( id :    102    , nome :  "Loteamento Grande Aldeota"))
        bairros.append(Bairro( id :    103    , nome :  "Loteamento Jardim Bandeirantes"))
        bairros.append(Bairro( id :    104    , nome :  "Loteamento Jurema Park"))
        bairros.append(Bairro( id :    105    , nome :  "Loteamento Parque Dom Pedro"))
        bairros.append(Bairro( id :    106    , nome :  "Loteamento Parque Elisabeth"))
        bairros.append(Bairro( id :    107    , nome :  "Loteamento Parque Montenegro"))
        bairros.append(Bairro( id :    108    , nome :  "Loteamento Planalto João Xxiii"))
        bairros.append(Bairro( id :    109    , nome :  "Loteamento Planalto Mondubim"))
        bairros.append(Bairro( id :    110    , nome :  "Loteamento Sítio Santa Sofia"))
        bairros.append(Bairro( id :    114    , nome :  "Manoel Dias Branco"))
        bairros.append(Bairro( id :    115    , nome :  "Manuel Satiro"))
        bairros.append(Bairro( id :    116    , nome :  "Maraponga"))
        bairros.append(Bairro( id :    117    , nome :  "Meireles"))
        bairros.append(Bairro( id :    118    , nome :  "Messejana"))
        bairros.append(Bairro( id :    119    , nome :  "Mondubim"))
        bairros.append(Bairro( id :    120    , nome :  "Monte Castelo"))
        bairros.append(Bairro( id :    121    , nome :  "Montese"))
        bairros.append(Bairro( id :    122    , nome :  "Moura Brasil"))
        bairros.append(Bairro( id :    123    , nome :  "Mucuripe"))
        bairros.append(Bairro( id :    124    , nome :  "Nova Metrópole - Jurema"))
        bairros.append(Bairro( id :    125    , nome :  "Novo Mondubim"))
        bairros.append(Bairro( id :    126    , nome :  "Olavo Oliveira"))
        bairros.append(Bairro( id :    127    , nome :  "Padre Andrade"))
        bairros.append(Bairro( id :    128    , nome :  "Pajuçara"))
        bairros.append(Bairro( id :    129    , nome :  "Pan Americano"))
        bairros.append(Bairro( id :    130    , nome :  "Papicu"))
        bairros.append(Bairro( id :    131    , nome :  "Parangaba"))
        bairros.append(Bairro( id :    132    , nome :  "Parque Alto Alegre"))
        bairros.append(Bairro( id :    133    , nome :  "Parque Araxá"))
        bairros.append(Bairro( id :    134    , nome :  "Parque Dois Irmãos"))
        bairros.append(Bairro( id :    135    , nome :  "Parque Genibau"))
        bairros.append(Bairro( id :    136    , nome :  "Parque Iracema"))
        bairros.append(Bairro( id :    137    , nome :  "Parque Jerusalém"))
        bairros.append(Bairro( id :    138    , nome :  "Parque Manibura"))
        bairros.append(Bairro( id :    139    , nome :  "Parque Novo Mondubim"))
        bairros.append(Bairro( id :    140    , nome :  "Parque Potira"))
        bairros.append(Bairro( id :    141    , nome :  "Parque Presidente Vargas"))
        bairros.append(Bairro( id :    142    , nome :  "Parque Santa Maria"))
        bairros.append(Bairro( id :    143    , nome :  "Parque Santa Rosa"))
        bairros.append(Bairro( id :    144    , nome :  "Parque São José"))
        bairros.append(Bairro( id :    145    , nome :  "Parque São Vicente"))
        bairros.append(Bairro( id :    146    , nome :  "Parquelândia"))
        bairros.append(Bairro( id :    147    , nome :  "Parreão"))
        bairros.append(Bairro( id :    148    , nome :  "Passaré"))
        bairros.append(Bairro( id :    149    , nome :  "Patriolino Ribeiro"))
        bairros.append(Bairro( id :    150    , nome :  "Paupina"))
        bairros.append(Bairro( id :    151    , nome :  "Pedras"))
        bairros.append(Bairro( id :    152    , nome :  "Pici"))
        bairros.append(Bairro( id :    153    , nome :  "Pirambu"))
        bairros.append(Bairro( id :    154    , nome :  "Planalto Ayrton Senna"))
        bairros.append(Bairro( id :    155    , nome :  "Praia de Iracema"))
        bairros.append(Bairro( id :    156    , nome :  "Praia Iracema"))
        bairros.append(Bairro( id :    157    , nome :  "Prefeito José Walter"))
        bairros.append(Bairro( id :    158    , nome :  "Presidente Kennedy"))
        bairros.append(Bairro( id :    159    , nome :  "Presidente Tancredo Neves"))
        bairros.append(Bairro( id :    160    , nome :  "Quintino Cunha"))
        bairros.append(Bairro( id :    161    , nome :  "Rodolfo Teófilo"))
        bairros.append(Bairro( id :    162    , nome :  "Sabiaguaba"))
        bairros.append(Bairro( id :    163    , nome :  "Salinas"))
        bairros.append(Bairro( id :    164    , nome :  "Santa Maria"))
        bairros.append(Bairro( id :    165    , nome :  "Santa Rosa"))
        bairros.append(Bairro( id :    166    , nome :  "São Bento"))
        bairros.append(Bairro( id :    167    , nome :  "São Gerardo"))
        bairros.append(Bairro( id :    168    , nome :  "São João do Tauape"))
        bairros.append(Bairro( id :    169    , nome :  "Sapiranga"))
        bairros.append(Bairro( id :    170    , nome :  "Serrinha"))
        bairros.append(Bairro( id :    171    , nome :  "Siqueira"))
        bairros.append(Bairro( id :    172    , nome :  "Varjota"))
        bairros.append(Bairro( id :    173    , nome :  "Vicente Pinzon"))
        bairros.append(Bairro( id :    174    , nome :  "Vila Ellery"))
        bairros.append(Bairro( id :    175    , nome :  "Vila Peri"))
        bairros.append(Bairro( id :    176    , nome :  "Vila União"))
        bairros.append(Bairro( id :    177    , nome :  "Vila Velha"))
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BairroViewCell", for: indexPath as IndexPath) as! BairroViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        let bairro = self.bairros[indexPath.item]
        cell.nome.text = bairro.nome
        cell.nome.textColor = bairro.selecionado ? GMColor.colorPrimary() : GMColor.textColorPrimary()
        cell.checkImage.image = defaultCheckBoxButtonImage(full: bairro.selecionado)
        cell.frame.size.height = ConstraintsView.heightHeaderApp()
        return cell
    }
    
    
    func defaultCheckBoxButtonImage(full: Bool ) -> UIImage {
        var defaultRadioButtonEmptyImage = UIImage()
        UIGraphicsBeginImageContextWithOptions(CGSize(width: sizeUIImage, height: sizeUIImage), false, 0.0)
        GMColor.colorRadioAndCheckButtonFill().setFill()
        UIBezierPath(rect: CGRect(x: 5, y: 5, width: sizeImage, height: sizeImage)).fill()
        if full {
            GMColor.whiteColor().setFill()
            UIBezierPath(rect: CGRect(x: 10, y: 10, width: 10, height: 10)).fill()
            GMColor.colorPrimary().setFill()
            UIBezierPath(rect: CGRect(x: 11.5, y: 11.5, width: 7, height: 7)).fill()
        }
        
        defaultRadioButtonEmptyImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return defaultRadioButtonEmptyImage;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath.item
        let bairro = self.bairros[indexPath.item]
        bairro.selecionado = true
        self.tblProfissionalBairros.reloadRows(at: [indexPath], with: .left)
    }
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bairros.count
    }
    
    
}

