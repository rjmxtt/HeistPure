//
//  DMXController.m
//  Lighting
//
//  Created by Phil Watten on 08/11/2013.
//  Copyright (c) 2013 Phil Watten. All rights reserved.
//

#import "DMXController.h"

int artnetReceiver(artnet_node node, void *pp, void *d) {
	printf("DMXController.artnetReceiver");
    NSLog(@"Receiving Art-Net data!");
	artnet_packet pack = (artnet_packet) pp;
	printf("Received packet sequence %d\n", pack->data.admx.sequence);
	printf("Received packet type %d\n", pack->type);
	printf("Received packet data %s\n", pack->data.admx.data);
	
	printf("universe %d\n", pack->data.admx.universe);
	printf("length %d\n", pack->data.admx.length);
	
	//	pack->data.admx.universe
	for(int i = 0; i < pack->data.admx.length; i++)
	{
		printf("%d, ", pack->data.admx.data[i]);
	}
	return 0;
}


@implementation DMXController

+(DMXController *)sharedController
{
    printf("DMXController.sharedController\n");
	static dispatch_once_t pred;
	static DMXController *shared = nil;
	
	dispatch_once(&pred,
	^{
		shared = [[DMXController alloc] init];
	});
	return shared;
}

- (id)init
{
	if(self = [super init])
	{
		
		//uint8_t data[512];
		//for(int i = 0; i < 512; i++) data[i] = ((int)m_fCurrentData[i]) & 0xff;
		//artnet_send_dmx(m_artnetNode, 0, 512, data);
        printf("DMXController.init\n");

		self.masterValue	= 255;
		self.deskBlackOut	= NO;
		if([self initArtNet])
		{
		}
	}
	return self;
}

- (BOOL)initArtNet
{
    printf("DMXController.initArtNet\n");

	char *ip_addr = NULL;//"10.0.0.75";// NULL;//"10.0.0.75";//NULL;
	
	uint8_t subnet_addr = 0;
	uint8_t port_addr = 1;
	
	/*artnet_node **/m_artnetNode = artnet_new(ip_addr, 0);
    //printf(m_artnetNode);
    
	if (!m_artnetNode) {
		printf("Error: %s\n", artnet_strerror());
		return NO;
	}
	
	artnet_set_long_name(m_artnetNode, "Art-Net Test");
	artnet_set_short_name(m_artnetNode, "ANT");
	
	// set the upper 4 bits of the universe address
	artnet_set_subnet_addr(m_artnetNode, subnet_addr) ;
	
	// enable port 0
	artnet_set_port_type(m_artnetNode, 0, ARTNET_ENABLE_OUTPUT, ARTNET_PORT_DMX) ;
	
	// bind port 0 to universe 1
	artnet_set_port_addr(m_artnetNode, 0, ARTNET_OUTPUT_PORT, port_addr);
	
	artnet_dump_config(m_artnetNode);
	//param 3 not issue
	artnet_set_handler(m_artnetNode, ARTNET_RECV_HANDLER, artnetReceiver, NULL);
	
	if (artnet_start(m_artnetNode) != 0) {
		printf("Error: %s\n", artnet_strerror());
		return NO;
	}
	
	//	for(uint i = 0; i < 256; i++)
	{
			//uint8_t data[] = {0, 255, 0, 0, 0, 0, 0};
			//artnet_send_dmx(m_artnetNode, 0, 7, data);
	}
	
	//while (YES) {
	//	artnet_send_poll(artnetNode, NULL, ARTNET_TTM_DEFAULT);
	//printf("arnet_get_sd() => %i\n", artnet_get_sd(artnetNode));
	//	printf("artnet_read() => %i\n", artnet_read(artnetNode, 1));
	//	}
	
	// Use this to deallocate memory
    //artnet_stop(m_artnetNode);
    //artnet_destroy(m_artnetNode);
	return YES;
}

- (unsigned char*)currentOutputs
{
    printf("DMXController.currentOutputs\n");

	return m_outData;
}

- (void)sendUniversePacket:(unsigned char*)data
{
    //printf("DMXController.sendUniversePackets\n");

	memcpy(m_outData, data, 512);
	if(self.deskBlackOut == YES)
	{
		for(int i = 0; i < 512; i++)
		{
			m_outData[i] = 0;
		}
	}
	else if(self.masterValue < 255)
	{
		float multiplier = (float)self.masterValue / 255.0;
		for(int i = 0; i < 512; i++)
		{
			m_outData[i] = (unsigned char)((float)data[i] * multiplier);
		}
	}
	artnet_send_dmx(m_artnetNode, 0, 512, m_outData);
}

- (void)send:(uint8_t)number
{
    printf("DMXController.send\n");

	//uint8_t data[] = {0, 255, 0, 0, 0, 0, 0};
	uint8_t data[512];
	for(int i = 0; i < 512; i++) data[i] = number;
	data[0] = 0;//number;
	artnet_send_dmx(m_artnetNode, 0, 512, data);
}

@end
