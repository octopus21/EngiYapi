#pragma semicolon 1

#define DEBUG

#define PLUGIN_AUTHOR "Devil"
#define PLUGIN_VERSION "0.01"

#include <sourcemod>
#include <sdktools>
#include <tf2>
#include <tf2_stocks>
//#include <sdkhooks>

new Handle:g_cvYapiBlok = INVALID_HANDLE;

public Plugin:myinfo = 
{
	name = "", 
	author = PLUGIN_AUTHOR, 
	description = "", 
	version = PLUGIN_VERSION, 
	url = ""
};

public OnPluginStart()
{
	HookEvent("player_builtobject", OnPlayerBuilt);
	g_cvYapiBlok = CreateConVar("sm_yapiblok", "1", "(1), Sentryleri bloklar, (2), dispenserleri, (3), teleport giris, (4), teleport cikis", FCVAR_NOTIFY);
}
public Action:OnPlayerBuilt(Handle:hEvent, const String:name[], bool:dontBroadcast)
{
	new client = GetClientOfUserId(GetEventInt(hEvent, "userid"));
	new g_iYapi = 0;
	new entity = GetEventInt(hEvent, "index"); //Engi yapılarını almak
	decl String:ClassName[32]; //Yapıların isimlerinin kaydedileceği değer
	GetEdictClassname(entity, ClassName, sizeof(ClassName)); //İsmi alıyoruz
	if (GetConVarInt(g_cvYapiBlok) == 1)
		g_iYapi = 1;
	else if (GetConVarInt(g_cvYapiBlok) == 2)
		g_iYapi = 2;
	else if (GetConVarInt(g_cvYapiBlok) == 3)
		g_iYapi = 3;
	else if (GetConVarInt(g_cvYapiBlok) == 4)
		g_iYapi = 4;	
	if (g_iYapi == 1)
	{
		if (StrEqual(ClassName, "obj_sentrygun"))
		{
			AcceptEntityInput(entity, "Kill");
			PrintToChat(client, "\x07696969[ \x07A9A9A9SM \x07696969]\x07CCCCCCEngineerların Sentry Kurması Kapatıldı!");
		}
	}
	else if (g_iYapi == 2)
	{
		if (StrEqual(ClassName, "obj_dispenser"))
		{
			AcceptEntityInput(entity, "Kill");
			PrintToChat(client, "\x07696969[ \x07A9A9A9SM \x07696969]\x07CCCCCCEngineerların Dispenser Kurması Kapatıldı!");
		}
	}
	else if (g_iYapi == 3)
	{
		if (StrEqual(ClassName, "obj_teleport"))
		{
			if (TF2_GetObjectMode(entity) == TFObjectMode_Entrance)
			{
				AcceptEntityInput(entity, "Kill");
				PrintToChat(client, "\x07696969[ \x07A9A9A9SM \x07696969]\x07CCCCCCEngineerların Tele(Open) Kurması Kapatıldı!");
			}
		}
	}
	else if(g_iYapi == 4)
	{
		if (StrEqual(ClassName, "obj_teleport"))
		{
			if (TF2_GetObjectMode(entity) == TFObjectMode_Exit)
			{
				AcceptEntityInput(entity, "Kill");
				PrintToChat(client, "\x07696969[ \x07A9A9A9SM \x07696969]\x07CCCCCCEngineerların Tele(Exit) Kurması Kapatıldı!");
			}
		}
	}
} 