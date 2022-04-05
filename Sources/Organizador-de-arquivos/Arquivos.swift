//
//  main.swift
//  Aprendendo swift
//
//  Created by Cicero Nascimento on 22/03/22.
//

import Foundation

  
@available(macOS 10.12, *)


class Arquivos{
    

//  home          -> Definindo diretorio base da aplicaçao (dizendo que o diretorio inicial será /Users/usuario-atual)
//  listagemFiles -> Variavel array do tipo URL
    
    let home = FileManager.default.homeDirectoryForCurrentUser
    var listagemFiles: [URL] = []
    var filePath: String = "file:///Users/ciceronascimento/"
    var fileUrl: URL = URL(string: "file:///Users/ciceronascimento/")!
    
    var diretorioImagem: String = "default"
    var diretorioMusica: String = "default"
    var diretorioDocs: String = "default"
    var diretorioExec: String = "default"
    
    
//dicionario de tipos
    var listagemTipos = [
        "Imagem": [".jpg", ".gif", "jpeg", ".png"],
        "Audio": [".mp3", ".flac"],
        "Documentos": [".txt", ".pdf", ".doc", ".xlsx"],
        "Code": [".sql", ".feature", ".js", ".md", ".json"],
        "Executaveis": [".zip", ".dmg", ".7z", ".rar"]
    ]
    
    func permissao(){
        print("""
* Obs: O Organizador-de-arquivos precisará de permissão aos seus diretórios para criar/ler/mover alguns arquivos
Serão criados os seguintes repositorios caso não se encontrem em seu sistema:

     \u{2794}    Organizer - imagens
     \u{2794}    Organizer - audios
     \u{2794}    Organizer - documentos
     \u{2794}    Organizer - executaveis


""")
        sleep(3)
    }
    
    func localizar(escolha: String){
        
        do {
            
//  filePath -> Caminho escolhido
//  fileUrl  -> Concatenando diretorio base com o caminho escolhido
            
            filePath = escolha + "/"
            fileUrl = home.appendingPathComponent(filePath)
            let diretorioStr = String(fileUrl.path)
            
            visualizarDiretorio(diretorio: diretorioStr)

            let conteudo = try FileManager.default.contentsOfDirectory(
                at: fileUrl,
                includingPropertiesForKeys: nil
            )

            listagemFiles = conteudo
            
        } catch {
            
            print(Error.self)
            
        }
    }
    
    func visualizarDiretorio(diretorio: String){
        if diretorio.hasSuffix("Downloads"){
            print("\nDiretório escolhido: Downloads")
            print("Caminho: ", diretorio)
            print("\n")
            
        } else if diretorio.hasSuffix("Documents"){
            print("\nDiretório escolhido: Documentos")
            print("Caminho: ", diretorio)
            print("\n")
        }
    }
    
    func visualizarConteudo(){
        print("\nListando arquivos e pastas", terminator: "")
        sleep(1)
        print(".", terminator: "")
        sleep(1)
        print(".", terminator: "")
        sleep(1)
        print(".")
        sleep(1)
        print("\n  ================ARQUIVOS===================\n")
        for file in listagemFiles{
            print(" |", "\u{2794} ",  (file.path as NSString).lastPathComponent)
        }
    }
    
