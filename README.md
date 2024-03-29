


# Chat System 

its a messageing system with a unque reqirement




## requirement 
- docker compose 
- vm.max_map_count = 262144 (elastic-search)
- internet connection :) 
## Installation

Install my-project with npm

```bash
  git clone https://github.com/s3dawyXD/chat-system.git
  cd chat-system
  docker compose up --build -d
  docker exec message-app db:create
  docker exec message-app db:migrate
```
    
## API Reference

[Postman Collection](https://www.postman.com/payload-observer-15011742/workspace/task)

## Notes
chats and messages will not be created unless its called 3 times