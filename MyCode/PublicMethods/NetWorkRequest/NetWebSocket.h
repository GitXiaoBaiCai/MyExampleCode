//
//  NetWebSocket.h
//  MySlhb
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <SRWebSocket.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol NetWebSocketDelegate <NSObject>
//
//
///**
// socket链接状态
//
// @param linkStates 0：连接失败 1：连接成功 2：连接断开(已关闭) 3:重新连接失败(时间超时)
// */
//-(void)netWebSocketLinkStates:(NSInteger)linkStates;
//
//
///**
// 收到的消息
//
// @param message 消息
// */
//-(void)netWebSocketReceiveDataMessage:(id)message;
//
//@end



@interface NetWebSocket : NSObject

+(NetWebSocket*)instance;

@property(nonatomic,assign) NSInteger ping_time;
@property(nonatomic,copy) NSString * ping_str;

/** 获取连接状态 */
@property (nonatomic,assign,readonly) SRReadyState socketLinkState; // socket连接状态

#pragma mark ===>>> 方法
-(void)webscoketStartLinkUlr:(NSString*)socketUrl; // 开始连接
-(void)sendSocketData:(id)data; // 发送数据
-(void)reconnectionScoket; // 重新连接
-(void)closeScoketLink; // 关闭连接
-(SRReadyState)socketLinkState; // 获取连接状态


//@property(nonatomic,assign) id<NetWebSocketDelegate>detegate;



//// 连接成功h回调
//typedef void(^LinkSuccess)(NSInteger success);
//@property(nonatomic,copy) LinkSuccess linkSuccessBlock;
//
//// 连接失败回调
//typedef void(^LinkError)(NSInteger error);
//@property(nonatomic,copy) LinkError linkErrorBlock;
//
//// 连接失败回调
//typedef void(^ReceiveData)(id data);
//@property(nonatomic,copy) ReceiveData receDataBlock;
//
//-(void)netWebsocketStatesLinkSuccess:(LinkSuccess)successBlock websocketLinkError:(LinkError)errorBlock receiveServerData:(ReceiveData)dataBlock;

@end

NS_ASSUME_NONNULL_END
