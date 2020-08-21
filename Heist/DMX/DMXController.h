//
//  DMXController.h
//  Lighting
//
//  Created by Phil Watten on 08/11/2013.
//  Copyright (c) 2013 Phil Watten. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "artnet.h"
#import "packets.h"

@interface DMXController : NSObject
{
	artnet_node		*m_artnetNode;
	unsigned char	m_outData[512];
}

@property (assign, nonatomic) int masterValue;
@property (assign, nonatomic) BOOL deskBlackOut;

+(DMXController *)sharedController;
- (void)sendUniversePacket:(unsigned char*)data;
- (unsigned char*)currentOutputs;
@end
