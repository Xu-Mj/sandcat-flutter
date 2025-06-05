# API 文档

## 1. 概述

本文档定义了IM Flutter前端与Rust后端之间的通信接口。接口分为HTTP REST API和WebSocket实时通信两部分。

### 1.1 基本信息

- **基础URL**: `https://api.example.com/v1`
- **WebSocket URL**: `wss://api.example.com/ws`
- **认证方式**: Bearer Token (JWT)
- **数据格式**: JSON

### 1.2 API版本控制

API使用URL路径中的版本号进行版本控制，当前版本为v1。

### 1.3 错误处理

所有API都使用标准HTTP状态码表示请求状态，并在响应体中提供错误详情：

```json
{
  "code": 400,
  "message": "Invalid request parameters",
  "details": "Username must be at least 3 characters"
}
```

## 2. 认证API

### 2.1 用户注册

- **URL**: `/auth/register`
- **方法**: `POST`
- **描述**: 注册新用户
- **请求体**:

```json
{
  "username": "johndoe",
  "password": "securePassword123",
  "email": "john.doe@example.com",
  "nickname": "John"
}
```

- **响应**: 201 Created

```json
{
  "user_id": "12345",
  "username": "johndoe",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### 2.2 用户登录

- **URL**: `/auth/login`
- **方法**: `POST`
- **描述**: 用户登录
- **请求体**:

```json
{
  "username": "johndoe",
  "password": "securePassword123"
}
```

- **响应**: 200 OK

```json
{
  "user_id": "12345",
  "username": "johndoe",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### 2.3 刷新Token

- **URL**: `/auth/refresh`
- **方法**: `POST`
- **描述**: 使用刷新令牌获取新的访问令牌
- **请求体**:

```json
{
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

- **响应**: 200 OK

```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

### 2.4 第三方登录

- **URL**: `/auth/oauth/{provider}`
- **方法**: `POST`
- **描述**: 通过第三方OAuth提供商登录
- **路径参数**:
  - `provider`: 第三方提供商，如`google`、`github`
- **请求体**:

```json
{
  "code": "authorization_code_from_provider",
  "redirect_uri": "app://callback"
}
```

- **响应**: 200 OK

```json
{
  "user_id": "12345",
  "username": "johndoe",
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

## 3. 用户API

### 3.1 获取当前用户信息

- **URL**: `/user/me`
- **方法**: `GET`
- **描述**: 获取当前登录用户的详细信息
- **请求头**: `Authorization: Bearer {token}`
- **响应**: 200 OK

```json
{
  "user_id": "12345",
  "username": "johndoe",
  "email": "john.doe@example.com",
  "nickname": "John",
  "avatar": "https://example.com/avatars/john.jpg",
  "status": "online",
  "created_at": "2023-01-01T12:00:00Z"
}
```

### 3.2 更新用户信息

- **URL**: `/user/me`
- **方法**: `PATCH`
- **描述**: 更新当前用户的信息
- **请求头**: `Authorization: Bearer {token}`
- **请求体**:

```json
{
  "nickname": "John Doe",
  "avatar": "base64:encoded_image_data...",
  "status_message": "Working from home"
}
```

- **响应**: 200 OK

```json
{
  "user_id": "12345",
  "username": "johndoe",
  "nickname": "John Doe",
  "avatar": "https://example.com/avatars/john_updated.jpg",
  "status_message": "Working from home"
}
```

### 3.3 搜索用户

- **URL**: `/users/search`
- **方法**: `GET`
- **描述**: 搜索用户
- **请求头**: `Authorization: Bearer {token}`
- **查询参数**:
  - `query`: 搜索关键词
  - `limit`: 结果数量限制 (默认20)
  - `offset`: 结果偏移量 (默认0)
- **响应**: 200 OK

```json
{
  "total": 42,
  "users": [
    {
      "user_id": "12346",
      "username": "janedoe",
      "nickname": "Jane",
      "avatar": "https://example.com/avatars/jane.jpg"
    },
    // ...更多用户
  ]
}
```

## 4. 联系人API

### 4.1 获取联系人列表

- **URL**: `/contacts`
- **方法**: `GET`
- **描述**: 获取当前用户的联系人列表
- **请求头**: `Authorization: Bearer {token}`
- **查询参数**:
  - `limit`: 结果数量限制 (默认50)
  - `offset`: 结果偏移量 (默认0)
- **响应**: 200 OK

```json
{
  "total": 120,
  "contacts": [
    {
      "user_id": "12346",
      "username": "janedoe",
      "nickname": "Jane",
      "remark": "Colleague",
      "avatar": "https://example.com/avatars/jane.jpg",
      "status": "online",
      "last_online": "2023-06-10T15:30:00Z"
    },
    // ...更多联系人
  ]
}
```

### 4.2 添加联系人

- **URL**: `/contacts`
- **方法**: `POST`
- **描述**: 添加新联系人
- **请求头**: `Authorization: Bearer {token}`
- **请求体**:

```json
{
  "user_id": "12346",
  "remark": "Colleague"
}
```

- **响应**: 201 Created

```json
{
  "user_id": "12346",
  "username": "janedoe",
  "nickname": "Jane",
  "remark": "Colleague",
  "avatar": "https://example.com/avatars/jane.jpg",
  "status": "online"
}
```

### 4.3 更新联系人

- **URL**: `/contacts/{user_id}`
- **方法**: `PATCH`
- **描述**: 更新联系人信息
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `user_id`: 联系人ID
- **请求体**:

```json
{
  "remark": "Team Lead"
}
```

- **响应**: 200 OK

```json
{
  "user_id": "12346",
  "remark": "Team Lead"
}
```

### 4.4 删除联系人

- **URL**: `/contacts/{user_id}`
- **方法**: `DELETE`
- **描述**: 删除联系人
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `user_id`: 联系人ID
- **响应**: 204 No Content

## 5. 对话API

### 5.1 获取对话列表

- **URL**: `/conversations`
- **方法**: `GET`
- **描述**: 获取用户的对话列表
- **请求头**: `Authorization: Bearer {token}`
- **查询参数**:
  - `limit`: 结果数量限制 (默认20)
  - `offset`: 结果偏移量 (默认0)
  - `type`: 对话类型 (private, group, all)
- **响应**: 200 OK

```json
{
  "total": 42,
  "conversations": [
    {
      "conversation_id": "c12345",
      "type": "private",
      "target_id": "12346",
      "target_name": "Jane",
      "avatar": "https://example.com/avatars/jane.jpg",
      "last_message": {
        "message_id": "m98765",
        "sender_id": "12346",
        "content": "Hello there!",
        "type": "text",
        "created_at": "2023-06-10T15:30:00Z"
      },
      "unread_count": 3
    },
    {
      "conversation_id": "c12346",
      "type": "group",
      "target_id": "g7890",
      "target_name": "Project Team",
      "avatar": "https://example.com/avatars/group.jpg",
      "last_message": {
        "message_id": "m98766",
        "sender_id": "12347",
        "sender_name": "Bob",
        "content": "Meeting at 2PM",
        "type": "text",
        "created_at": "2023-06-10T14:20:00Z"
      },
      "unread_count": 5
    },
    // ...更多对话
  ]
}
```

### 5.2 获取对话消息

- **URL**: `/conversations/{conversation_id}/messages`
- **方法**: `GET`
- **描述**: 获取特定对话的消息
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `conversation_id`: 对话ID
- **查询参数**:
  - `limit`: 结果数量限制 (默认50)
  - `before`: 获取此消息ID之前的消息
  - `after`: 获取此消息ID之后的消息
- **响应**: 200 OK

```json
{
  "conversation_id": "c12345",
  "messages": [
    {
      "message_id": "m98765",
      "conversation_id": "c12345",
      "sender_id": "12346",
      "sender_name": "Jane",
      "content": "Hello there!",
      "type": "text",
      "status": "read",
      "created_at": "2023-06-10T15:30:00Z",
      "updated_at": "2023-06-10T15:31:00Z"
    },
    {
      "message_id": "m98764",
      "conversation_id": "c12345",
      "sender_id": "12345",
      "sender_name": "John",
      "content": "Hi Jane!",
      "type": "text",
      "status": "read",
      "created_at": "2023-06-10T15:29:00Z"
    },
    // ...更多消息
  ]
}
```

### 5.3 发送消息

- **URL**: `/conversations/{conversation_id}/messages`
- **方法**: `POST`
- **描述**: 发送消息到特定对话
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `conversation_id`: 对话ID
- **请求体**:

```json
{
  "content": "Hello world!",
  "type": "text",
  "temp_id": "client-temp-id-123"
}
```

- **响应**: 201 Created

```json
{
  "message_id": "m98766",
  "conversation_id": "c12345",
  "sender_id": "12345",
  "content": "Hello world!",
  "type": "text",
  "status": "sent",
  "created_at": "2023-06-10T15:35:00Z",
  "temp_id": "client-temp-id-123"
}
```

### 5.4 创建新对话

- **URL**: `/conversations`
- **方法**: `POST`
- **描述**: 创建新的对话
- **请求头**: `Authorization: Bearer {token}`
- **请求体**:

```json
{
  "type": "private",
  "target_id": "12346"
}
```

或创建群组对话:

```json
{
  "type": "group",
  "name": "Project Team",
  "members": ["12346", "12347", "12348"]
}
```

- **响应**: 201 Created

```json
{
  "conversation_id": "c12347",
  "type": "private",
  "target_id": "12346",
  "created_at": "2023-06-10T16:00:00Z"
}
```

## 6. 群组API

### 6.1 获取群组信息

- **URL**: `/groups/{group_id}`
- **方法**: `GET`
- **描述**: 获取群组详细信息
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `group_id`: 群组ID
- **响应**: 200 OK

```json
{
  "group_id": "g7890",
  "name": "Project Team",
  "avatar": "https://example.com/avatars/group.jpg",
  "owner_id": "12345",
  "member_count": 10,
  "announcement": "Welcome to the project team!",
  "created_at": "2023-01-10T10:00:00Z"
}
```

### 6.2 获取群组成员

- **URL**: `/groups/{group_id}/members`
- **方法**: `GET`
- **描述**: 获取群组成员列表
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `group_id`: 群组ID
- **查询参数**:
  - `limit`: 结果数量限制 (默认100)
  - `offset`: 结果偏移量 (默认0)
- **响应**: 200 OK

```json
{
  "total": 10,
  "members": [
    {
      "user_id": "12345",
      "username": "johndoe",
      "nickname": "John",
      "avatar": "https://example.com/avatars/john.jpg",
      "role": "owner",
      "joined_at": "2023-01-10T10:00:00Z"
    },
    {
      "user_id": "12346",
      "username": "janedoe",
      "nickname": "Jane",
      "avatar": "https://example.com/avatars/jane.jpg",
      "role": "member",
      "joined_at": "2023-01-10T10:05:00Z"
    },
    // ...更多成员
  ]
}
```

### 6.3 更新群组信息

- **URL**: `/groups/{group_id}`
- **方法**: `PATCH`
- **描述**: 更新群组信息
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `group_id`: 群组ID
- **请求体**:

```json
{
  "name": "Project Alpha Team",
  "announcement": "Our next meeting is on Friday",
  "avatar": "base64:encoded_image_data..."
}
```

- **响应**: 200 OK

```json
{
  "group_id": "g7890",
  "name": "Project Alpha Team",
  "announcement": "Our next meeting is on Friday",
  "avatar": "https://example.com/avatars/group_updated.jpg"
}
```

### 6.4 邀请成员加入群组

- **URL**: `/groups/{group_id}/members`
- **方法**: `POST`
- **描述**: 邀请用户加入群组
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `group_id`: 群组ID
- **请求体**:

```json
{
  "user_ids": ["12349", "12350"]
}
```

- **响应**: 200 OK

```json
{
  "success": true,
  "invited_users": ["12349", "12350"]
}
```

## 7. WebSocket API

### 7.1 建立连接

- **URL**: `wss://api.example.com/ws`
- **查询参数**:
  - `token`: 用户认证令牌
- **描述**: 建立WebSocket连接，用于实时消息和状态更新

### 7.2 消息格式

所有WebSocket消息均采用JSON格式:

```json
{
  "type": "message_type",
  "data": {
    // 消息数据
  }
}
```

### 7.3 客户端发送的消息

#### 7.3.1 心跳

```json
{
  "type": "ping",
  "data": {
    "timestamp": 1623331800000
  }
}
```

#### 7.3.2 已读消息确认

```json
{
  "type": "message_read",
  "data": {
    "conversation_id": "c12345",
    "message_id": "m98765"
  }
}
```

#### 7.3.3 用户状态更新

```json
{
  "type": "status_update",
  "data": {
    "status": "away",
    "custom_message": "In a meeting"
  }
}
```

### 7.4 服务器发送的消息

#### 7.4.1 心跳响应

```json
{
  "type": "pong",
  "data": {
    "timestamp": 1623331800000
  }
}
```

#### 7.4.2 新消息通知

```json
{
  "type": "new_message",
  "data": {
    "message_id": "m98765",
    "conversation_id": "c12345",
    "sender_id": "12346",
    "sender_name": "Jane",
    "content": "Hello there!",
    "type": "text",
    "created_at": "2023-06-10T15:30:00Z"
  }
}
```

#### 7.4.3 消息状态更新

```json
{
  "type": "message_status",
  "data": {
    "message_id": "m98765",
    "conversation_id": "c12345",
    "status": "read",
    "updated_at": "2023-06-10T15:31:00Z"
  }
}
```

#### 7.4.4 联系人状态更新

```json
{
  "type": "contact_status",
  "data": {
    "user_id": "12346",
    "status": "online",
    "last_online": "2023-06-10T15:30:00Z",
    "custom_message": "Available"
  }
}
```

#### 7.4.5 群组更新通知

```json
{
  "type": "group_update",
  "data": {
    "group_id": "g7890",
    "update_type": "new_member",
    "user_id": "12349",
    "user_name": "Alice",
    "updated_at": "2023-06-10T16:20:00Z"
  }
}
```

## 8. 多媒体消息

### 8.1 上传媒体文件

- **URL**: `/media/upload`
- **方法**: `POST`
- **描述**: 上传媒体文件
- **请求头**:
  - `Authorization: Bearer {token}`
  - `Content-Type: multipart/form-data`
- **表单数据**:
  - `file`: 文件数据
  - `type`: 文件类型 (image, video, audio, file)
- **响应**: 201 Created

```json
{
  "media_id": "media12345",
  "url": "https://example.com/media/media12345.jpg",
  "type": "image",
  "size": 102400,
  "width": 800,
  "height": 600,
  "duration": null,
  "filename": "photo.jpg"
}
```

### 8.2 发送媒体消息

发送媒体消息时，使用"发送消息"API，但传递不同的消息类型和内容:

```json
{
  "type": "image",
  "content": "media12345",
  "caption": "Check out this photo!"
}
```

或:

```json
{
  "type": "video",
  "content": "media12346",
  "caption": "Our trip video"
}
```

## 9. 音视频通话

### 9.1 发起通话

- **URL**: `/calls`
- **方法**: `POST`
- **描述**: 发起音视频通话
- **请求头**: `Authorization: Bearer {token}`
- **请求体**:

```json
{
  "target_id": "12346",
  "type": "video", // "audio" 或 "video"
  "offer_sdp": "SDP string here..."
}
```

- **响应**: 201 Created

```json
{
  "call_id": "call12345",
  "target_id": "12346",
  "type": "video",
  "status": "ringing",
  "created_at": "2023-06-10T16:30:00Z"
}
```

### 9.2 接受通话

- **URL**: `/calls/{call_id}/accept`
- **方法**: `POST`
- **描述**: 接受来电
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `call_id`: 通话ID
- **请求体**:

```json
{
  "answer_sdp": "SDP string here..."
}
```

- **响应**: 200 OK

```json
{
  "call_id": "call12345",
  "status": "connected",
  "updated_at": "2023-06-10T16:31:00Z"
}
```

### 9.3 结束通话

- **URL**: `/calls/{call_id}/end`
- **方法**: `POST`
- **描述**: 结束通话
- **请求头**: `Authorization: Bearer {token}`
- **路径参数**:
  - `call_id`: 通话ID
- **响应**: 200 OK

```json
{
  "call_id": "call12345",
  "status": "ended",
  "duration": 120, // 通话时长(秒)
  "updated_at": "2023-06-10T16:33:00Z"
}
```

### 9.4 ICE候选者交换

通过WebSocket进行ICE候选信息交换:

```json
{
  "type": "ice_candidate",
  "data": {
    "call_id": "call12345",
    "candidate": "candidate:1 1 UDP 2013266431 192.168.1.100 54572 typ host"
  }
}
``` 