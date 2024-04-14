// -
// -
// Server Name: Wearly Deathmatch 
// Mode: Deathmatch
// Script & Author (Mod Sahibi): ReveR
// With Contributions (Destekleri & Önerileri için): Holmes
// -
// -

#define SSCANF_NO_NICE_FEATURES

#include <open.mp>

// plugin include

#include <a_mysql>
#include <sscanf2>
#include <foreach>
#include <zcmd>

// Giris Tanitim

#define 	GIRIS_TANITIM  		(10)

// Lobi Sistemi

#define 	LOBI_ANA_DIALOG		(1)

#define 	LOBI_DIALOG_1 		(2)
#define 	LOBI_DIALOG_2 		(3)
#define 	LOBI_DIALOG_3 		(4)
#define 	LOBI_DIALOG_4 		(5)
#define	 	LOBI_DIALOG_5 		(6)

// TDM Sistemi

#define 	MAVI_TAKIM			(1) // sinif 1 (blue)
#define 	KIRMIZI_TAKIM		(2) // sinif 2 (red)

// GW Sistemi

#define 	GROVE_GANG_TEAM			(3)
#define 	BALLAS_GANG_TEAM		(4)
#define		VAGOS_GANG_TEAM			(5)

#define 	TDM_ANA_DIALOG 		(7)

#define 	TDM__DIALOG_1		(8)
#define 	TDM__DIALOG_2		(9)

new GlobalTeam[MAX_PLAYERS];

// Holmes Brother Lobi :D

new HolmesBrother[MAX_PLAYERS];

new Text:WearlyMainTD[2];

enum pSkin {

	ClassSkin[4],
	DefaultSkin
};

new playerSkin[MAX_PLAYERS][pSkin];

// GW Sistemi

#define 	GW_ANA_DIALOG		(11)
#define 	GW_DIALOG_1			(12)
#define		GW_DIALOG_2			(13)

new GW_Team[MAX_PLAYERS];

main()
{ print(" Wearly Deathmatch"); }

