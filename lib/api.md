# Todo API

URL: https://todoapp-api.apps.k8s.gu.se

## Todo Format

A todo has the following format:

{
  id: "ca3084de-4424-4421-98af-0ae9e2cb3ee5",
  title: "Must pack bags",
  done: false
}

## End points

### GET /todos
Fetch a list of todos

### POST /todos
Add todo.

Takes a Todo as payload (body). Remember to set the Content-Type header to application/json.

Will return the entire list of todos, including the added Todo, when successful.

### PUT /todos
Update todo with :id

Takes a Todo as payload (body), and updates title and done for the already existing Todo with id in URL.

### DELETE /todos




