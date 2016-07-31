//
//  ViewController.swift
//  BUSQUEDALIBRO
//
//  Created by Luis Rodriguez on 23/07/16.
//  Copyright © 2016 Luis Rodriguez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var ISBN: UITextField!
    
    func imprime()->String{
        let IsbnNumber=String(self.ISBN.text!)
        
        return IsbnNumber
    }
    
    func busqueda() {
        let IsbnNumberR = imprime()
        let urls="https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + IsbnNumberR
        let url = NSURL(string: urls)
        let datos: NSData? = NSData(contentsOfURL: url!)
        
        if datos == nil {
            let alert = UIAlertController(title: "Aviso", message: "CONEXION FALLIDA", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
           
        } else {
        
        let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
        
            if texto! == "{}" {
            let alert = UIAlertController(title: "Aviso", message: "NO EXISTE REGISTRO", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
                
                do {
                    
                    var arreglo: [String] = []
                    
                    let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                    let dico1 = json as! NSDictionary
                   let dico2 = dico1["ISBN:"+IsbnNumberR] as! NSDictionary
                    
                    self.titulo.text = dico2["title"] as! NSString as String
                    
                    let autores =  dico2["authors"] as! NSArray
                    for autor in autores
                    {
                        arreglo.append(autor["name"] as! NSString as String)
                    }
                    
                    let arrautor = Autores(arreglo)
                    self.autor.text = arrautor
                  
                    let busqueda = dico2.objectForKey("cover")
                    
                    if busqueda != nil {
                   
                   let dico3 = dico2["cover"] as! NSDictionary
                    let dico4 = dico3["large"] as! NSString as String
                    let cover = NSURL(string: dico4)
                    let coverL:NSData? = NSData(contentsOfURL: cover!)
                    portada.image = UIImage(data: coverL!)
                    } else {
                     portada.image = UIImage(named: "url.png")
                        
                    }
                }
                    
                catch _ {
                    
                }
                
            }}}
    
    func Autores(arreglo: [String]) -> String
    {
        var autores: String = ""
        
        if (arreglo.count == 1){
            
            return arreglo[0]
        }
        else
        {
            autores = arreglo.joinWithSeparator("-")
            return autores
        }
    }
    
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autor: UILabel!
    @IBOutlet weak var portada: UIImageView!

    
    
    @IBAction func ISBN(sender: AnyObject) {
        imprime()
        busqueda()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

