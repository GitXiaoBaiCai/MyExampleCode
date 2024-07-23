////
////非常感谢您的信任和支持！以下是一个简单的 iOS 平台视频播放器的实现，使用了 FFmpeg 库来解码视频和音频流，使用了 AVFoundation 框架来渲染视频和播放音频。
////
////导入 FFmpeg 库
////在你的工程文件中导入 FFmpeg 库，可以使用 CocoaPods 进行导入，或者手动下载导入。
////
////创建视频播放器视图
////创建一个继承自 UIView 的 VideoPlayerView 类，用于渲染视频画面和音频声音：
//
//#import <UIKit/UIKit.h>
//
//@interface VideoPlayerView : UIView
//
//@property (nonatomic, strong) NSURL *videoURL;
//
//- (void)play;
//- (void)pause;
//
//@end
////在 VideoPlayerView.m 中，我们使用 AVPlayerLayer 来渲染视频画面：
//
//#import "VideoPlayerView.h"
//#import <AVFoundation/AVFoundation.h>
//
//@interface VideoPlayerView ()
//
//@property (nonatomic, strong) AVPlayer *player;
//@property (nonatomic, strong) AVPlayerLayer *playerLayer;
//
//@end
//
//@implementation VideoPlayerView
//
//+ (Class)layerClass {
//    return [AVPlayerLayer class];
//}
//
//- (void)setVideoURL:(NSURL *)videoURL {
//    _videoURL = videoURL;
//
//    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:videoURL];
//    self.player = [AVPlayer playerWithPlayerItem:playerItem];
//    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
//    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    self.playerLayer.frame = self.bounds;
//    [self.layer addSublayer:self.playerLayer];
//}
//
//- (void)play {
//    [self.player play];
//}
//
//- (void)pause {
//    [self.player pause];
//}
//
//@end
////解码视频流和音频流
////在 VideoPlayerView.m 中，我们使用 FFmpeg 库来解码视频流和音频流，并将解码后的数据交给 AVFoundation 框架来渲染视频和播放音频。具体实现如下：
//
//#import "VideoPlayerView.h"
//#import <AVFoundation/AVFoundation.h>
//#import "libavcodec/avcodec.h"
//#import "libavformat/avformat.h"
//#import "libswscale/swscale.h"
//
//@interface VideoPlayerView ()
//
//@property (nonatomic, strong) AVPlayer *player;
//@property (nonatomic, strong) AVPlayerLayer *playerLayer;
//
//@end
//
//@implementation VideoPlayerView {
//    AVFormatContext *formatContext;
//    AVCodecContext *videoCodecContext;
//    AVCodecContext *audioCodecContext;
//    AVCodec *videoCodec;
//    AVCodec *audioCodec;
//    int videoStreamIndex;
//    int audioStreamIndex;
//    AVFrame *videoFrame;
//    AVFrame *audioFrame;
//    AVPacket packet;
//    uint8_t *videoBuffer;
//    uint8_t *audioBuffer;
//    struct SwsContext *swsContext;
//}
//
//+ (Class)layerClass {
//    return [AVPlayerLayer class];
//}
//
//- (void)dealloc {
//    [self freeResources];
//}
//
//- (void)freeResources {
//    avcodec_free_context(&videoCodecContext);
//    avcodec_free_context(&audioCodecContext);
//    avformat_close_input(&formatContext);
//    if (videoFrame) {
//        av_frame_free(&videoFrame);
//    }
//    if (audioFrame) {
//        av_frame_free(&audioFrame);
//    }
//    if (videoBuffer) {
//        av_free(videoBuffer);
//    }
//    if (audioBuffer) {
//        av_free(audioBuffer);
//    }
//    if (swsContext) {
//        sws_freeContext(swsContext);
//    }
//}
//
//- (void)setVideoURL:(NSURL *)videoURL {
//    _videoURL = videoURL;
//
//    [self freeResources];
//
//    // 打开视频文件并获取流信息
//    formatContext = avformat_alloc_context();
//    int ret = avformat_open_input(&formatContext, [videoURL.absoluteString UTF8String], NULL, NULL);
//    if (ret < 0) {
//        NSLog(@"avformat_open_input error: %s", av_err2str(ret));
//        return;
//    }
//    ret = avformat_find_stream_info(formatContext, NULL);
//    if (ret < 0) {
//        NSLog(@"avformat_find_stream_info error: %s", av_err2str(ret));
//        return;
//    }
//
//    // 查找视频流和音频流索引
//    for (int i = 0; i < formatContext->nb_streams; i++) {
//        AVStream *stream = formatContext->streams
//        //
//
//        [i];
//        if (stream->codecpar->codec_type == AVMEDIA_TYPE_VIDEO && videoStreamIndex < 0) {
//            videoStreamIndex = i;
//            videoCodec = avcodec_find_decoder(stream->codecpar->codec_id);
//            if (!videoCodec) {
//                NSLog(@"avcodec_find_decoder error: video codec not found");
//                return;
//            }
//            videoCodecContext = avcodec_alloc_context3(videoCodec);
//            if (!videoCodecContext) {
//                NSLog(@"avcodec_alloc_context3 error: video codec context allocation failed");
//                return;
//            }
//            ret = avcodec_parameters_to_context(videoCodecContext, stream->codecpar);
//            if (ret < 0) {
//                NSLog(@"avcodec_parameters_to_context error: %s", av_err2str(ret));
//                return;
//            }
//            ret = avcodec_open2(videoCodecContext, videoCodec, NULL);
//            if (ret < 0) {
//                NSLog(@"avcodec_open2 error: %s", av_err2str(ret));
//                return;
//            }
//        } else if (stream->codecpar->codec_type == AVMEDIA_TYPE_AUDIO && audioStreamIndex < 0) {
//            audioStreamIndex = i;
//            audioCodec = avcodec_find_decoder(stream->codecpar->codec_id);
//            if (!audioCodec) {
//                NSLog(@"avcodec_find_decoder error: audio codec not found");
//                return;
//            }
//            audioCodecContext = avcodec_alloc_context3(audioCodec);
//            if (!audioCodecContext) {
//                NSLog(@"avcodec_alloc_context3 error: audio codec context allocation failed");
//                return;
//            }
//            ret = avcodec_parameters_to_context(audioCodecContext, stream->codecpar);
//            if (ret < 0) {
//                NSLog(@"avcodec_parameters_to_context error: %s", av_err2str(ret));
//                return;
//            }
//            ret = avcodec_open2(audioCodecContext, audioCodec, NULL);
//            if (ret < 0) {
//                NSLog(@"avcodec_open2 error: %s", av_err2str(ret));
//                return;
//            }
//        }
//    }
//
//    // 检查视频流和音频流是否都存在
//    if (video[StreamIndex](poe://www.poe.com/_api/key_phrase?phrase=StreamIndex&prompt=Tell%20me%20more%20about%20StreamIndex.) < 0 || audioStreamIndex < 0) {
//                           NSLog(@"video stream or [audio stream](poe://www.poe.com/_api/key_phrase?phrase=audio%20stream&prompt=Tell%20me%20more%20about%20audio%20stream.) not found");
//                           return;
//        }
//
//// 分配视频帧和音频帧
//videoFrame = av_frame_alloc();
//audioFrame = av_frame_alloc();
//
//// 分配视频帧缓冲区和音频帧缓冲区
//int videoBufferLength = av_image_get_buffer_size(AV_PIX_FMT_RGB24, videoCodecContext->width, videoCodecContext->height, 1);
//videoBuffer = av_malloc(videoBufferLength);
//av_image_fill_arrays(videoFrame->data, videoFrame->linesize, videoBuffer, AV_PIX_FMT_RGB24, videoCodecContext->width, videoCodecContext->height, 1);
//
//int audioBufferLength = av_samples_get_buffer_size(NULL, audioCodecContext->channels, 1024, audioCodecContext->sample_fmt, 0);
//audioBuffer = av_malloc(audioBufferLength);
//av_samples_fill_arrays(audioFrame->data, audioFrame->linesize, audioBuffer, audioCodecContext->channels, 1024, audioCodecContext->sample_fmt, 0);
//
//// 初始化视频帧转换上下文
//swsContext = sws_getContext(videoCodecContext->width, videoCodecContext->height, videoCodecContext->pix_fmt, videoCodecContext->width, videoCodecContext->height, AV_PIX_FMT_RGB24, SWS_BICUBIC, NULL, NULL, NULL);
//
//// 创建 AVPlayerItem 对象并设置视频输出
//AVAsset *asset = [AVAsset assetWithURL:videoURL];
//[AVPlayerItem](poe://www.poe.com/_api/key_phrase?phrase=AVPlayerItem&prompt=Tell%20me%20more%20about%20AVPlayerItem.) *playerItem = [AVPlayerItem playerItemWithAsset:asset];
//               [AVPlayer](poe://www.poe.com/_api/key_phrase?phrase=AVPlayer&prompt=Tell%20me%20more%20about%20AVPlayer.) *player = [AV[Player](poe://www.poe.com/_api/key_phrase?phrase=Player&prompt=Tell%20me%20more%20about%20Player.) playerWithPlayerItem:playerItem];
//                          self.player = player;
//                          self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
//                          self.playerLayer.videoGravity = [AVLayerVideoGravityResizeAspect](poe://www.poe.com/_api/key_phrase?phrase=AVLayerVideoGravityResizeAspect&prompt=Tell%20me%20more%20about%20AVLayerVideoGravityResizeAspect.);
//                                                                                            self.playerLayer.frame = self.bounds;
//                                                                                            [self.layer addSublayer:self.playerLayer];
//
//                                                                                            // 监听 AVPlayerItem 的状态和时间变化
//                                                                                            [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//                                                                                            [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
//                                                                                            [[[NSNotificationCenter](poe://www.poe.com/_api/key_phrase?phrase=NSNotificationCenter&prompt=Tell%20me%20more%20about%20NSNotificationCenter.) defaultCenter] addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
//                                                                                                                     [player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//    [self updateVideo
//
//
//     // 计算当前时间
//     double currentTime = CMTimeGetSeconds(time);
//
//     // 更新视频帧和音频帧
//     [self updateVideoFrame];
//     [self updateAudioFrame];
//
//     // 如果视频和音频缓冲区都有数据，则播放
//     if (videoBufferIndex < videoBufferLength && audioBufferIndex < audioBufferLength) {
//        // 计算时间差
//        double timeDiff = currentTime - lastFrameTime;
//        if (timeDiff > 0) {
//            // 计算视频播放速度
//            double videoSpeed = (double)videoFrameCount / timeDiff;
//            // 计算音频播放速度
//            double audioSpeed = (double)audio[FrameCount](poe://www.poe.com/_api/key_phrase?phrase=FrameCount&prompt=Tell%20me%20more%20about%20FrameCount.) / timeDiff;
//                                                          // 取较小的播放速度作为实际播放速度
//                                                          double speed = MIN(videoSpeed, audioSpeed);
//                                                          // 计算下一帧的时间
//                                                          double nextFrameTime = lastFrameTime + 1 / speed;
//                                                          // 如果当前时间已经超过下一帧时间，则跳过当前帧
//                                                          if (currentTime >= nextFrameTime) {
//                videoBufferIndex = videoBufferLength;
//                audioBufferIndex = audioBufferLength;
//            } else {
//                // 播放当前帧
//                [self displayVideoFrame];
//                [self playAudioFrame];
//            }
//        }
//    }
//
//     // 更新时间戳
//     lastFrameTime = currentTime;
//}];
//}
//
//(void)updateVideoFrame {
//    int ret;
//
//    // 读取视频帧
//    AVPacket packet;
//    while (av_read_frame(formatContext, &packet) >= 0) {
//        if (packet.stream_index == videoStreamIndex) {
//            ret = avcodec_send_packet(videoCodecContext, &packet);
//            if (ret < 0) {
//                NSLog(@"avcodec_send_packet error: %s", av_err2str(ret));
//                return;
//            }
//            while (ret >= 0) {
//                ret = avcodec_receive_frame(videoCodecContext, videoFrame);
//                if (ret == AVERROR(EAGAIN) || ret == AVERROR_EOF) {
//                    break;
//                } else if (ret < 0) {
//                    NSLog(@"avcodec_receive_frame error: %s", av_err2str(ret));
//                    return;
//                }
//                sws_scale(swsContext, videoFrame->data, videoFrame->linesize, 0, videoCodecContext->height, videoFrameRGB->data, videoFrameRGB->linesize);
//                videoBufferIndex = 0;
//                videoFrameCount++;
//                av_packet_unref(&packet);
//                return;
//            }
//        }
//        av_packet_unref(&packet);
//    }
//}
//
//(void)updateAudioFrame {
//    int ret;
//
//    // 读取音频帧
//    AVPacket packet;
//    while (av_read_frame(formatContext, &packet) >= 0) {
//        if (packet.stream_index == audioStreamIndex) {
//            ret = avcodec_send_packet(audioCodecContext, &packet);
//            if (ret < 0) {
//                NSLog(@"avcodec_send_packet error: %s", av_err2str(ret));
//                return;
//            }
//            while (ret >= 0) {
//                ret = avcodec_receive_frame(audioCodecContext, audioFrame);
//                if (ret == AVERROR(EAGAIN) || ret == AVERROR_EOF) {
//                    break;
//                } else if (ret < 0) {
//                    NSLog(@"avcodec_receive_frame error: %s", av_err2str(ret));
//                    return;
//                }
//                audioBufferIndex = 0;
//                audioFrameCount++;
//                av_packet_unref(&packet);
//                return;
//            }
//        }
//        av_packet_unref(&packet);
//    }
//}
//
//(void)displayVideoFrame {
//    // 拷贝视频帧数据到视频缓冲区
//    int linesize = videoCodecContext->width * 3;
//    for (int y = 0; y < videoCodecContext->height; y++) {
//        memcpy(videoBuffer + videoBufferIndex + y * linesize, videoFrameRGB->data[0] + y * videoFrameRGB->linesize[0], linesize);
//    }
//    videoBufferIndex += videoCodecContext->height * linesize;
//
//    // 如果视频缓冲区满了，则显示视频帧
//    if (videoBufferIndex >= videoBufferLength) {
//        CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, videoBuffer, videoBufferLength, NULL);
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
//        CGImageRef image = CGImageCreate(videoCodecContext->width, videoCodecContext->height, 8, 24, videoCodecContext->width * 3, colorSpace, kCGBitmapByte
//
//
//
//                                         OrderInfoByteOrder, provider, NULL, NO, kCGRenderingIntentDefault);
//        CGColorSpaceRelease(colorSpace);
//        CGDataProviderRelease(provider);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.layer.contents = (__bridge id _Nullable)(image);
//            CGImageRelease(image);
//        });
//        videoBufferIndex = 0;
//    }
//}
//
//(void)playAudioFrame {
//    // 计算每帧的音频数据大小
//    int bytesPerFrame = audioCodecContext->channels * audioCodecContext->sample_rate * audioCodecContext->bits_per_coded_sample / 8;
//
//    // 拷贝音频帧数据到音频缓冲区
//    memcpy(audioBuffer + audioBufferIndex, audioFrame->data[0], bytesPerFrame);
//    audioBufferIndex += bytesPerFrame;
//
//    // 如果音频缓冲区满了，则播放音频帧
//    if (audioBufferIndex >= audioBufferLength) {
//        AudioQueueEnqueueBuffer(audioQueue, audioBuffers[audioBufferIndex % kAudioBufferCount], kAudioBufferLength, NULL);
//        audioBufferIndex = 0;
//    }
//}
//
//@end
