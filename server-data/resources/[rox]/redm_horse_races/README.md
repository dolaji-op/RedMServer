# RedM Horse Races
Howdy cowboys! Fulfill your racing dreams in RedM with our exhilarating horse racing script! Experience the adrenaline rush of races with up to 32 players on your very own custom tracks. Join the thrill ride now and compete with friends!

## Commands
Access to commands can be added/revoked through ace permissions.
- `/hostrace <trackId> <laps?>` - Hosts race with selected track and provided number of laps.
- `/joinrace <raceId>` - Joins race with provided raceId.
- `/leaverace` - Leaves current race.
- `/endracetimer <raceId>` - Starts race ending countdown.
- `/endrace <raceId>` - Starts end race sequence.

## Coronas UI
If you want to leave coronas ui enabled, then you must add `SetTextRenderId(0)` before every Draw* native. Otherwise texts/rects/sprites would be rendering on coronas models. And would not be visible on the screen.

---
