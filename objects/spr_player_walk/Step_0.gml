// Player Object Create Event

// Constants
walksp = 4;
grav = 0.5;
max_fall = 10;
jump_height = 15;

// Variables
hsp = 0;
vsp = 0;

// Flags
is_jumping = false;

// Animation
sprite_index = -1;
image_speed = 0;

// Player Object Step Event

// Input
var move = keyboard_check(vk_right) - keyboard_check(vk_left);
var jump_pressed = keyboard_check_pressed(vk_space);

// Horizontal Movement
hsp = move * walksp;

// Horizontal Collision
if (place_meeting(x + hsp, y, oWall))
{
    while (!place_meeting(x + sign(hsp), y, oWall))
    {
        x += sign(hsp);
    }
    hsp = 0;
}

// Vertical Movement
vsp = min(vsp + grav, max_fall);

// Jumping
if (place_meeting(x, y + 1, oWall))
{
    is_jumping = false;
    
    if (jump_pressed)
    {
        vsp = -jump_height;
        is_jumping = true;
    }
}
else
{
    is_jumping = true;
}

// Vertical Collision
if (place_meeting(x + hsp, y + vsp, oWall))
{
    while (!place_meeting(x + hsp, y + sign(vsp), oWall))
    {
        y += sign(vsp);
    }
    vsp = 0;
    
    if (is_jumping)
    {
        is_jumping = false;
    }
}

// Update Position
x += hsp;
y += vsp;

// Animation
if (hsp != 0)
{
    sprite_index = spr_player_walk; // Replace with your walk sprite
    image_speed = 0.5;
}
else if (is_jumping)
{
    sprite_index = spr_player_jump; // Replace with your jump sprite
    image_speed = 0;
}
else
{
    sprite_index = spr_player_idle; // Replace with your idle sprite
    image_speed = 0;
}

// Player Object Draw Event

// Draw the player sprite at the current position
draw_sprite(sprite_index, 0, x, y);
