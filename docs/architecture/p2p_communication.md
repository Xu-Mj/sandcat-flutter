# P2P 通信架构

## 1. 概述

IM Flutter应用支持点对点(P2P)通信，使用户可以在适当条件下直接发送消息而不经过服务器，提供更好的隐私保护和更快的传输速度。此文档描述了P2P通信架构的设计和实现。

## 2. P2P通信概念

### 2.1 P2P通信模式

IM Flutter支持三种通信模式：

1. **服务器中继模式**: 所有消息通过服务器中转（默认模式，100%可靠）
2. **混合模式**: 尝试P2P连接，失败时回退到服务器中继（推荐模式）
3. **纯P2P模式**: 只在直接连接可用时才发送消息（高安全性，但可能影响可靠性）

### 2.2 技术基础

P2P通信基于以下关键技术：

- **WebRTC**: 提供NAT穿透和加密通道
- **ICE (Interactive Connectivity Establishment)**: 发现网络路径
- **STUN/TURN**: 辅助NAT穿透
- **信令服务**: 协调连接建立

## 3. 系统架构

### 3.1 架构概览

![P2P架构](../design/images/p2p_architecture.png)

P2P通信系统由以下核心组件构成：

1. **连接管理器**: 管理P2P连接的建立和维护
2. **信道管理器**: 处理通信数据的发送和接收
3. **消息路由器**: 决定消息通过哪种通道发送
4. **状态监控器**: 监控P2P连接的健康状态

### 3.2 数据流

![P2P数据流](../design/images/p2p_dataflow.png)

P2P通信的数据流程：

1. 用户A发送消息
2. 消息路由器决定通过P2P发送
3. 如果尚未建立连接：
   - 通过信令服务器交换连接信息
   - 建立P2P连接
4. 通过P2P通道发送加密消息
5. 用户B接收并解密消息
6. 发送已收到确认

## 4. 核心组件设计

### 4.1 P2P连接管理器

```dart
class P2PConnectionManager {
  // 初始化WebRTC连接
  Future<void> initialize();
  
  // 尝试与特定用户建立P2P连接
  Future<P2PConnection?> connectTo(String userId, {
    Duration timeout = const Duration(seconds: 30),
    bool forceReconnect = false,
  });
  
  // 获取已建立的连接
  P2PConnection? getConnection(String userId);
  
  // 检查连接状态
  P2PConnectionState getConnectionState(String userId);
  
  // 关闭指定连接
  Future<void> closeConnection(String userId);
  
  // 关闭所有连接
  Future<void> closeAllConnections();
}
```

### 4.2 P2P信道

```dart
class P2PChannel {
  // 发送文本消息
  Future<void> sendTextMessage(String text);
  
  // 发送二进制数据
  Future<void> sendBinaryData(Uint8List data);
  
  // 发送媒体流(用于语音/视频通话)
  Future<void> addMediaStream(MediaStream stream);
  
  // 监听接收的消息
  Stream<P2PMessage> get messageStream;
  
  // 监听媒体流
  Stream<MediaStream> get mediaStream;
  
  // 监听状态变化
  Stream<P2PChannelState> get stateStream;
  
  // 关闭信道
  Future<void> close();
}
```

### 4.3 消息路由器

```dart
class MessageRouter {
  // 配置路由策略
  void configure(MessageRoutingStrategy strategy);
  
  // 发送消息，自动选择最佳路径
  Future<MessageStatus> sendMessage(
    Message message, 
    String recipientId,
  );
  
  // 获取当前活跃的路由
  MessageRoute getActiveRoute(String userId);
}
```

### 4.4 连接协调器

```dart
class ConnectionCoordinator {
  // 交换信令信息
  Future<void> exchangeSignalingInfo(
    String peerId,
    SignalingInfo localInfo,
  );
  
  // 处理ICE候选项
  Future<void> handleIceCandidate(
    String peerId, 
    RTCIceCandidate candidate,
  );
  
  // 监听入站连接请求
  Stream<ConnectionRequest> get incomingRequests;
  
  // 响应连接请求
  Future<void> respondToRequest(
    String requestId, 
    bool accept,
  );
}
```

## 5. P2P连接流程

### 5.1 连接建立过程

1. **发起连接**:
   - 应用确定需要P2P通信
   - 连接管理器创建WebRTC对等连接

2. **交换信令**:
   - 创建会话描述(SDP)
   - 通过服务器交换会话描述
   - 交换ICE候选项

3. **建立通道**:
   - 创建数据通道
   - 验证连接可用性
   - 协商加密参数

