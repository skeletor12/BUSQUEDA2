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
        let urls="https://openlibrary.org/api/books?jscmd=dat&format=json&bibkeys=ISBN:" + IsbnNumberR
        let url = NSURL(string: urls)
        let datos:NSData? = NSData(contentsOfURL: url!)
        
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
            
            RESULTADO.text=String(texto!)}
        }}
    
    @IBOutlet weak var RESULTADO: UITextView!
    
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

