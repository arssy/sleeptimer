# SleepTimer

![Ruby on Rails](https://img.shields.io/badge/Ruby%20on%20Rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)

## Description
An App that helps users monitor their sleep patterns while staying connected with friends.

## Features
- Start & stop sleep timer
- Follow & unfollow other users
- See followed user sleep histories

## Tech Stack
- **Ruby on Rails** (Version 8.0.1)
- **PostgreSQL** (16.4)
- **Rspec**
- **Swagger**
- **JSON:API**

## Installation

### Prerequisites
- Ruby (version 3.3.6)
- Rails (version 8.0.1)
- PostgreSQL (16.4)

### Setup
1. Clone the repository:
   ```sh
   git clone https://github.com/arssy/sleeptimer.git
   cd sleeptimer
   ```
2. Install dependencies:
   ```sh
   bundle install
   ```
3. Configure database configuration in config/database.yml
4. Setup the database:
   ```sh
   rails db:setup
   ```
5. Seed the database:
   ```sh
   rails db:seed
   ```
6. Run the application:
   ```sh
   rails server
   ```

## Testing
To run tests, use:
```sh
rspec
```

## API Documentation
Swagger: http://localhost:3000/api-docs