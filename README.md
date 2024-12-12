# Ruby URL Shortener and Analytics Platform

This project is a comprehensive URL shortener and analytics platform built using Ruby on Rails. It includes features such as URL shortening, custom aliases, expiration functionality, and click tracking.

## Table of Contents
- [Features](#features)
- [Setup](#setup)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Testing](#testing)
- [Contributing](#contributing)
- [License](#license)

## Features
- Shorten URLs
- Generate custom aliases for URLs
- Expiration dates for URLs
- Track clicks and other analytics data
- User authentication for managing URLs

## Setup
1. **Install Rails and create a new Rails application:**
    ```sh
    gem install rails
    rails new ruby_url_shortener
    cd ruby_url_shortener
    ```

2. **Set up the database:**
    ```sh
    rails db:create
    rails db:migrate
    ```

## Usage
1. **Generate models:**
    ```sh
    rails generate model Url original_url:string short_url:string user:references clicks_count:integer expires_at:datetime
    rails generate model User email:string password_digest:string
    rails generate model Click url:references user:references
    rails db:migrate
    ```

2. **Set up associations in models:**
    ```ruby
    # app/models/url.rb
    class Url < ApplicationRecord
        belongs_to :user
        has_many :clicks
    end

    # app/models/user.rb
    class User < ApplicationRecord
        has_secure_password
        has_many :urls
        has_many :clicks
    end

    # app/models/click.rb
    class Click < ApplicationRecord
        belongs_to :url
        belongs_to :user, optional: true
    end
    ```

3. **Implement URL shortening logic:**
    Add methods in the Url model to generate short URLs and handle custom aliases.

4. **Add expiration functionality:**
    Add an `expires_at` column to the Url model and implement logic to check for expiration.

5. **Create API endpoints:**
    Implement controllers and routes for creating, retrieving, and managing URLs.

6. **Track analytics:**
    Track clicks and other analytics data using the Click model.

7. **Set up views and controllers:**
    Create views for URL creation and management and implement controllers to handle requests.

8. **Add authentication:**
    Implement user authentication using bcrypt for managing URLs.

## API Endpoints
- `POST /urls` - Create a new short URL
- `GET /urls/:short_url` - Retrieve the original URL
- `PATCH /urls/:id` - Update an existing URL
- `DELETE /urls/:id` - Delete a URL
- `GET /urls/:id/clicks` - Get analytics data for a URL

## Testing
Write unit tests and integration tests to ensure the application works as expected.

## Contributing
Contributions are welcome! Please fork the repository and submit a pull request.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
