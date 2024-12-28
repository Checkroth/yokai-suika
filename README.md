# yokai-suika
Suika Game implementation in Godot 4.3, directed by my seven year old son

# Direction

This game is a clone of "Suika Game".

The principal artist and director of its creation is my son (at the time of writing this, seven years old).

# Architecture

Part of the goal of this project is discovery work to find a way to have "repeatable elements" in a godot game.

There are a few inspirations for my approach, the largest being [Godotneer's video on Godot Data Models](https://www.youtube.com/watch?v=4vAkTHeoORk).

The primary implementation for this game is very simple. Items can be dropped based on a click from the user, if they collide with others of the same type they combine in to the next stage of item.

The goal of the architecture is to implement this functionality *only once*. The godotneer video outlines a clean way to manage repeatable concepts using custom Resources in godot, which is what this game does.

The big key element missing from that video is: How do we keep the "scene" for a resource configured on that resource, while also using the configuration found in that resource in the scene implementation itself?

This is achieved in this example by creating a constructor in the resource itself which returns the instantiated scene *and* gives that scene instance access to the resource.

1. A Custom Resource contains the configurable elements of each droppable item in the game
2. That custom resource contains a reference to the packed scene for the game itself, giving us the ability to instantiate the right version of the scene (primarily, the correct sprite & collision shape)
3. The scene is its own custom class, with major implementations (collision detection & the fusion logic branching from that), and is extended by each implementation.
4. The game itself deals in resources -- we use them to find display names, scale scenes, randomize & draw the "next" droppable. We keep anything about the functionality that is not directly related to the scene in the resource, so that we can refer to those configurations without having a live instance of the scene on hand.
5. There is NO connection from scene to resource at the configuration stage -- this prevents a circular dependency. It also means that we have to create an implicit dependency in the scene: The scene depends on variables in the resource, and there's no jump available in the godot editor to know what resource will actually set this scene up. This is a major deficiency that can only be "Solved" by maintaining a project structure. If it were a massive AAA project with hundreds of engineers, I would consider a merge-blocking linter for a matching scene and resource a must.