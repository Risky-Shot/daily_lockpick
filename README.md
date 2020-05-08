# LOCK PICK SYSTEM

THIS SCRIPT IS FOR DEVELOPERS ONLY!!

IT WON'T DO ANYTHING BY ITSELF!!

Design by: [teolitto](https://codepen.io/teolitto/pen/vLEEbY)

[SHOWCASE](https://imgur.com/JByE6zm)

## FUNCTIONS

- HTML based lockpicking system
- Option to make unlocking harder / easier
- Option to set a default difficulty (config.lua)
- On failed attempt removes bobbypin from user's inventory
- /testing to see how it works [USE ESC TO CLOSE IT]
- Debug System for clear testing information in client console

## USAGE

DO NOT RENAME THE SCRIPT!
THE NAME MUST REMAIN THE SAME FOR JAVASCRIPT TO WORK!

To add it to any other script simply use:

````lua
TriggerClientEvent("daily_lockpick:startPicking", function(cb)

    if cb then
        -- If successful do X
    else
        -- If unsuccesful do Y
    end

end, 100, 20, 20, 4)
````

Values at the end of the function are in the following order:

````
pinHp = Pin's Health,
pinDmg = Damage on failed click,
maxDist = Max Distance away from solution to start turning,
solvePadd = Padding, acceptable distance from solution as solution
````

Alternatively you can leave those values blank and the script will use default values set up in `Config.lua`

## REQUIREMENTS

You need to add `bobbypin` and `screwdriver` to your database.

Rather than making an SQL file, simply run this code:

````sql

USE `es_extended`;

INSERT INTO `items` (`name`, `label`, `weight`) VALUES
    (`bobbypin`, "Bobbypin", 1),
    (`screwdriver`, "Screwdriver", 1)
;

````

You need both `bobbypin` and `screwdriver` in your inventory to start lockpicking!

## TO DO

- Add more options for difficulty change
- Add easier asset replacement (currently all in css)
- Test 360* system
- Add a usable item hub system
- Option to use on esx_doorlock
- Option to add own doors in config.lua

# CREDITS

Design credits as well as the most of the javascript work goes to [teolitto](https://codepen.io/teolitto/pen/vLEEbY).

Entire FiveM porting and additional work has been completed by [D3v](https://github.com/deviljin112) part of [DailyRP](https://github.com/DailyRP)
