# Building Web Apps for the 21st Century with Elixir, Phoenix, and Ash

It's 202X and if you want to start an argument online you can't go wrong with the question "what's the tech stack to build a web app". We've got LAMP, ASP.NET, GLOW, MEAN, MERN, MEVN, BURN, RoR, and so many more. In fact I completely made up two of those and you probably didn't notice. But what if I told you forget all of those! They all promise different benefits, mature ecosystem, robust community libraries, only using JavaScript(?), and more. 

But there is a new tech stack in town, and it promises easy concurrency, highly interactive/real time content, and declarative data management. Actually it doesn't just promise these, it delivers too!

Say hello to...

EPA!

wait that's taken...

APE!

hmm no...

Anyway it's in the title, we'll be using Elixir, Phoenix, and Ash!

## A bit of background

This section isn't super relevant to the rest of this blog/tutorial, I just like talking about it. If you want to get to the meat of this sandwich skip ahead to [this section](#What-are-we-doing-here). If you want some fun trivia for your next conference, keep reading!

Have you ever used a phone? Well then you've probably interacted with some Erlang code! Erlang was created by some really smart people to solve the problems of the telecom industry. They didn't even set out to build a language, but what they landed on in the end was a functional language built on top of a highly concurrent virtual machine capable of creating truly scalable and robust applications.

Fast forward ~26 years and some other really smart people were like "Wow, Erlang is really cool, but what if it didn't look so weird and had better macros" (I don't actually know their thought process I'm just guessing). And thus Elixir was born, a functional language built on top of the same BEAM virtual machine as Erlang but with a syntax inspired by Ruby and a macro system that makes expanding the language a dream. And the best part? You can call all of that amazing Erlang code directly from Elixir!

Fast forward a bit more time (I'm not sure how long my one google search wasn't very fruitful) and Phoenix was born! A web framework built on top Elixir chalk full of amazing features! We've got server side rendering, apis, forms, interactive/real time pages with LiveView, and so much more!

Now start slamming on the breaks because we're getting to the end of our journey with the last piece of the puzzle, Ash. Have you ever used an SQL database? You've probably had to write code that amounts to `SELECT x FROM y;` I don't know about you but personally I don't like doing that. What if I misspell something, or what if my data changes and I forget to update my queries? Well lucky for us another really smart guy (the Erlang/Elixir community is full of them) created Ash, and Ash solves those problems and a lot more. Ash is declarative, meaning that instead of just being an interface you use to intreact _with_ your data Ash lets you _describe_ what your data looks like and then offers a robust set of tools for interacting with your data in a way that stops you from shooting yourself in the foot. Ash also doesn't have to be used with a Database at all making it a breeze for rapid iteration and experimentation before you have all the details ironed out. Essentially Ash takes all of the things that are great about Phoenix and Elixir as a whole and applies it to data. Now that's neat!

## What are we doing here?