public OnGameModeInit()
{
	SetGameModeText("Wearly Deathmatch");

	AddPlayerClass(2, 1714.6244,-1645.1664,20.2242,228.1528); // default skin
	AddPlayerClass(270, 1714.6244,-1645.1664,20.2242,228.1528);
	AddPlayerClass(271, 1714.6244,-1645.1664,20.2242,228.1528);

	AddStaticVehicle(522, 2493.7583, -1683.6482, 12.9099, 270.8069, -1, -1);

	// ana td

	AnaTextDraw();

	// genel

	UsePlayerPedAnims();
	DisableInteriorEnterExits();
	
	// actors
	
	CreateActor(117, 1721.7240,-1652.3704,20.0625,2.0452);
	Create3DTextLabel("{ffffff}Deathmatch Lobi\n\n{FFFF00}Bilgi: {6699ff}'N' tusuna basarak etkilesime gecebilirsiniz.", -1, 1721.7240,-1652.3704,20.0625, 4.0, 0, bool:0);
	
	// actors - 2

	CreateActor(117, 1724.5681,-1655.6816,20.0625,266.0139);
	Create3DTextLabel("{ffffff}TDM (Teamdeathmatch)\n\n{FFFF00}Bilgi: {6699ff}'N' tusuna basarak etkilesime gecebilirsiniz.", -1, 1724.5681,-1655.6816,20.0625, 4.0, 0, bool:0);
	
	// actors - 3

	CreateActor(117, 1721.8406,-1658.5881,20.0625,180.0441);
	Create3DTextLabel("{ffffff}Gang Wars\n\n{FFFF00}Bilgi: {6699ff}'N' tusuna basarak etkilesime gecebilirsiniz.", -1, 1721.8406,-1658.5881,20.0625, 4.0, 0, bool:0);

	// actors - 4

	CreateActor(117, 1718.9990,-1655.6215,20.0625,89.7794);
	Create3DTextLabel("{ffffff}Top Skor\n\n{FFFF00}Bilgi: {6699ff}'N' tusuna basarak etkilesime gecebilirsiniz.", -1, 1718.9990,-1655.6215,20.0625, 4.0, 0, bool:0);

	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	ShowPlayerDialog(playerid, GIRIS_TANITIM, DIALOG_STYLE_MSGBOX, "{00ff00}Wearly Deathmatch", "{ffffff}Bu Mod {00ff00}ReveR {ffffff}tarafindan gelistirilmistir, katkilari ve onerileri icin {00ff00}Holmes {ffffff}tesekkur ederiz.", "(+)", "");

	HolmesBrother[playerid] = 0;
	GlobalTeam[playerid] = 0;
	GW_Team[playerid] = 0;

	TextDrawShowForPlayer(playerid, WearlyMainTD[0]); // td - 1 (main)
	TextDrawShowForPlayer(playerid, WearlyMainTD[1]); // td - 2 (main)

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	HolmesBrother[playerid] = 0;
	GlobalTeam[playerid] = 0;
	GW_Team[playerid] = 0;
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 2122.4956,-1195.4615,23.9132);
	SetPlayerFacingAngle(playerid, 357.3345);
	SetPlayerCameraPos(playerid, 2120.8381, -1188.1936, 26.4902);
	SetPlayerCameraLookAt(playerid, 2120.8142, -1189.1980, 26.2053);
	switch (classid)
	{
		case 0:
		{
			playerSkin[playerid][ClassSkin][0] = GetPlayerSkin(playerid);
			SetPlayerSkin(playerid, playerSkin[playerid][ClassSkin][0]);
			SendClientMessage(playerid, -1, "Maccer");
			return 1;
		}
		case 1:
		{
			playerSkin[playerid][ClassSkin][1] = GetPlayerSkin(playerid);
			SetPlayerSkin(playerid, playerSkin[playerid][ClassSkin][1]);
			SendClientMessage(playerid, -1, "Sweet");
			return 1;
		}
		case 2:
		{
			playerSkin[playerid][ClassSkin][2] = GetPlayerSkin(playerid);
			SetPlayerSkin(playerid, playerSkin[playerid][ClassSkin][2]);
			SendClientMessage(playerid, -1, "Ryder");
			return 1;
		}
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerPos(playerid, 1714.6244, -1645.1664, 20.2242);
	SetPlayerFacingAngle(playerid, 228.1528);
	SetPlayerInterior(playerid, 18);

	switch (HolmesBrother[playerid])
	{
			case 1:
			{
				SetPlayerPos(playerid, 288.47,170.06,1007.17);
				SetPlayerInterior(playerid, 3);

				// Silahlar

				GivePlayerWeapon(playerid, t_WEAPON:24, 99999); // dg
				GivePlayerWeapon(playerid, t_WEAPON:25, 99999); // shotgun
				GivePlayerWeapon(playerid, t_WEAPON:34, 99999); // sniper
			}
			case 2:
			{

					SetPlayerPos(playerid, -1420.42,1616.92,1052.53);
					SetPlayerInterior(playerid, 14);

					GivePlayerWeapon(playerid, t_WEAPON:22, 99999); // colt 45 
					GivePlayerWeapon(playerid, t_WEAPON:26, 99999); // sawn-off

					SendClientMessage(playerid, -1, "CS");

					HolmesBrother[playerid] = 1;
				
					return 1;
			}
			case 3:
			{
					
					SetPlayerPos(playerid, -1419.6910,936.8144,1036.4891);
					SetPlayerInterior(playerid, 15);

					GivePlayerWeapon(playerid, t_WEAPON:34, 99999);

					return 1;
			}
			case 4:
			{

					SetPlayerPos(playerid, 1290.0801,-0.7757,1001.0225);
					SetPlayerInterior(playerid, 18);

					GivePlayerWeapon(playerid, t_WEAPON:24, 99999); // dg

					return 1;
			}
			case 5:
			{

					SetPlayerPos(playerid, 1402.7267,5.4404,1000.9064);
					SetPlayerInterior(playerid, 1);

					GivePlayerWeapon(playerid, t_WEAPON:26, 99999); // SAWN	
									
					return 1;
			}
			case 6:
			{
					GlobalTeam[playerid] = MAVI_TAKIM;
					SetPlayerTeam(playerid, MAVI_TAKIM);

					SetPlayerSkin(playerid, 176);
					SetPlayerPos(playerid, -1129.6925,1057.8741,1346.4141);
					SetPlayerFacingAngle(playerid, 271.0800);
					SetPlayerInterior(playerid, 10);

					GivePlayerWeapon(playerid, t_WEAPON:24, 99999);
					GivePlayerWeapon(playerid, t_WEAPON:26, 99999);

					GlobalTeam[playerid] = MAVI_TAKIM;

					return 1;
			}
			case 7:
			{
					GlobalTeam[playerid] = KIRMIZI_TAKIM;
					SetPlayerTeam(playerid, KIRMIZI_TAKIM);

					SetPlayerSkin(playerid, 170);
					SetPlayerPos(playerid, -973.8041,1061.1887,1345.6731);
					SetPlayerFacingAngle(playerid, 92.7916);
					SetPlayerInterior(playerid, 10);

					GivePlayerWeapon(playerid, t_WEAPON:24, 99999);
					GivePlayerWeapon(playerid, t_WEAPON:26, 99999);

					GlobalTeam[playerid] = KIRMIZI_TAKIM;

					return 1;
			}
			case 8: // grove
			{
					GW_Team[playerid] = GROVE_GANG_TEAM;
					SendClientMessage(playerid, -1, "Grove Street");
					SetPlayerPos(playerid, 2512.8550,-1670.4945,13.4958); // grove pos
					GivePlayerWeapon(playerid, t_WEAPON:24, 100);
					SetPlayerSkin(playerid, 107);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerTeam(playerid, GROVE_GANG_TEAM);
			}
			case 9: // ballas
			{
					GW_Team[playerid] = BALLAS_GANG_TEAM; 
					SendClientMessage(playerid, -1, "Ballas Gang");
					SetPlayerPos(playerid, 2397.6082,-1247.8896,23.9680); // ballas pos
					GivePlayerWeapon(playerid, t_WEAPON:24, 100);
					SetPlayerSkin(playerid, 102);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerTeam(playerid, BALLAS_GANG_TEAM);
			}
			case 10: // vagos
			{
					GW_Team[playerid] = VAGOS_GANG_TEAM;
					SendClientMessage(playerid, -1, "Vagos Gang");
					SetPlayerPos(playerid, 1791.7152,-1937.0111,13.5469); // vagos pos
					GivePlayerWeapon(playerid, t_WEAPON:24, 100);
					SetPlayerSkin(playerid, 109);
					SetPlayerInterior(playerid, 0);
					SetPlayerVirtualWorld(playerid, 0);
					SetPlayerTeam(playerid, VAGOS_GANG_TEAM);
			}
	}
	switch(GlobalTeam[playerid])
	{
		case 0:
		{
			SetPlayerTeam(playerid, NO_TEAM);

			return 1;
		}
		case 1:
		{
			SetPlayerTeam(playerid, MAVI_TAKIM);

			GivePlayerWeapon(playerid, t_WEAPON:24, 99999);
			GivePlayerWeapon(playerid, t_WEAPON:26, 99999);
		}
		case 2:
		{
			SetPlayerTeam(playerid, KIRMIZI_TAKIM);

			GivePlayerWeapon(playerid, t_WEAPON:24, 99999);
			GivePlayerWeapon(playerid, t_WEAPON:26, 99999);
		}
	}
	switch (GW_Team[playerid])
	{
		case GROVE_GANG_TEAM:
		{
			SetPlayerTeam(playerid, GROVE_GANG_TEAM);
			
			GW_Team[playerid] = GROVE_GANG_TEAM;
		}
		case BALLAS_GANG_TEAM:
		{
			SetPlayerTeam(playerid, BALLAS_GANG_TEAM);

			GW_Team[playerid] = BALLAS_GANG_TEAM;
		}
		case VAGOS_GANG_TEAM:
		{
			SetPlayerTeam(playerid, VAGOS_GANG_TEAM);
		
			GW_Team[playerid] = VAGOS_GANG_TEAM;
		}
		default:
		{
			SetPlayerTeam(playerid, NO_TEAM);

			return 1;
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}


public OnPlayerRequestSpawn(playerid)
{
	SetPlayerPos(playerid, 2122.4956,-1195.4615,23.9132);
	SetPlayerFacingAngle(playerid, 357.3345);
	SetPlayerInterior(playerid, 18);
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
/*	if(GroveGang[playerid] == 1)
	{
		SetPlayerPos(playerid, 1700.7551,-1953.6531,14.8756);
	}
	else if(BallasGang[playerid] == 1)
	{
		SetPlayerPos(playerid, 1700.7551,-1953.6531,14.8756);
	}
	else if(VagosGang[playerid] == 1)
	{
		SetPlayerPos(playerid, 1700.7551,-1953.6531,14.8756);
	}*/
	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if(newkeys & KEY_NO)
	{
		if(IsPlayerInRangeOfPoint(playerid, 3.0, 1721.7240,-1652.3704,20.0625))
		{

			ShowPlayerDialog(playerid, LOBI_ANA_DIALOG, DIALOG_STYLE_LIST, "{e6e6fa}Lobi Ekrani","{cfe2f3}Desert Eagle / Sniper / Shotgun (DSS)\n{ffdbac}Colt45 / Sawn-off Shotgun (CS)\n{ffd96a}Sniper\n{ff7f50}Desert Eagle\n{b4a7d6}Sawn-off Shotgun\n", "Katil", "Iptal");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1724.5681,-1655.6816,20.0625))
		{

			ShowPlayerDialog(playerid, TDM_ANA_DIALOG, DIALOG_STYLE_LIST, "{e6e6fa}TDM Ekrani", "{00ffff}Mavi Takim\n{ff0033}Kirmizi Takim", "Katil", "Iptal");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1721.8406,-1658.5881,20.0625))
		{
			ShowPlayerDialog(playerid, GW_ANA_DIALOG, DIALOG_STYLE_LIST, "{ffffff}Gang Wars", "{00FF00}Grove Street\n{A020F0}Ballas Gang\n{FFFF00}Vagos", "Katil", "Iptal");
		}
		else if(IsPlayerInRangeOfPoint(playerid, 3.0, 1718.9990,-1655.6215,20.0625))
		{
			SendClientMessage(playerid, -1, "{ffffff}Bu Sistem devre disidir! (ReveR)");
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch (dialogid)
	{
		case GIRIS_TANITIM:
		{
			if(!response) return 1;
			else
			{
				SendClientMessage(playerid, -1, "{6699ff}Iletisim (Discord): reverbatu & raskoln_n");

				return 1;
			}
		}
		case LOBI_ANA_DIALOG:
		{
			switch(listitem)
			{
				case 0:
				{

					if(!response) return 1;
					SendClientMessage(playerid, -1, "DSS");

					SetPlayerPos(playerid, 288.47,170.06,1007.17);
					SetPlayerInterior(playerid, 3);

					// Silahlar

					GivePlayerWeapon(playerid, t_WEAPON:24, 99999); // dg
					GivePlayerWeapon(playerid, t_WEAPON:25, 99999); // shotgun
					GivePlayerWeapon(playerid, t_WEAPON:34, 99999); // sniper

					// Değer

					HolmesBrother[playerid] = 1;

				}
				case 1:
				{
					if(!response) return 1;

					SetPlayerPos(playerid, -1420.42,1616.92,1052.53);
					SetPlayerInterior(playerid, 14);

					GivePlayerWeapon(playerid, t_WEAPON:22, 99999); // colt 45 
					GivePlayerWeapon(playerid, t_WEAPON:26, 99999); // sawn-off

					SendClientMessage(playerid, -1, "CS");

					HolmesBrother[playerid] = 2;
				
					return 1;
				}
				case 2:
				{
					if(!response) return 1;

					SendClientMessage(playerid, -1, "Sniper");
					
					SetPlayerPos(playerid, -1419.6910,936.8144,1036.4891);
					SetPlayerInterior(playerid, 15);

					GivePlayerWeapon(playerid, t_WEAPON:34, 99999);

					HolmesBrother[playerid] = 3;

					return 1;
				}
				case 3:
				{
					if(!response) return 1;

					SendClientMessage(playerid, -1, "Desert Eagle");

					SetPlayerPos(playerid, 1290.0801,-0.7757,1001.0225);
					SetPlayerInterior(playerid, 18);

					GivePlayerWeapon(playerid, t_WEAPON:24, 99999); // dg

					HolmesBrother[playerid] = 4;

					return 1;
				}
				case 4:
				{
					if(!response) return 1;

					SendClientMessage(playerid, -1, "Sawn-off");

					SetPlayerPos(playerid, 1402.7267,5.4404,1000.9064);
					SetPlayerInterior(playerid, 1);

					GivePlayerWeapon(playerid, t_WEAPON:26, 99999); // SAWN	
									
					HolmesBrother[playerid] = 5;
					return 1;
				}
			}
		}
		case TDM_ANA_DIALOG:
		{
			if(!response) 
				return 1;
			else
			{
				switch (listitem)
				{
					case 0:
					{
						GlobalTeam[playerid] = MAVI_TAKIM;
						SetPlayerTeam(playerid, MAVI_TAKIM);

						SetPlayerSkin(playerid, 176);
						SetPlayerPos(playerid, -1129.6925,1057.8741,1346.4141);
						SetPlayerFacingAngle(playerid, 271.0800);
						SetPlayerInterior(playerid, 10);

						SendClientMessage(playerid, -1, "Mavi");

						GivePlayerWeapon(playerid, t_WEAPON:24, 99999);
						GivePlayerWeapon(playerid, t_WEAPON:26, 99999);

						HolmesBrother[playerid] = 6;

						GlobalTeam[playerid] = MAVI_TAKIM;
					
						return 1;
					}
					case 1:
					{
						GlobalTeam[playerid] = KIRMIZI_TAKIM;
						SetPlayerTeam(playerid, KIRMIZI_TAKIM);

						SetPlayerSkin(playerid, 170);
						SetPlayerPos(playerid, -973.8041,1061.1887,1345.6731);
						SetPlayerFacingAngle(playerid, 92.7916);
						SetPlayerInterior(playerid, 10);

						SendClientMessage(playerid, -1, "Kirmizi");

						GivePlayerWeapon(playerid, t_WEAPON:24, 99999);
						GivePlayerWeapon(playerid, t_WEAPON:26, 99999);

						HolmesBrother[playerid] = 7;

						GlobalTeam[playerid] = KIRMIZI_TAKIM;
					
						return 1;
					}
				}
			}
		}
		case GW_ANA_DIALOG:
		{
			if(!response) return 1;
			else
			{	
				switch (listitem)
				{
					case 0:
					{
						GW_Team[playerid] = GROVE_GANG_TEAM;
						SendClientMessage(playerid, -1, "Grove Street");
						SetPlayerPos(playerid, 2512.8550,-1670.4945,13.4958); // grove pos
						GivePlayerWeapon(playerid, t_WEAPON:24, 100);
						SetPlayerSkin(playerid, 107);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						SetPlayerTeam(playerid, GROVE_GANG_TEAM);
						
						HolmesBrother[playerid] = 8;
					}
					case 1:
					{
						GW_Team[playerid] = BALLAS_GANG_TEAM; 
						SendClientMessage(playerid, -1, "Ballas Gang");
						SetPlayerPos(playerid, 2397.6082,-1247.8896,23.9680); // ballas pos
						GivePlayerWeapon(playerid, t_WEAPON:24, 100);
						SetPlayerSkin(playerid, 102);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						SetPlayerTeam(playerid, BALLAS_GANG_TEAM);

						HolmesBrother[playerid] = 9;
					}
					case 2:
					{
						GW_Team[playerid] = VAGOS_GANG_TEAM;
						SendClientMessage(playerid, -1, "Vagos Gang");
						SetPlayerPos(playerid, 1791.7152,-1937.0111,13.5469); // vagos pos
						GivePlayerWeapon(playerid, t_WEAPON:24, 100);
						SetPlayerSkin(playerid, 109);
						SetPlayerInterior(playerid, 0);
						SetPlayerVirtualWorld(playerid, 0);
						SetPlayerTeam(playerid, VAGOS_GANG_TEAM);
					
						HolmesBrother[playerid] = 10;
					}
				}
				return 1;
			}
		}
	}
	return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerEnterPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeavePlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return 1;
}

public OnPlayerRequestDownload(playerid, DOWNLOAD_REQUEST:type, crc)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 0;
}

public OnPlayerSelectObject(playerid, SELECT_OBJECT:type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, EDIT_RESPONSE:response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	return 1;
}

public OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerPickUpPlayerPickup(playerid, pickupid)
{
	return 1;
}

public OnPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public  OnPlayerGiveDamage(playerid, damagedid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnScriptCash(playerid, amount, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

public OnTrailerUpdate(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	return 1;
}

CMD:gotopos(playerid, params[])
{
	new Float: Pos[3], interiorid;
	if(sscanf(params, "p<,>fffi", Pos[0], Pos[1], Pos[2], interiorid)) return SendClientMessage(playerid, -1, "/gotopos [X] [Y] [Z] [interiorid]");
	if(IsPlayerInAnyVehicle(playerid)) SetVehiclePos(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
	else 
	{
		SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
		SetPlayerInterior(playerid, interiorid);
	}
	return 1;
}

CMD:kill(playerid)
{
	SetPlayerHealth(playerid, 0);
	return 1;
}

CMD:lobi(playerid)
{
	// - 0
	SetPlayerHealth(playerid, 0);
	// - 1
	SetPlayerTeam(playerid, NO_TEAM);
	SetPlayerSkin(playerid, 2);
	// - 2
	SetPlayerPos(playerid, 1714.6244, -1645.1664, 20.2242);
	SetPlayerFacingAngle(playerid, 228.1528);
	SetPlayerInterior(playerid, 18);
	// - 3
	SendClientMessage(playerid, -1, "Lobi alanina dondunuz!");
	// - 4
	HolmesBrother[playerid] = 0;
	// - 5
	GlobalTeam[playerid] = 0;
	// - 6
	GW_Team[playerid] = 0;
	return 1;
}

stock AnaTextDraw()
{
	WearlyMainTD[0] = TextDrawCreate(50.000, 303.000, "_Wearly DM");
	TextDrawLetterSize(WearlyMainTD[0], 0.290, 1.500);
	TextDrawAlignment(WearlyMainTD[0], t_TEXT_DRAW_ALIGN:1);
	TextDrawColour(WearlyMainTD[0], -2016478465);
	TextDrawSetShadow(WearlyMainTD[0], 10);
	TextDrawSetOutline(WearlyMainTD[0], 1);
	TextDrawBackgroundColour(WearlyMainTD[0], -1);
	TextDrawFont(WearlyMainTD[0], t_TEXT_DRAW_FONT:1);
	TextDrawSetProportional(WearlyMainTD[0], bool:1);

	WearlyMainTD[1] = TextDrawCreate(84.000, 319.000, "_v1.0");
	TextDrawLetterSize(WearlyMainTD[1], 0.290, 1.500);
	TextDrawAlignment(WearlyMainTD[1], t_TEXT_DRAW_ALIGN:1);
	TextDrawColour(WearlyMainTD[1], -2016478465);
	TextDrawSetShadow(WearlyMainTD[1], 10);
	TextDrawSetOutline(WearlyMainTD[1], 1);
	TextDrawBackgroundColour(WearlyMainTD[1], -1);
	TextDrawFont(WearlyMainTD[1], t_TEXT_DRAW_FONT:1);
	TextDrawSetProportional(WearlyMainTD[1], bool:1);

	return 1;
}

stock PlayerName(playerid)
{
	new name[24];
	GetPlayerName(playerid, name, 24);
	return name;
}

stock GetName(playerid)
{
	new playerName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playerName, sizeof(playerName));
	return playerName;
}

CMD:cc(playerid)
{
	for(new i = 0; i <= 100; i++)
	{
		SendClientMessage(playerid, -1, " ");
	}
	SendClientMessage(playerid, -1, "> chat temizlendi");
}