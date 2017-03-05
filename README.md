# Todo-Backend in LittleBoxes

[![Build Status](https://travis-ci.org/manuelmorales/todo-backend-little-boxes.svg?branch=master)](https://travis-ci.org/manuelmorales/todo-backend-little-boxes)

This is a simple implementation of the
[Todo-Backend](https://www.todobackend.com/) API spec using
[LittleBoxes](https://github.com/manuelmorales/little-boxes).

* Live Heroku app: [https://todo-backend-little-boxes.herokuapp.com/todos](https://todo-backend-little-boxes.herokuapp.com/todos).
* Todo-Backend tests: [https://www.todobackend.com/specs/index.html?https://todo-backend-little-boxes.herokuapp.com/todos](https://www.todobackend.com/specs/index.html?https://todo-backend-little-boxes.herokuapp.com/todos).
* Todo-Backend client: [https://www.todobackend.com/client/index.html?https://todo-backend-little-boxes.herokuapp.com/todos](https://www.todobackend.com/client/index.html?https://todo-backend-little-boxes.herokuapp.com/todos).

Installation:

```bash
git clone git@github.com:manuelmorales/todo-backend-little-boxes.git
cd todo-backend-little-boxes
bundle
```

Run with

```bash
./cli start
```

Or explore a live representation of the app with:

```bash
./cli console
> box = Todo::Box.new
```

Run the tests with:

```bash
./cli test
```
