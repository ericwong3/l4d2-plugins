# L4D2 Plugins

This repository holds the plugins sourced or developed for the [Survival Buds](https://l4d2.lerico.net) community L4D2 survival servers, we aim to provide enhanced L4D2 survival game experience while respecting the original game design as much as possible.

You are welcome to use the original plugins on your server, the other plugins belongs to the respective authors and developers.

## Original Plugins

### [Vote for Random Survival Map](scripting/voterandomsurvivalmap.sp)

Allow player to trigger a vote to change to a random map. The plugin is built on NativeVotes to allow player to vote using F1 and F2 keys (similar to vote-kick).

Requires [NativeVotes](https://github.com/sapphonie/sourcemod-nativevotes-updated) to be installed (including the include files and installed as a plugin).

Command: `!randommap`

### [Reset Survivor Health on Survival Round Starts](scripting/resethealthonsurvivalroundstarts.sp)

Reset all survivors health to 100 when a survival round starts

## Adapted Plugins

### [Gas Config](scripting/gasconfig.sp)

Enable players to load presets of gas cans / propane tanks / ammo boxes locations created by admins.

Command: `!gasmenu`

Based on [khan's GasConfig](https://github.com/graviti666/Some-Plugins/blob/bdc43b6d64ce7aea855859370fefe5519aa80c85/Gas%20Configs/GasConfig.sp). Modified for latest SM compiler and fixed file permission issue. See `// Modified` tags.

### [Friendly Fire Report](scripting/friendlyfirereport.sp)

Displays how much friendly fire damage you have dealt/received (!ff), and how much friendly fire has each survivor dealt (!ffe).

Commands: `!ff`, `!ffe`

**Note**: SM's built-in basetrigger plugin also uses "ff" as a command to allow player to check whether FF is enabled. To avoid conflict, edit `plugins/basetriggger.sp`, comment out the line `RegConsoleCmd("ff", Command_FriendlyFire);`, recompile the plugin and replace `plugins/basetrigger.smx`. The "ff" command will still work because the plugin also listens for "ff" using "OnClientSayCommand_Post".

Based on [Gravity's Friendly Fire Report](https://github.com/graviti666/Some-Plugins/blob/bdc43b6d64ce7aea855859370fefe5519aa80c85/FriendlyFireReport.sp). Modified for latest SM compiler. See `// Modified` tags.

### [Slay bots](https://github.com/fafa-junhe/My-srcds-plugins/blob/0de19c28b4eb8bdd4d3a04c90c2489c473427f7a/all/slaybots.sp)

Kill all bots (non-human survivors).

Command: `!slaybots`

Based on [ozzy's Slay bots](https://github.com/fafa-junhe/My-srcds-plugins/blob/0de19c28b4eb8bdd4d3a04c90c2489c473427f7a/all/slaybots.sp). Modified for latest SM compiler. See `// Modified` tags.

## Other Plugins

### [Connect Announce by Arg!](https://forums.alliedmods.net/showthread.php?t=77306)

Generate connection and disconnection message when player enters or leaves the server.

Our servers use the following message templates for better privacy (default setting prints location down to city level as well as the player's IP).

<details>
<summary>data/cannounce_settings.txt</summary>

```
"CountryShow"
{
	"messages"
	{
		"playerjoin"		"{PLAYERTYPE} {GREEN}{PLAYERNAME} {DEFAULT} connected from {LIGHTGREEN}{PLAYERCOUNTRYSHORT}{DEFAULT}"
		"playerdisc"		"{PLAYERTYPE} {GREEN}{PLAYERNAME} {DEFAULT} disconnected {GREEN}reason: {DEFAULT}{DISC_REASON}"
	}
	"messages_admin"
	{
		"playerjoin"		"{PLAYERTYPE} {GREEN}{PLAYERNAME} {DEFAULT} connected from {LIGHTGREEN}{PLAYERCOUNTRYSHORT}{DEFAULT}"
		"playerdisc"		"{PLAYERTYPE} {GREEN}{PLAYERNAME} {DEFAULT} disconnected {GREEN}reason: {DEFAULT}{DISC_REASON}"
	}
}
```

</details>

### [Survival Stats Tracker (l4d2_stats) by khan](https://github.com/graviti666/Some-Plugins/blob/bdc43b6d64ce7aea855859370fefe5519aa80c85/L4D2%20stats/l4d2_stats.sp)

Tank damage announcement during the game, various damage stats commands, and extensive damage report / friendly fire stats when survival round ends.

Commands: `!td`, `!stats`, `!stats2`, `!estats`, `!dstats`, `!istats`, `!sicount`, `!acc`

### [Use Spectate, Join and Kill command in chat (NeedToHave) by Danny](https://forums.alliedmods.net/showthread.php?p=1198514)

Allow players to switch to spectator, used in conjunction with L4DToolz to unlock server slots limit.

Commands: `!spec`, `!join`

## List of includes

### [colors.inc](scripting/include/colors.inc)
By exvel, Popoklopsi, Powerlord, Bara

### [weapons.inc](scripting/include/weapons.inc)
Origin unknown. Modified for latest SM compiler