Okay so fun facts and hype aside, what are we building today? If you've explored other frameworks you've probably come across the [TODO MVC](https://todomvc.com/). If you haven't basically the idea is that at some point everyone in the tech industry decided "you know what is a good way to judge a framework? Seeing how easy it is to make a todo list!" So following in this tradition we will also be making a todo app as well, but with a twist! Our app will have a few neat features:

1. Todo lists can be created and shared with others
2. Our lists will be persistent and stored in a database
3. We will be able to see people update the list in real time

And you know what? It's actually going to be really easy!

If you want to check out the finished product you can see the live version [here](https://todoi.sh/).

> Before we get started I just want to note that this isn't meant to be an introduction to Elixir tutorial. At times I will dig deeper into some of the cool things that we are doing, but I won't be going into much depth about the basics. It may help to do some other tutorials online before going through this tutorial, but for those ambitious enough to use google when you come accross some syntax you don't understand you will probably be fine!

## The setup

Firt things first you need to have Elixir and Erlang installed. Erlang will probably tag along with your Elixir installation but check out [this page](https://elixir-lang.org/install.html) for instructions.

Got Elixir installed? Good! Don't know if you do? Try running `iex` in your terminal and if you're met with a REPL then you do, good job!

> To exit the repl type `ctrl-c ctrl-c`. Easier than exiting Vim!

Now install the Phoenix app generator by running the following in your terminal:

```bash
mix archive.install hex phx_new
```

Assuming that didn't throw any errors now we're good to go! In your terminal navigate to an especially cozy directory and run the following command to create your phoenix application:

```bash
mix phx.new ./todoish --no-ecto --no-gettext --no-mailer
```

You'll be prompted to install the dependencies, type `Y`.

It may take a little bit but once it finishes you'll be met with the following text:

```bash
We are almost there! The following steps are missing:

    $ cd todoish

Start your Phoenix app with:

    $ mix phx.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phx.server
```

So let's be good obedient programmers and do it!

Run the following:

```bash
cd todoish
mix phx.server
```

You should now be able to navigate to http://localhost:4000/ and see your Phoenix project up and running, congrats! You can now head over to [Y Combinator](https://www.ycombinator.com/) and apply for funding for your budding startup.

## Our home page

Go ahead and open up your project in your favorite text editor. Take a minute to explore all the files Phoenix made for you, don't worry I'll be here when you get back. Back already? Kind of overwhelming right? Don't worry! Let's demystify some of these for you.

Let's start with `mix.exs`. This file is your Elixir equivalent of `package.json` and `Gemfile` in Node and Ruby respectively. You'll notice this that this file has the extension `exs` instead of `ex`. This is because Elixir can be either compiled or run as a script, and a`exs` is telling Elixir "hey, this is a script don't compile this." 

Now lets look inside the file, there is a lot going on here! The main thing to focus on is this section:

```elixir
  defp deps do
    [
      ...
    ]
  end
```

If you didn't guess already this is where you add all of your dependencies, Phoenix went ahead and added all the ones we need for now so no action needed!

Now let's check out the `lib` directory. In it you will find two more directories, `todoish` and `todoish_web`. The `todoish` directory will hold the code related to the running the application itself and all of your bussiness logic. 

The directory `todoish_web` is pretty self explanatory, it holds all the web stuff including your router, controllers, and the pages that the user will actually see. And this is where we'll start!

With your server still running open up `lib/todoish_web/templates/page/index.html.heex` and just delete everything, go wild! You'll notice that the web page immedietly updated and now greets you with a blank screen (minus the top bar). Yeah that's right, Phoenix even does HMR out of the box.

Let's add some content back, in `index.html.heex` add the following code:

```html
<section>
    <h1>Todoish</h1>
    <h2>Share todos, grocery lists, or anything else!</h2>
</section>
```

Once again you'll see your home page instantly update in the browser!

The especially observant readers out there will have noticed that this isn't any old html file, it's an `heex` file. Think of these as superpowered HTML files where their superpower is the ability to run Elixir code in the file itself. Let's give it a go! Add this code to your file under the headers:

```heex
<span>
    1 + 1 = <%= 1 + 1 %>
</span>
```

With any luck you will now see the text "1 + 1 = 2" on your webpage. Those special tags `<%=` and `%>` are escape hatches into the Elixir world. Everytime a user navigates to this page Phoenix will take this file, run all the code between these tags, throw the result into the template, and then serve the final HTML file to the user.

Let's do something a little more complicated, add this to the page:

```heex
<ol>
  <%= for num <- 1..10 do %>
    <li><%= num %></li>
  <% end %>
</ol>
```

You should now see an ordered list of numbers! You'll notice that for `<% end %>` we used `<%` instead of `<%=`. The difference between the two are that `<%=` says "evaulate this expression and show the result". We don't want to show the "result" of `end` so we use `<%`.

With all of that out of the way now we need a way for users to create a new todo list, and to do that we'll use a simple form. So delete all of that code from before and let's add:

```heex=
<%= form_for @conn, "/",
  [as: :new_list],
  fn f ->
%>
  <%= text_input f, :title, [placeholder: "My awesome list!"] %>
  <%= textarea f, :description, [placeholder: "My awesome list's description!"] %>
  <%= submit "Create a Todoish!" %>
<% end %>
```

Now you'll see a form on the page! But what's going on here? 

A the top of this code you see `form_for`. Like pretty much everything in Elixer, `form_for` is a function and it takes the current connection `@conn`, the "action", some options, and then a function to run that will build the form. If you want more info check out the [Phoenix docs](https://hexdocs.pm/phoenix_html/Phoenix.HTML.Form.html#form_for/4).

Next we call three more functions, `text_input`, `textarea`, and `submit` which take our form `f`, a name, and some extra options.

> If you're new to Elixir you may be asking "where are the parentheses in these function calls?" In Elixir you don't actually have to include them in a function call! But everyone does... except when we don't. Trust me you'll get used to it.

If you're familiar with HTML forms then the above code is roughly equivalent to:

```html
<form action="/">
    <input type="text" name="title" placeholder="My awesome list!" />
    <textarea name="description" placeholder="My awesome list's description" />
    <input type="submit" value="Create a Todoish!" />
</form>
```

In fact if you inspect the elements on your page this is basically what you'll see.

Now let's see what happens when we fill out the form. Did you get the error `no route found for POST / (TodoishWeb.Router)`? Good! Well, not good but expected! We need to set up a route to accept this request and then a controller to handle the request. Let's do that!

## Dealing with the form data and setting up Ash

### Adding a new route

First let's fix that error. Open up `lib/todoish_web/router.ex` and find the section that looks like:

```elixir
scope "/", TodoishWeb do
    pipe_through :browser

    get "/", PageController, :index
end
```

Try to read through this code and the surrounding code. You may not totally understand what's going on here but you probably have a decent idea. The routes in this section are scoped to "/", meaning that it will try and match routes starting with "/" with routes within this scope. 

We also see `pipe_through :browser`, and conveiently right at the top of the file we see:

```elixir
pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TodoishWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
end
```
And again you may not know exactly what it's doing but you can pr obably guess. `pipe_through :browser` is taking the request, running it through the `:browser` pipeline, and adding to/modifying the request as we go. Luckily we don't have to touch any of this!

Under `get "/", PageController, :index` let's add `post "/", PageController, :new`. So now when we make a `POST` request to "/" the router will try and call the `new` function from the `PageController` module. So let's add that function!

Open up `lib/todoish_web/controllers/page_controller.ex` and create a new function `new`:

```elixir
def new(conn, params) do
    IO.inspect(params)
    render(conn, "index.html")
end
```

Make sure all of the modified files are saved, and try to submit the form in your browser again. No error (hopefully)! And what's more if you look in your terminal you should see something like:

```elixir
%{
  "_csrf_token" => "KGM5Pz0yHBonCDQRPSp-XAR8NwE5aAFbo4nUrCrYvIuNH_70iLXPP_o0",
  "new_list" => %{"description" => "arst", "title" => "arst"}
}
```

So now we have successfully created a form for a user to fill out and gotten that data from the frontend to the backend where we can actually do something with it. But what are we going to do?

### Setting up Ash

Ash is a multi-purpose modeling framework, meaning you can use it to model the behavior between various parts of your application. For this project we're going to use it to model the behavior between our application and our data. So when it comes to creating lists and list items we're going to use Ash for all of that. Trust me when I say you will be blown away with how easy Ash will make this.

The first thing we need to do is add Ash and AshPhoenix as a dependency. We're also adding nanoid that we will use to create unique URL friendly IDs. In `mix.exs` add the following to your `deps` and run `mix deps.get`:

```elixir
defp deps do
    [
        ...
        {:ash, github: "ash-project/ash", override: true, branch: "main"},
        {:ash_phoenix, github: "ash-project/ash_phoenix", override: true, branch: "main"},
        {:nanoid, "~> 2.0"}
    ]
end
```

Once that's done we can start adding the code for the three pieces Ash needs to get going: the API, Registry, and Resources.

Create the file `lib/todoish/entries.ex` and add the following code to the file:

```elixir
defmodule Todoish.Entries do
  use Ash.Api

  resources do
    # We will add something here later
  end
end
```

This is our Ash Api! We will use it to create, destroy, and interact with our data. Now we need to create a registry to hold all of our data.

Create the directory `lib/todoish/entries` and inside that directory create the file `registry.ex` and add the following code to the file:

```elixir=
defmodule Todoish.Entries.Registry do
  use Ash.Registry, extensions: [Ash.Registry.ResourceValidations]

  entries do
      # We will add something here soon!
  end
end
```

Now for the part we've been waiting for, our Resources! Create the directory `lib/todoish/entries/resources` and inside this directory create two more files: `item.ex`, and `list.ex`.

Inside `list.ex` let's create add some code:

```elixir=
defmodule Todoish.Entries.List do
  use Ash.Resource

  actions do
    defaults [:create, :read, :update, :destroy]

    create :new do
      accept [:title, :description]
    end
  end

  attributes do
    # Automatically add a UUID for the resource
    uuid_primary_key :id

    # Automatically add insert/update timestamps
    timestamps()

    # The title of the list
    attribute :title, :string do
      default "A Todoish List"
      allow_nil? false
    end

    # The description of the list
    attribute :description, :string do
      default "Add items to get started!"
      allow_nil? false
    end
    
    # The unique URL friendly ID for the list
    attribute :url_id, :string do
      allow_nil? false
    end
  end
end
```

There are two main things to look at here, the actions and the attributes. In the actions we declare that we want to the default actions of `create`, `read`, `update`, and `destroy` as well as a new action that we called `new` accepts a title and a description.

Then in our resources we declare some attributes. We want every list to have a unique id via `uuid_primary_key :id`, and to have timestamps of when it was created/updated via `timestamps()`. We also add some custom attributes, the list should have a title of type string with a default value, and a description of type string also with a default. We also don't want these to be blank so we set `allow_nil? false` for both. 

Now whenever a list is created Ash will do the work for us and generate both the unique ID and timestamps, and Ash will also make sure that not only are our attributes not `nil` but also if they are will automatically set them to the default values. This is great because we both don't have to write this code ourselves and also don't have to remember to do it accross our code if we create lists in multiple places!

Now that our resource is defined let's fill in that info we left blank in `lib/todoish/entries/registry.ex`

```elixir=
defmodule Todoish.Entries.Registry do
  use Ash.Registry, extensions: [Ash.Registry.ResourceValidations]

  entries do
    entry Todoish.Entries.List # Here it is!
  end
end
```

and in `lib/todoish/entries.ex`

```elixir=
defmodule Todoish.Entries do
  use Ash.Api

  resources do
    registry Todoish.Entries.Registry
  end
end
```

And that's it! Ash is all set up (for now).

So now let's update our controller to actually do something with the new form.

Go back into `lib/todoish_web/controllers/page_controller.ex` and add the code below:

```elixir=
defmodule TodoishWeb.PageController do
  use TodoishWeb, :controller

  # 1
  require Ash.Query

  ...

  # 2 ──────────┐
                v
  def new(conn, %{"new_list" => params}) do
    Todoish.Entries.List
    |> AshPhoenix.Form.for_create(:create,
      api: Todoish.Entries,
      transform_params: fn params, _ ->
        params =
          if params["title"] in ["", nil] do
            Map.put(params, "title", "A Todoish List")
          else
            params
          end

        params =
          if params["description"] in ["", nil] do
            Map.put(params, "description", "Add items to get started!")
          else
            params
          end

        Map.put(params, "url_id", Nanoid.generate())
      end
    )
    |> AshPhoenix.Form.validate(params)
    |> AshPhoenix.Form.submit()
    |> case do
      {:ok, result} ->
        IO.inspect(result)
        redirect(conn, to: "/#{result.url_id}")

      {:error, form} ->
        IO.inspect(form)

        conn
        |> put_flash(:error, "Uh-oh! Something went wrong. Please try again!")
        |> render("index.html", form: form)
    end
  end
end
```

First we bring `Ash.Query`'s macros into scope so we can actually create our resources, then we modify our `new` function signature to accept the form under the key `"new_list"`. Now we can finally take our form and make a new list from it.

Now let's take a look at the following:

```elixir=12
Todoish.Entries.List
|> AshPhoenix.Form.for_create(:create,
  api: Todoish.Entries,
  transform_params: fn params, _ ->
    params =
      if params["title"] in ["", nil] do
        Map.put(params, "title", "A Todoish List")
      else
        params
      end

    params =
      if params["description"] in ["", nil] do
        Map.put(params, "description", "Add items to get started!")
      else
        params
      end

    Map.put(params, "url_id", Nanoid.generate())
  end
)
```

We start with `Todoish.Entries.List`, the resource we want to create, and pass it into `AshPhoenix.Form.for_create` which will take our raw form data and turn it into a form that Ash can use to both validate and create the resource. We pass in three paramters to this function, the action `:create` (if you look back our list resource you'll see we defined this as a default action), the API `Todoish.Entries`, and a function to transform the form data.

After reading through the above code a couple times it should pretty obvious what is going on, we're creating a new Ash form for our resource, we're using the create action, and we're taking the raw pamaramters from our submitted form and transforming them a bit. Namely we make sure none of the fields are empty, and if they are we add a default, and finally we add a `url_id` parameter that we'll use for the sharable list ID.

After the Ash form is created we simply continue to pass our form down the pipeline to validate it, submit it, and redirect the user to the new list!

Now let's fire up our server again and make a new list!

`ERROR: no route found for GET /<some id>`.

Another error, good! Phoenix is correctly telling us we don't have a route for this list and it's right, we didn't make one! So let's do that now.

## Creating a LiveView & Fetching Resources

Now we're going to get into the cool part of our app, the interactive realtime list that you and your friends can use to organize all your cool parties. 

If you're familiar with other frontend frameworks like React, Vue, Svelete, etc. then LiveView should look pretty familiar. We'll set up a render function to create the view that users see, add events to do things when users interact with our, and update the state of the app based on those events. But the cool thing about LiveView and Phoenix is that we can do it all on the server in real time.

Let's start out by fixing that error and telling Phoenix about our new route. In `lib/todoish_web/router.ex` add the following:

```elixir
  scope "/", TodoishWeb do
    ...
    
    live "/:url_id", Live.List
  end
  ```
  
Unlike our other routes where we give the router a method, path, module, and functon to call here we are are using `live` to tell the router this is a LiveView, what path to mount it on, and what module the code exists in. So as you probably guessed the next step is to create that module. 

Create the directory `lib/todoish_web/live` and inside that directory create the file `list.ex`.

Inside `list.ex` add the following code:

```elixir=
defmodule TodoishWeb.Live.List do
  use Phoenix.LiveView
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
    <h1>The list ID is <%= @url_id %></h1>
    """
  end

  def mount(%{"url_id" => url_id}, _sessions, socket) do
    {:ok, assign(socket, :url_id, url_id)}
  end
end
```

This is the basic structure of a LiveView. We have a `mount` function that accepts information we can use to set up the intial state of the LiveView, and we have a `render` function that accepts the assigns from the socket and returns a template. If you're interested in digging deeper you can read more about the LiveView lifecycle [here](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#module-life-cycle).

For this basic example we take the `url_id` from the URL and assign it to the socket. Then we are able to use that assign in our render function and display it to the user. Now if you now create a list you will no longer see an error and instaed will see the message `The list ID is <some random id>`!

Now that we have the route working we can actually build out the functionality of the page! As stated above `mount` is where we set up the LiveView so this is the perfect place for us to get the list and show it to the user. 

So let's add the following to the to `mount` to fetch the list with the `url_id` passed to the LiveView:

```elixir
...

require Ash.Query

...

def mount(%{"url_id" => url_id}, _sessions, socket) do
    list =
      Todoish.Entries.List
      |> Ash.Query.filter(url_id == ^url_id)
      |> Ash.Query.limit(1)
      |> Ash.Query.select([:title, :id, :url_id, :description])
      |> Todoish.Entries.read_one!()

    if list != nil do
      {:ok, assign(socket, :list, list)}
    else
      {:ok, push_redirect(socket, to: "/")}
    end
end
```

Hopefully again this code is pretty self explanatory. 

First using `Ash.Query` we construct a query where we fetch all lists where the `url_id` of the list is equal to the `url_id` of the URL, limit the results to just one list (really there should only ever be one though), select the `:title`, `:id`, `:url_id`, and `:descripton` attributes of the list so they are available on the resulting list. Then we finally fetch the result of our query with our API using `Todoish.Entries.read_one!()`.

Once we have the result we check to see if the list exists, and if it does we assign the list to the socket, if it doesn't we redirect the user to the homepage where they can make a new list.

Now starting from homepage again make a new list. As you probably guessed we get an error, but if you read the error you'll see some useful information:

```
Another common cause of this is failing to add a data layer for a resource. You can add a data layer like so:

`use Ash.Resource, data_layer: Ash.DataLayer.Ets`
```

And this is exactly our problem! We've successfully set up our resources in Ash but we never told Ash _how_ to handle our resources once they're created. Luckily Ash has some solutions ready for us to use!

### Adding an Ash DataLayer

A data layer is exactly what it sounds like, it's layer within your program that Ash uses to store, and fetch your resources. Ash comes with an [ETS](https://elixirschool.com/en/lessons/storage/ets) data layer which is perfect for prototyping and rapid iteration. Our data won't persist after the program stops but with just a few additional lines of code down the line we'll trivially add Postgres support.

In `lib/todoish/entries/resources/list.ex` make the following change:

```elixir
use Ash.Resource, data_layer: Ash.DataLayer.Ets
```

And change the render function in `lib/todoish_web/live/list.ex` to the following as well so we can see it's fetching the list:

```elixir
def render(assigns) do
    ~L"""
    <h1>The list title is <%= @list.title %></h1>
    """
end
```

And that's it! You should now see the title of your list displayed in all of it's plain HTML glory.

### Adding another Resource

Users can now create new lists and we can query that list and display it to a user, but a todo list without any items isn't very useful, so let's add some items!

Before we can start building out the UI and functionality for adding items we need to create and register the item resource so let's get right to it. 

Create the file `lib/todoish/entries/resources/item.ex` and add the following:

```elixir=
defmodule Todoish.Entries.Item do
  use Ash.Resource, data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:create, :read, :update, :destroy]
  end

  attributes do
    uuid_primary_key :id

    timestamps()

    attribute :title, :string do
      allow_nil? false
    end
  end

  relationships do
    belongs_to :list, Todoish.Entries.List
  end
end
```

Most of this should look really familiar, but we've added something new to the bottom of the resource, `relationships`. Not only does Ash let us define attributes to resources but it also lets us declare what relationships resources have with other resources. In this case we are saying that items belong to a list resource which will be found under the `:list` field.

Now let's head on over to `lib/todoish/entries/resources/list.ex` and define the other half of this relationship:

```elixir
relationships do
    has_many :items, Todoish.Entries.Item
end
```

Here we say that every list can have many item resources which can all be found under the `items` field on the list.

Now all we need to do is register our item resource in `lib/todoish/entries/registry.ex` and we're off to the races again!

```elixir
  entries do
    ...
    entry Todoish.Entries.Item
  end
```

### Building out the LiveView