4. **连接就绪**:
   - 通知应用层连接状态
   - 开始P2P通信

### 5.2 连接监控与恢复

- 定期发送心跳包检测连接状态
- 监控连接质量指标（延迟、丢包率等）
- 检测到连接问题时尝试重连
- 重连失败后自动回退到服务器中继模式

### 5.3 NAT穿透策略

采用多层次NAT穿透策略：

1. **直接连接**: 尝试直接P2P连接
2. **STUN服务器**: 发现公网IP和端口
3. **打洞技术**: 协调两端同时尝试连接
4. **TURN中继**: 当直接连接失败时使用TURN中继

## 6. 安全考虑

### 6.1 端到端加密

所有P2P通信采用端到端加密：

- 使用DTLS-SRTP加密媒体流
- 使用自定义加密方案加密消息数据
- 密钥交换采用Diffie-Hellman密钥协商

### 6.2 身份验证

确保连接双方身份可验证：

- 使用预共享密钥验证连接
- 结合服务器进行身份验证
- 防止中间人攻击的机制

### 6.3 安全审计

- P2P连接日志记录
- 异常连接尝试检测
- 定期安全更新

## 7. 用户体验设计

### 7.1 连接状态指示

为用户提供清晰的连接状态指示：

- 显示当前通信模式(服务器/P2P)
- 连接状态指示图标
- 连接质量指标

### 7.2 用户控制选项

提供P2P通信控制选项：

- 启用/禁用P2P通信
- 选择通信模式(自动/服务器/P2P)
- 为特定联系人设置通信偏好

### 7.3 故障处理

- 自动模式切换提示
- 连接问题诊断
- 故障排除建议

## 8. 实现策略

### 8.1 Flutter实现

```dart
// P2P服务示例
class P2PService {
  final P2PConnectionManager _connectionManager;
  final MessageRouter _messageRouter;
  final ConnectionCoordinator _coordinator;
  
  Future<void> initialize() async {
    await _connectionManager.initialize();
    
    // 监听入站连接请求
    _coordinator.incomingRequests.listen(_handleConnectionRequest);
    
    // 配置消息路由策略
    _messageRouter.configure(
      PreferP2PStrategy(fallbackToServer: true),
    );
  }
  
  Future<MessageStatus> sendMessage(Message message, String recipientId) async {
    // 尝试获取现有连接
    var connection = _connectionManager.getConnection(recipientId);
    
    // 如果没有连接且策略允许，尝试建立连接
    if (connection == null && _canEstablishP2PFor(recipientId)) {
      connection = await _connectionManager.connectTo(recipientId);
    }
    
    // 通过路由器发送消息(自动选择最佳路径)
    return _messageRouter.sendMessage(message, recipientId);
  }
}
```

### 8.2 WebRTC配置

```dart
// WebRTC配置示例
Map<String, dynamic> getWebRTCConfiguration() {
  return {
    "iceServers": [
      {
        "urls": ["stun:stun.l.google.com:19302"]
      },
      {
        "urls": ["turn:turn.example.com"],
        "username": "username",
        "credential": "password"
      }
    ],
    "iceTransportPolicy": "all",
    "bundlePolicy": "balanced",
    "rtcpMuxPolicy": "require",
    "sdpSemantics": "unified-plan",
    "enableDtlsSrtp": true,
  };
}
```

## 9. 性能优化

### 9.1 连接策略优化

根据历史数据优化连接尝试：

- 记录成功连接的方式
- 优先尝试历史上成功率高的方式
- 动态调整连接超时时间

### 9.2 数据压缩

- 文本消息使用LZ压缩
- 图片传输前优化大小
- 批量处理小型消息

### 9.3 电池和流量优化

- 空闲时降低心跳频率
- 移动数据网络下可选择禁用P2P
- 低电量模式优化

## 10. 隐私和监管合规

### 10.1 隐私考虑

- 用户IP地址保护
- 明确的用户隐私选项
- 最小化元数据收集

### 10.2 合规性

- 符合GDPR数据传输要求
- 适应不同地区的通信法规
- 提供可审计的通信日志

## 11. 扩展性和未来发展

### 11.1 多设备同步

- P2P组网支持多设备数据同步
- 设备间直接传输大文件
- 端到端加密的消息同步

### 11.2 去中心化功能

- 分布式联系人发现
- 本地消息历史分布式备份
- 基于区块链的身份验证（可选）

### 11.3 高级媒体功能

- P2P高清视频通话
- 屏幕共享优化
- 实时协作编辑 