//
//  FilmeViewController.swift
//  DesafioSky
//
//  Created by Bruna Fernanda Drago on 24/06/20.
//  Copyright © 2020 Bruna Fernanda Drago. All rights reserved.
//

import UIKit

class FilmeViewController: UIViewController {
    
    @IBOutlet weak var filmeCollectionView: UICollectionView!
    
    var filmes = [Filme]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Chamando o método para fazer a Call na API
        getData()
        
        //Atribuindo delegate e datasource
        filmeCollectionView.delegate = self
        filmeCollectionView.dataSource = self
    }
    func getData(){
        //Fazendo o PARSE dos dados da API
       
        let urlJsonString = "https://sky-exercise.herokuapp.com/api/Movies"
        
        guard let url = URL(string: urlJsonString) else{
           DispatchQueue.main.async {
                self.showAlert()
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                DispatchQueue.main.async {
                    self.showAlert()
                }
                return
                
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.filmes =  try decoder.decode([Filme].self, from: data)
                
                print(self.filmes)
                
            }catch let jsonErr{
                DispatchQueue.main.async {
                    self.showAlert()
                }
                print("Error : \(jsonErr)")
            }
            DispatchQueue.main.async {
                print(self.filmes.count)
                self.filmeCollectionView.reloadData()
            }
            
        }.resume()
        
    }
    
    //MARK:- Criando um Alerta
    func showAlert(){
        
        let alerta = UIAlertController(title: "Atenção", message: "Falha ao carregar os dados,tente mais tarde!", preferredStyle: .alert)
        
        //Adicionando Botões
        let acaoOk = UIAlertAction(title: "Ok", style: .destructive) { (action) in
            
            print("Apertou o Ok")
        }
        
        alerta.addAction(acaoOk)
        
        //Apresentando o alerta
        self.present(alerta, animated: true) {
            
            print("Apresentou o alerta")
        }
    }
}

extension FilmeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = filmeCollectionView.dequeueReusableCell(withReuseIdentifier: "filmeCV", for: indexPath)as! FilmeCollectionViewCell
        
        cell.tituloFilmeLabel.text = filmes[indexPath.row].title
        
        //Fazendo o download e setUp da imagem
        cell.capaImageView.layer.cornerRadius = 10
        cell.capaImageView.clipsToBounds = true
        let urlImg = filmes[indexPath.row].coverUrl
        print(urlImg)
        cell.capaImageView.downloaded(from: urlImg)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filme = filmes[indexPath.row]
        performSegue(withIdentifier: "goToFilmeInfo", sender: filme)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? FilmeInfoViewController {
            destination.filme = sender as? Filme
        }
    }
    
}
//MARK:-Extension para tratar o download da imagem
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
