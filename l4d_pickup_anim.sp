#pragma semicolon 1
#pragma newdecls required
#define INVALID_REFERENCE 0
#include <left4dhooks> 
#include <sdktools>
#include <sdkhooks>
float PressTime[65];
public Plugin myinfo = 
{
	name        = "[L4D2] Pick_anim",
	author      = "Hesh233",
	description = "press R using pick up anim when full ammo/大于最大弹夹容量时候按r键循环播放伸手动作（为mod检视武器设计）",
	version     = "1.0.0",
	url         = ""
};

public Action OnPlayerRunCmd(int client, int &buttons, int &impulse, float vel[3], float angles[3], int &weapon, int &subtype, int &cmdnum, int &tickcount, int &seed, int mouse[2])
{
	if (GetClientTeam(client) == 2 && IsPlayerAlive(client))
		{
			int button = GetClientButtons(client);
			float time = GetEngineTime();
			if(buttons && (button & IN_RELOAD))
			{
				if(!IsFakeClient(client) && time - PressTime[client] > 0.5)
				{				
					CreateTimer(0.1, TimerReviveSuccess, client);
					PressTime[client] = time;
				}
			}
		}
}
 
public Action TimerReviveSuccess(Handle timer, int iClient)
{
		char sWeaponName[32];
		char wpname[32];
		GetClientWeapon(iClient, wpname, sizeof(wpname));
		int iViewModel = GetEntPropEnt(iClient, Prop_Data, "m_hViewModel");
		if(iViewModel == -1)
			return Plugin_Handled;
		GetEntPropString(iViewModel, Prop_Data, "m_ModelName", sWeaponName, sizeof(sWeaponName)); 
		int iClip = L4D2_GetIntWeaponAttribute(wpname, L4D2IWA_ClipSize);
		int iCurrentWeapon = GetEntPropEnt(iClient, Prop_Send, "m_hActiveWeapon");
		bool isFull = GetEntProp(iCurrentWeapon, Prop_Data, "m_iClip1") >= iClip;
		if (!isFull)
			return Plugin_Handled;
		if (StrContains(sWeaponName, "mp5", false) != -1 || StrContains(sWeaponName, "552", false) != -1 || StrContains(sWeaponName, "shotgun", false) != -1)
			{
					int layer = 22;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 24;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 26;
					}
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));									
			}
			else if (StrContains(sWeaponName, "smg", false) != -1 || StrContains(sWeaponName, "v_rifle", false) != -1 || StrContains(sWeaponName, "v_desert_rif", false) != -1  || StrContains(sWeaponName, "laun", false) != -1 || StrContains(sWeaponName, "m60", false) != -1 || StrContains(sWeaponName, "snip_", false) != -1)
			{
					int layer = 18;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 20;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 22;
					}								
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));
			}		
			else if (StrContains(sWeaponName, "hunting", false) != -1)
			{
					int layer = 27;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 25;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer-2)
					{
						layer = 29;
					}
									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer); 
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));
			}
			else if (StrContains(sWeaponName, "pistol", false) != -1)
			{
				if(GetEntProp(iCurrentWeapon, Prop_Send, "m_isDualWielding") > 0)
				{	 
					//DUAL PISTOL
					int layer = 27;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 29;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 31;
					}
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer);											
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));
				}
				else 
				{	
					//ONE PISTOL	
					int layer = 21;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 23;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 25;
					}
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer);										
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));
				}
			} 
			else if (StrContains(sWeaponName, "Eagle", false) != -1)
			{
				int layer = 21;
				if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
				{
					layer = 23;
				}
				else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
				{
					layer = 25;
				}
				SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer);										
				SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer);
				SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
				ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));
			}
			else if (StrContains(sWeaponName, "milit", false) != -1)
			{
					int layer = 13;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 14;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+1)
					{
						layer = 15;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}
			else if (StrContains(sWeaponName, "bomb", false) != -1 || StrContains(sWeaponName, "bile", false) != -1 || StrContains(sWeaponName, "Molot", false) != -1)
			{
					int layer = 13;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 11;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer-2)
					{
						layer = 15;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}
			else if (StrContains(sWeaponName, "pitch", false) != -1 )
			{
					int layer = 18;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 20;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 22;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}
			else if (StrContains(sWeaponName, "axe", false) != -1 || StrContains(sWeaponName, "elect", false) != -1)
			{
					int layer = 24;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 26;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 28;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}
			else if (StrContains(sWeaponName, "cricket", false) != -1 ||StrContains(sWeaponName, "bat", false) != -1 ||StrContains(sWeaponName, "golf", false) != -1 || StrContains(sWeaponName, "machete", false) != -1 || StrContains(sWeaponName, "katana", false) != -1 || StrContains(sWeaponName, "shovel", false) != -1)
			{
					int layer = 20;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 22;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 24;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}
			else if (StrContains(sWeaponName, "tonfa", false) != -1)
			{
					int layer = 22;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 24;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 26;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}
			else if (StrContains(sWeaponName, "crow", false) != -1 ||StrContains(sWeaponName, "frying", false) != -1 )
			{
					int layer = 19;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 21;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 23;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}
			else if (StrContains(sWeaponName, "adrenaline", false) != -1)
			{
					int layer = 16;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 18;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 20;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}	
			else if (StrContains(sWeaponName, "pills", false) != -1)
			{
					int layer = 9;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 7;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer-2)
					{
						layer = 11;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}
			else if (StrContains(sWeaponName, "medkit", false) != -1 || StrContains(sWeaponName, "explosive_amm", false) != -1 || StrContains(sWeaponName, "incendiary", false) != -1)
			{
					int layer = 14;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 16;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 18;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence",layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}																	
			else
			{
					int layer = 18;
					if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer)
					{
						layer = 20;
					}
					else if(GetEntProp(iViewModel, Prop_Send, "m_nLayerSequence") == layer+2)
					{
						layer = 22;
					}									
					SetEntProp(iViewModel, Prop_Send, "m_nLayerSequence", layer);
					SetEntPropFloat(iViewModel, Prop_Send, "m_flLayerStartTime", GetGameTime()); 
					ChangeEdictState(iViewModel, FindDataMapOffs(iViewModel, "m_nLayerSequence"));		
			}
			return Plugin_Handled;	
}

 
	//默认18-20-22  21
	//马格南21-23-25
	//单持21-23-25 24
	//双持27-29-31 28
	//mp5 22-24-26 25
	//552 22-24-26 25
	//木狙 27-25-29 26
	//军狙击13-14-15 14
	//喷子 22-24-26 25
	//药 9 7 11
	//针16 18 20
	//包14 16 18
	//弹药盒火14 16 18
	//弹药盒高爆14 16 18
	//pipe bomb 火 13 11 15
	//平底锅 撬棍 19 21 23
	//警棍 22 24 26
	//铲子 太刀 砍刀 20 22 24
	//叉子 18 20 22
	//斧头 吉他 24 26 28
	//高尔夫 翰杖 棒球棍 20 22 24