//
//  IRSocketReader.swift
//  RASUSLabos
//
//  Created by Rep on 12/15/15.
//  Copyright © 2015 Rep. All rights reserved.
//

import Foundation

class IRSocketReader{
    
    let socket: Socket
    
    init(socket:Socket){
        
        self.socket = socket
        
    }
    
    func read(observerFunc: (Array<UInt8>, IRSockaddr) -> Void){

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            repeat{
                let (data, addr) = self.socket.reciveAndStoreAddres()
                
                observerFunc(data, addr)
            }while(true)
        })
        
    }
    
}