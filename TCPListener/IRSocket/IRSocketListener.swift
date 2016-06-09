//
//  IRSocketListener.swift
//  CUPUS Mobile broker
//
//  Created by Macbook Pro 1 on 06/06/2016.
//  Copyright © 2016 fer. All rights reserved.
//

import Foundation

class IRSocketListener{
    
    let socket:Socket
    
    init(port: UInt16) throws{
        socket = try TCPSocket()
        
        let address = IRSockaddr(port: port)
        
        try socket.bind(address)
        
    }
    
    func startListening(){
        
        do{
            try socket.startListening()
        }catch{
            print("error")
        }
        
    }
    
}