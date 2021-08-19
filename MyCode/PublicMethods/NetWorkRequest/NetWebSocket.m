//
//  NetWebSocket.m
//  MySlhb
//
//  Created by mac on 2019/4/2.
//  Copyright © 2019 chgyl. All rights reserved.
//

#import "NetWebSocket.h"

@interface NetWebSocket () <SRWebSocketDelegate>
@property(nonatomic,strong)  NSTimer * heartBeat; // 发送心跳包定时器
@property(nonatomic,readonly) NSTimeInterval reConnectTime; // 记录重连时间
@property(nonatomic,strong) SRWebSocket * srWebSocket;
@property(nonatomic,copy) NSString * urlString;

@end


@implementation NetWebSocket


#pragma mark ===>>> WebSockek(长连接)


#pragma mark ===>>> 方法
// 初始化
+(NetWebSocket*)instance{
    static NetWebSocket * socket = nil;
    static dispatch_once_t once_socket;
    dispatch_once(&once_socket, ^{
        socket = [[NetWebSocket alloc] init];
    });
    return socket;
}

// 开始连接socket
-(void)webscoketStartLinkUlr:(NSString *)socketUrl{
    if (socketUrl==nil||socketUrl.length<3) { return; }
    _urlString = socketUrl;
    if (_srWebSocket) { [self closeWebSocket]; }
    _srWebSocket = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:socketUrl]];
    _srWebSocket.delegate = self;
    [_srWebSocket open]; // 打开
    
}

// 发送数据
-(void)sendSocketData:(id)data{
    
    [self sendData:data];
}

// 关闭连接
-(void)closeScoketLink{
    [self closeWebSocket];
}

// 重新连接
-(void)reconnectionScoket{
    [self openWebSocket];
}

-(SRReadyState)socketLinkState{
    if (_srWebSocket) { return _srWebSocket.readyState; }
    return SR_CONNECTING;
}


#pragma mark
#pragma mark
#pragma mark ===>>>  WebSocket 代理
- (void)webSocketDidOpen:(SRWebSocket *)webSocket{
    _reConnectTime = 0; // 每次正常连接的时候清零重连时间
    NSDictionary * pdic = @{@"type":@"1",@"link_states":@"1",@"msg":@"连接成功"};
    [[NSNotificationCenter defaultCenter] postNotificationName:notice_receive_socket_msg object:nil userInfo:pdic];
    C_LOG(@"*****************************  socket 连接成功  *****************************");
//    [self init_heartBeat];
}

// 收到消息
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message{
    if (message) {
        NSDictionary * pdic = @{@"type":@"2",@"msg":null_str(message)};
        [[NSNotificationCenter defaultCenter] postNotificationName:notice_receive_socket_msg object:nil userInfo:pdic];
    }else{
        NSDictionary * pdic = @{@"type":@"3",@"msg":@"消息为空"};
        [[NSNotificationCenter defaultCenter] postNotificationName:notice_receive_socket_msg object:nil userInfo:pdic];
    }
}

// 连接失败
- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSDictionary * pdic = @{@"type":@"1",@"link_states":@"0",@"msg":error.localizedDescription};
    [[NSNotificationCenter defaultCenter] postNotificationName:notice_receive_socket_msg object:nil userInfo:pdic];
    C_LOG(@"**************************  socket 连接失败  **************************\n%@",error);
}

// 连接断开
- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean{
    NSDictionary * pdic = @{@"type":@"1",@"link_states":@"2",@"msg":reason};
    [[NSNotificationCenter defaultCenter] postNotificationName:notice_receive_socket_msg object:nil userInfo:pdic];
    C_LOG(@"**************************  socket 连接已断开(或手动关闭)  **************************\ncode:%ld reason:%@",(long)code,reason);
}

/*
 该函数是接收服务器发送的pong消息，其中最后一个是接受pong消息的，
 在这里就要提一下心跳包，一般情况下建立长连接都会建立一个心跳包，
 用于每隔一段时间通知一次服务端，客户端还是在线，这个心跳包其实就是一个ping消息，
 */
- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload{
    C_LOG(@"============= pongPayload：  %@",pongPayload)
}


#pragma mark
#pragma mark ===>>> 其它方法
// 打开连接(重连也用它)
-(void)openWebSocket{
    [self closeWebSocket];
    
    if (_reConnectTime > 30) {
        
        show_toast_msg(@"您的网络状况不是很好，请检查网络后重试") return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_reConnectTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self webscoketStartLinkUlr:_urlString];
        C_LOG(@"正在重新连接。。。。。。");
    });
    
    // 重连时间2的指数级增长
    if (_reConnectTime == 0) { _reConnectTime = 2; } else { _reConnectTime *= 2; }
    
}

// 关闭连接
-(void)closeWebSocket{
    if (_srWebSocket) {
        [self destory_heartBeat];
        [_srWebSocket close];
        _srWebSocket.delegate = nil;
        _srWebSocket = nil;
    }
}

// 取消心跳
- (void)destory_heartBeat {
    dispatch_main_async_safe(^{
        if (_heartBeat) {
            if ([_heartBeat respondsToSelector:@selector(isValid)]){
                if ([_heartBeat isValid]){
                    [_heartBeat invalidate];
                    _heartBeat = nil;
                }
            }
        }
    })
}

// 初始化心跳
- (void)init_heartBeat{
    dispatch_main_async_safe(^{
        [self destory_heartBeat];
        // 定时器，没隔?秒发一次
        _heartBeat = [NSTimer timerWithTimeInterval:_ping_time target:self selector:@selector(sentHeart) userInfo:nil repeats:YES];
        // 和服务端约定好发送什么作为心跳标识，尽可能的减小心跳包大小
        [[NSRunLoop currentRunLoop] addTimer:_heartBeat forMode:NSRunLoopCommonModes];
    })
}

// 发送心跳包
-(void)sentHeart{
    [_srWebSocket send:_ping_str];
}

// ping Pong
- (void)ping{
    if (_srWebSocket.readyState == SR_OPEN) {
        [_srWebSocket sendPing:nil];
    }
}

// 发送数据
-(void)sendData:(id)data{
    
    WeakSelf(weakSelf)

    dispatch_queue_t queue =  dispatch_queue_create("web_socket_send", NULL);
    dispatch_async(queue, ^{
        
        if (weakSelf.srWebSocket != nil) {
            // 只有 SR_OPEN 开启状态才能调 send 方法啊，不然要崩
            if (weakSelf.srWebSocket.readyState == SR_OPEN) {
                [weakSelf.srWebSocket send:data]; // 发送数据
                
            } else if (weakSelf.srWebSocket.readyState == SR_CONNECTING) {
                C_LOG(@" ========== 正在连接中，重连后其他方法会去自动同步数据");
                [weakSelf openWebSocket]; // 重新连接
                
            } else if (weakSelf.srWebSocket.readyState == SR_CLOSING || weakSelf.srWebSocket.readyState == SR_CLOSED) {
                // websocket 断开了，调用 reConnect 方法重连
                C_LOG(@" ========== websocket 断开了，正在重连");
                
                [weakSelf openWebSocket];
            }
        } else {
            C_LOG(@" ========== 还未建立长连接，不能发送消息");
        }
    });
    
}


@end
