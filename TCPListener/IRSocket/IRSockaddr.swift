//
//  IRSockaddr.swift
//  RASUSLabos
//
//  Created by Rep on 12/14/15.
//  Copyright © 2015 Rep. All rights reserved.
//

import Foundation
#if os(Linux)
    import Glibc
#else
    import Darwin.C
#endif

enum SocketAddres: ErrorType{
    case IPCastFailed(message: String)
}

class IRSockaddr{
    
    var cSockaddr:sockaddr_in
    
    
    /**
     Creates IPv4 address with ADDR_ANY
     
     - parameter port: UInt16 port in host format
     - parameter domain: Int32 domain, default AF_INET
    */
    init(port: UInt16 = 0, domain:Int32 = AF_INET){
        cSockaddr = sockaddr_in(
            sin_len:    __uint8_t(sizeof(sockaddr_in)),
            sin_family: sa_family_t(domain),
            sin_port:   htons(port),
            sin_addr:   in_addr(s_addr: UInt32(0x00000000)),
            sin_zero:   ( 0, 0, 0, 0, 0, 0, 0, 0 )
        )
    }
    
    
    /**
     Creates IPv4 address
     
     - parameter ip: UInt32 representation of IP adress in host format
     - parameter port: UInt16 port in host format
     - parameter domain: Int32 domain, default AF_INET
    */
    init(ip: UInt32, port: UInt16 = 0, domain:Int32 = AF_INET){
        cSockaddr = sockaddr_in(
            sin_len:    __uint8_t(sizeof(sockaddr_in)),
            sin_family: sa_family_t(domain),
            sin_port:   htons(port),
            sin_addr:   in_addr(s_addr: ip),
            sin_zero:   ( 0, 0, 0, 0, 0, 0, 0, 0 )
        )
    }
    
    /**
     Creates IPv4 address
     
     - parameter ip: String representation of IP adress
     - parameter port: UInt16 port in host format
     - parameter domain: Int32 domain, default AF_INET
     
     - Throws: 'SocketAddress.IPCastFailed' on invalid string IP representation
     */
    init(ip: String, port: UInt16 = 0, domain:Int32 = AF_INET) throws{
        
        let inAddr = try IRSockaddr.IPv4ToInt(ip)
        
        cSockaddr = sockaddr_in(
            sin_len:    __uint8_t(sizeof(sockaddr_in)),
            sin_family: sa_family_t(domain),
            sin_port:   htons(port),
            sin_addr:   inAddr,
            sin_zero:   ( 0, 0, 0, 0, 0, 0, 0, 0 )
        )
    }
    
    
    /**
     Initializes class with cSocket
     
     - parameter cSocket: sockaddr_in cSocket
    */
    init(cSocket: sockaddr_in){
        cSockaddr = cSocket
    }
    
    
    /**
     Casts UInt32 representation of IP to String
     
     - parameter ip: UInt32 representation of IP
    */
    static func IPv4ToString(ip:UInt32) -> String {
        
        let byte1 = UInt8(ip & 0xff)
        let byte2 = UInt8((ip>>8) & 0xff)
        let byte3 = UInt8((ip>>16) & 0xff)
        let byte4 = UInt8((ip>>24) & 0xff)
        
        return "\(byte1).\(byte2).\(byte3).\(byte4)"
    }
    
    
    /**
     Casts String representation of IP to in_addr
     
     - parameter ip: String representation of IP
     
     - Throws: 'SocketAddress.IPCastFailed' on invalid string IP representation
     */
    static func IPv4ToInt(ip:String) throws -> in_addr {
        var addr:in_addr = in_addr(s_addr: 0)
        
        if inet_aton(ip, &addr) == 0{
            throw SocketAddres.IPCastFailed(message: "Failed to convert given string: \(ip) into integer value")
        }
        
        return addr
    }
  
}