//
//  IRDataTransform.swift
//  RASUSLabos
//
//  Created by Rep on 12/14/15.
//  Copyright © 2015 Rep. All rights reserved.
//

import Foundation

func htons(value: CUnsignedShort) -> CUnsignedShort {
    return (value << 8) + (value >> 8);
}

func ntohs(value: CUnsignedShort) -> CUnsignedShort {
    return (value >> 8) + (value << 8);
}