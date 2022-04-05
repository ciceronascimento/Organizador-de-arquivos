//
//  main.swift
//  Aprendendo swift
//
//  Created by Cicero Nascimento on 22/03/22.
//

import Foundation

//Declarando variaveis e instanciando classes
let arquivos = Arquivos()
let download = "Downloads"
let documentos = "Documents"



//Menu principal do programa

var playAgain = true
//Chamando funçoes, fluxo principal

print("\n\nBem vindo ao Organizador de arquivos!")
sleep(2)


repeat{
    
    print("\nDigite o diretorio que voce deseja organizar\n1 - Downloads\n2 - Documentos\n3 - Sair do programa")
    print("Entrada: ", terminator: "")
    let escolha = readLine()!

    let escolhaInt = Int(escolha)
    
    switch escolhaInt{
    case 1:
        arquivos.permissao()
        arquivos.localizar(escolha: download)
        arquivos.criarPastas()
//        arquivos.visualizarConteudo()
        arquivos.separarArquivos()
        sleep(5)
        
    case 2:
        arquivos.permissao()
        arquivos.localizar(escolha: documentos)
        arquivos.criarPastas()
//        arquivos.visualizarConteudo()
        arquivos.separarArquivos()
        sleep(5)
        
    case 3:
        print("Saindo do programa...\n\n")
        playAgain = false
        
    default:
        print("\n\n=======|ATENÇAO|=======\n")
        print("Apenas 1, 2 ou 3 permitidos")
        sleep(3)
//        playAgain = false
    }
} while playAgain

