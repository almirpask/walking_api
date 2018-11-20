# Dog Walking API

endpoints:

    GET /api/v1/dog_walkings

Returns all dog_walkings

    GET /api/v1/dog_walkings?next_walks=true

Returns all pending or ongoing records in the next few days


    POST /api/v1/dog_walkings

Creates a new dog walking

    PUT /api/v1/dog_walkings/:dog_walking_id/start_walk

To start a new walk

    PUT /api/v1/dog_walkings/:dog_walking_id/finish_walk

To finish a started walk

    GET /api/v1/dog_walkings/:id

To see the total time taken up to the moment

# Runing

To run this project you need:

* `rails 5.2.1`
* `ruby 2.5.1`

After clone the project open a terminal on the project root forlder and run:

* `bundle install`
* `rails db:create`
* `rails db:migrate`