# Escape The Dungeon
Repository for final project. Created by Michael Heckman, Cameron Slash, and Lloyd Rowe.

## Instructions
Use the arrow keys or wasd to move around. Aim and left-click with the mouse to attack enemies. Stun enemies by running into them with your bow out. Open your inventory with E. Pick up items on the ground by attacking them/running into them with a bow. Win the game by defeating all the monsters.

## Project Report

### Reflection 

For this second iteration, we didn't hit very many issues in what we were working on, so things went mostly smoothly. Things like items and picking them up, as well as the inventory, were interesting and fun to try to implement, and not very difficult at all given that they were both sort of new concepts for us. There was debate on *how* to implement those concepts, but we've agreed on the best way to do it and think it went well.

DOCUMENTATION OF STARS:
Particles: Particles are emitted when a player picks up a key or potion, an arrow collides with an enemy or the wall, and when running into an enemy with the bow.
Pop in the HUD: AnimationPlayer is used in the HUD when both opening/closing the inventory and switching weapons, giving it a little pop.
AI Control: Enemies are controlled by an AI.
Pause Menu: Opening the inventory pauses the game and allows for resuming, returning to the title screen, or restarting the game.
Juciness: The camera shakes when the player is attacked, particles are emitted on occasion, and animations play in the HUD for different scenarios. There is also music and sound.

We personally believe that this project/iteration deserves an A, based on the following requirements:

### Evaluation
- [X] D-1: The repository link is submitted to Canvas before the project deadline.
- [X] D-2: The repository contains a <code>README.md</code> file in its top-level directory.
- [X] D-3: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of M or less.
- [X] C-1: Your repository is well-formed, with an appropriate <code>.gitignore</code> file and no unnecessary files tracked.
- [X] C-2: Your release is tagged using <a href="https://semver.org/">semantic versioning</a> where the major version is zero, the minor version is the iteration number, and the patch version is incremented as usual for each change made to the minor version, and the release name matches the release tag.
- [X] C-3: You have a clear legal right to use all incorporated assets, and the licenses for all third-party assets are tracked in the <code>README.md</code> file.
- [X] C-4: The <code>README.md</code> contains instructions for how to play the game or such instructions are incorporated into the game itself.
- [X] C-5: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of T or less.
- [X] C-6: The release demonstrates the core gameplay loop: the player can take actions that move them toward a goal.
- [X] B-1: The <code>README.md</code> file contains a personal reflection on the iteration and self-evaluation, as defined above.
- [X] B-2: The game runs without errors or warnings.
- [X] B-3: The source code and project structure comply with our adopted style guides.
- [X] B-4: Clear progress has been made on the game with respect to the project plan.
- [X] A-1: The source code contains no warnings. All warnings are properly addressed, not just ignored.
- [X] A-2: The game includes the conventional player experience loop of title, gameplay, and ending.
- [X] A-3: Earn <em>N</em>*&lceil;<em>P</em>/2&rceil; stars, where <em>N</em> is the iteration number and <em>P</em> is the number of people on the team.
- [ ] ⭐ Include a dynamic (non-static) camera
- [ ] ⭐ Incorporate parallax background scrolling
- [ ] ⭐ Use paper doll animations
- [ ] ⭐ Use an <code>AnimationTree</code> with either blend spaces (3D) or an animation state machine (2D)
- [ ] ⭐ Incorporate smooth transitions between title, game, and end states, rather than jumping between states via <code>change_scene</code>
- [ ] ⭐ Support two of the following: touch input, mouse/keyboard input, and gamepad input
- [ ] ⭐ Allow the user to control the volume of music and sound effects independently.
- [X] ⭐ Incorporate juiciness and document it in the <code>README.md</code>
- [X] ⭐ Use particle effects
- [ ] ⭐ Use different layers and masks to manage collisions and document this in the <code>README.md</code>
- [X] ⭐ Incorporate pop into your HUD or title screen using <code>Tween</code> or <code>AnimationPlayer</code>
- [X] ⭐ Include an AI-controlled character
- [X] ⭐ Add a pause menu that includes, at minimum, the ability to resume or return to the main menu
- [ ] ⭐ The game is released publicly on <code>itch.io</code>, with all the recommended accompanying text, screenshots, gameplay videos, <i>etc.</i>


## Third-Party Assets
- [Dungeon Music by Samuelbcf7](https://freesound.org/people/Samuelbcf7/sounds/578733/), licensed under [Creative Commons 0 License](http://creativecommons.org/publicdomain/zero/1.0/)
- [death monster sound 2 by ibm5155](https://freesound.org/people/ibm5155/sounds/174912/), licensed under [Creative Commons Attribution License](https://creativecommons.org/licenses/by/3.0/)
- [creature sounds » monster pain by soundmast123](https://freesound.org/people/soundmast123/sounds/571974/), licensed under [Creative Commons Attribution License](https://creativecommons.org/licenses/by/3.0/)
- All textures created by Michael Heckman.