    func criarPastas(){
        
        let pastaImagem = fileUrl.appendingPathComponent("Organizer - Imagens")
        let pastaAudio = fileUrl.appendingPathComponent("Organizer - Audios")
        let pastaDocumento = fileUrl.appendingPathComponent("Organizer - Documentos")
        let pastaExecutaveis = fileUrl.appendingPathComponent("Organizer - Executaveis")
        
        diretorioImagem = pastaImagem.path
        diretorioDocs = pastaDocumento.path
        diretorioMusica = pastaAudio.path
        diretorioExec = pastaExecutaveis.path
        
        if !FileManager.default.fileExists(atPath: pastaImagem.path) || !FileManager.default.fileExists(atPath: pastaAudio.path) || !FileManager.default.fileExists(atPath: pastaDocumento.path) || !FileManager.default.fileExists(atPath: pastaExecutaveis.path){
            do {
                
                let result = Result { try FileManager.default.createDirectory(atPath: pastaImagem.path, withIntermediateDirectories: true, attributes: nil) }
                 
                let result2 = Result { try FileManager.default.createDirectory(atPath: pastaAudio.path, withIntermediateDirectories: true, attributes: nil) }

                let result3 = Result { try FileManager.default.createDirectory(atPath: pastaDocumento.path, withIntermediateDirectories: true, attributes: nil) }
                
                let result4 = Result { try FileManager.default.createDirectory(atPath: pastaExecutaveis.path, withIntermediateDirectories: true, attributes: nil) }
                
                
//                switch (result, result2, result3, result4){
//                case .success:
//                    print("sucesso")
//                    arquivos.visualizarConteudo()
//                case .failure:
//                    print("deu ruim")
//                }
//            
                print(result)
                sleep(2)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Nenhuma pasta foi criada. :)")
            sleep(2)
        }
            
    }
    
    func separarArquivos(){
        
        var fileStr: String
        do {
            
            for file in listagemFiles{
                fileStr = String(file.path)
                for (tipo, extensao) in listagemTipos {
                    if tipo == "Audio"{
                        for extensoes in extensao{
                                if fileStr.hasSuffix(extensoes){
                                    print("Movendo:", (file.path as NSString).lastPathComponent , "para a pasta: Organizer - Audios")
                                    let nameFile = (file.path as NSString).lastPathComponent
                                    let fileDest = diretorioMusica + "/" + nameFile
                                    try FileManager.default.moveItem(atPath: file.path, toPath: fileDest)
                                }
                        }
                    } else if tipo == "Imagem"{
                        for extensoes in extensao{
                                if fileStr.hasSuffix(extensoes){
                                    print("Movendo:", (file.path as NSString).lastPathComponent , "para a pasta: Organizer - Imagens")
                                    let nameFile = (file.path as NSString).lastPathComponent
                                    let fileDest = diretorioImagem + "/" + nameFile
                                    try FileManager.default.moveItem(atPath: file.path, toPath: fileDest)
                                }
                        }
                    } else if tipo == "Documentos" || tipo == "Code"{
                        for extensoes in extensao{
                                if fileStr.hasSuffix(extensoes){
                                    print("Movendo:", (file.path as NSString).lastPathComponent , "para a pasta: Organizer - Documentos")
                                    let nameFile = (file.path as NSString).lastPathComponent
                                    let fileDest = diretorioDocs + "/" + nameFile
                                    try FileManager.default.moveItem(atPath: file.path, toPath: fileDest)
                                }
                        }
                    } else if tipo == "Executaveis"{
                        for extensoes in extensao{
                            if fileStr.hasSuffix(extensoes){
                                print("Movendo:", (file.path as NSString).lastPathComponent , "para a pasta: Organizer - Executaveis")
                                let nameFile = (file.path as NSString).lastPathComponent
                                let fileDest = diretorioExec + "/" + nameFile
                                try FileManager.default.moveItem(atPath: file.path, toPath: fileDest)
                            }
                        }
                    }
                }
            }
            
        } catch {
            print(error)
        }

    }
}
        
        
//        func mover(file: URL){
//            do {
//                print("Movendo:", file.path , "para: ", diretorioExec)
//                let nameFile = (file.path as NSString).lastPathComponent
//                let fileDest = diretorioExec + "/" + nameFile
//                try FileManager.default.moveItem(atPath: file.path, toPath: fileDest)
//
//            } catch {
//                print(error)
//            }
//        }
 
        
        
// ============== percorrer listagemTipos e mostrar tipos suportados
//        for (tipo, extensao) in listagemTipos {
//            print("Tipo: ", tipo)
//            print("Extensões suportadas: ", terminator: "")
//            for extensoes in extensao {
//                print( extensoes, terminator: " ")
//            }
//            print("\n")
//        }

