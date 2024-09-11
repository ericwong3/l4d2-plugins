/*
References:
- https://github.com/sapphonie/sourcemod-nativevotes-updated/blob/master/addons/sourcemod/scripting/nativevotes_votetest.sp
- https://github.com/sapphonie/sourcemod-nativevotes-updated/blob/master/addons/sourcemod/scripting/nativevotes_mapchooser.sp
- Survival Maps List: https://developer.valvesoftware.com/wiki/List_of_L4D2_Missions_Files
*/
#include <sourcemod>
#include <nativevotes>

#pragma newdecls required

#define VERSION "1.0"

public Plugin myinfo =
{
	name				= "[L4D2] Random Survival Map",
	author			= "FAILdows",
	description = "Player-triggerable vote for randomly changing to another survival map",
	version			= VERSION
}

char g_MapList[43][] = { "c1m2_streets", "c1m4_atrium", "c2m1_highway", "c2m4_barns", "c2m5_concert", "c3m1_plankcountry", "c3m3_shantytown", "c3m4_plantation", "c4m1_milltown_a", "c4m2_sugarmill_a", "c4m3_sugarmill_b", "c5m1_waterfront", "c5m2_park", "c5m3_cemetery", "c5m4_quarter", "c5m5_bridge", "c6m1_riverbank", "c6m2_bedlam", "c6m3_port", "c7m1_docks", "c7m2_barge", "c7m3_port", "c8m2_subway", "c8m3_sewers", "c8m4_interior", "c8m5_rooftop", "c9m1_alleys", "c9m2_lots", "c10m2_drainage", "c10m3_ranchhouse", "c10m4_mainstreet", "c10m5_houseboat", "c11m2_offices", "c11m3_garage", "c11m4_terminal", "c11m5_runway", "c12m2_traintunnel", "c12m3_bridge", "c12m5_cornfield", "c13m3_memorialbridge", "c13m4_cutthroatcreek", "c14m1_junkyard", "c14m2_lighthouse" };

public void OnPluginStart()
{
	RegConsoleCmd("sm_randommap", Cmd_RandomMap);
}

public Action Cmd_RandomMap(int client, int args)
{
	if (!NativeVotes_IsVoteTypeSupported(NativeVotesType_Custom_YesNo))
	{
		ReplyToCommand(client, "Game does not support Custom Yes/No votes.");
		return Plugin_Handled;
	}

	if (!NativeVotes_IsNewVoteAllowed())
	{
		int seconds = NativeVotes_CheckVoteDelay();
		ReplyToCommand(client, "Vote is not allowed for %d more seconds", seconds);
		return Plugin_Handled;
	}

	NativeVote vote = new NativeVote(RandomMapHandler, NativeVotesType_Custom_YesNo);

	vote.Initiator	= client;
	vote.SetDetails("Change to Random Map?");
	vote.DisplayVoteToAll(15);

	return Plugin_Handled;
}

public int RandomMapHandler(NativeVote vote, MenuAction action, int param1, int param2)
{
	switch (action)
	{
		case MenuAction_End:
		{
			vote.Close();
		}

		case MenuAction_VoteCancel:
		{
			if (param1 == VoteCancel_NoVotes)
			{
				vote.DisplayFail(NativeVotesFail_NotEnoughVotes);
			}
			else
			{
				vote.DisplayFail(NativeVotesFail_Generic);
			}
		}

		case MenuAction_VoteEnd:
		{
			if (param1 == NATIVEVOTES_VOTE_NO)
			{
				vote.DisplayFail(NativeVotesFail_Loses);
			}
			else
			{
				vote.DisplayPass("Vote Passed!!");
				PrintToChatAll("[SM] Loading random map in 5 seconds");
				CreateTimer(5.0, Timer_ChangeMap, INVALID_HANDLE, TIMER_FLAG_NO_MAPCHANGE);
			}
		}
	}

	return 0;
}

public Action Timer_ChangeMap(Handle timer, DataPack pack)
{
	ForceChangeLevel(g_MapList[GetRandomInt(0, sizeof(g_MapList) - 1)], "sm_randommap");
	return Plugin_Stop;
}
