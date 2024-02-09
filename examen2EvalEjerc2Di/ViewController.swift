//
//  ViewController.swift
//  examen2EvalEjerc2Di
//
//  Created by Montacer El Fazazi on 09/02/2024.
//

import UIKit
import FirebaseFirestore
import Toast

class ViewController: UIViewController {

    @IBOutlet weak var txtCafe: UITextField!
    @IBOutlet weak var txtBebida: UITextField!
    @IBOutlet weak var txtBocadillo: UITextField!
    @IBOutlet weak var txtCliente: UITextField!
    
    var db: Firestore!
    var datos: ManagerUserDefaults!
    var cliente = ""
    var bocadillo =  ""
    var bebida = ""
    var cafe = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        datos = ManagerUserDefaults()
        
        cliente = txtCliente.text!
        bocadillo = txtBocadillo.text!
        bebida = txtBebida.text!
        cafe = txtCafe.text!
        
        let bocadillo1 = datos.recuperar(clave: "BOCADILLO")
        let bebida1 = datos.recuperar(clave: "BEBIDA")
        let cafe1 = datos.recuperar(clave: "CAFE")
        
        if bocadillo1 != "" && bebida1 != "" && cafe1 != ""{
            self.view.makeToast("Bocadillo: \(bocadillo1) Bebida: \(bebida1) Cafe: \(cafe1)")
        }

    }
    


    @IBAction func btnCrear(_ sender: Any) {
        cliente = txtCliente.text!
        bocadillo = txtBocadillo.text!
        bebida = txtBebida.text!
        cafe = txtCafe.text!
        
        if cliente != "" && bocadillo != "" && bebida != "" && cafe != ""{
            db.collection("almuerzos").document(cliente).setData(
                ["bocadillo": bocadillo,
                 "bebida": bebida,
                 "cafe": cafe
            ])
            
            datos.guardar(dato: bocadillo, clave: "BOCADILLO")
            datos.guardar(dato: bebida, clave: "BEBIDA")
            datos.guardar(dato: cafe, clave: "CAFE")
            
            borrarCampos()

        }else{
            let alert = UIAlertController(title: "error", message: "rellena todos los datos para crear", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)

        }
    }
    
    
    @IBAction func btnModificar(_ sender: Any) {
        cliente = txtCliente.text!
        bocadillo = txtBocadillo.text!
        bebida = txtBebida.text!
        cafe = txtCafe.text!
        
        if cliente != "" && bocadillo != "" && bebida != "" && cafe != ""{
            db.collection("almuerzos").document(cliente).setData(
                ["bocadillo": bocadillo,
                 "bebida": bebida,
                 "cafe": cafe
            ])
            
            borrarCampos()

        }else{
            let alert = UIAlertController(title: "error", message: "rellena todos los datos para modificar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnEliminar(_ sender: Any) {
        cliente = txtCliente.text!
        
        if cliente != ""{
            db.collection("almuerzos").document(cliente).delete()

        }else{
            let alert = UIAlertController(title: "error", message: "rellena el nombre de cliente para eliminar", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "aceptar", style: .default))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func borrarCampos(){
        txtCliente.text = ""
        txtBocadillo.text = ""
        txtBebida.text = ""
        txtCafe.text = ""
    }
}

