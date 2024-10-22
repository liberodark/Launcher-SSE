package fr.bestdevelop.test;

import java.io.File;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.w3c.dom.Comment;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class Main2 {
	
	public static void main(String[] args) {
		final DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			
		try {
		    final DocumentBuilder builder = factory.newDocumentBuilder();
		    final Document document= builder.newDocument();
		    
		    final Element config = document.createElement("Config");
		    config.setAttribute("xmlns:xsd", "http://www.w3.org/2001/XMLSchema");
		    config.setAttribute("xmlns:xsi", "http://www.w3.org/2001/XMLSchema-instance");
		    document.appendChild(config);
		    
		    final Element appList = document.createElement("AppList");
		    config.appendChild(appList);
		    
		    final Element broadcastAddress1 = document.createElement("BroadcastAddress");
		    broadcastAddress1.appendChild(document.createTextNode(""));
		    appList.appendChild(broadcastAddress1);
		    
		    final Element dlcList = document.createElement("DlcList");
		    dlcList.appendChild(document.createTextNode(""));
		    appList.appendChild(dlcList);
		    
		    final Element directPatchList = document.createElement("DirectPatchList");
		    directPatchList.appendChild(document.createTextNode(""));
		    appList.appendChild(directPatchList);
		    
		    final Element iconPath = document.createElement("IconPath");
		    iconPath.appendChild(document.createTextNode(""));
		    appList.appendChild(iconPath);
		    
		    final Element gameName = document.createElement("GameName");
		    gameName.appendChild(document.createTextNode("HurtworldClient"));
		    appList.appendChild(gameName);
		    
		    final Element category = document.createElement("Category");
		    category.appendChild(document.createTextNode(""));
		    appList.appendChild(category);
		    
		    final Element path = document.createElement("Path");
		    path.appendChild(document.createTextNode("\\HurtworldClient.exe"));
		    appList.appendChild(path);
		    
		    final Element commandLine = document.createElement("CommandLine");
		    commandLine.appendChild(document.createTextNode(""));
		    appList.appendChild(commandLine);
		    
		    final Element startIn = document.createElement("StartIn");
		    startIn.appendChild(document.createTextNode("\\"));
		    appList.appendChild(startIn);
		    
		    final Element persist = document.createElement("Persist");
		    persist.appendChild(document.createTextNode("false"));
		    appList.appendChild(persist);
		    
		    final Element injectDll = document.createElement("InjectDll");
		    injectDll.appendChild(document.createTextNode("false"));
		    appList.appendChild(injectDll);
		    
		    final Element personaName = document.createElement("PersonaName");
		    personaName.appendChild(document.createTextNode("liberodark"));
		    appList.appendChild(personaName);
		    
		    final Element appId = document.createElement("AppId");
		    appId.appendChild(document.createTextNode("393420"));
		    appList.appendChild(appId);
		    
		    final Element steamIdGeneration = document.createElement("SteamIdGeneration");
		    steamIdGeneration.appendChild(document.createTextNode("PersonaName"));
		    appList.appendChild(steamIdGeneration);
		    
		    final Element manualSteamId = document.createElement("ManualSteamId");
		    manualSteamId.appendChild(document.createTextNode("-1"));
		    appList.appendChild(manualSteamId);
		   
		    final Element language = document.createElement("Language");
		    language.appendChild(document.createTextNode("French"));
		    appList.appendChild(language);
		    
		    final Element lowViolence = document.createElement("LowViolence");
		    lowViolence.appendChild(document.createTextNode("-1"));
		    appList.appendChild(lowViolence);
		    
		    final Element storageOnAppdata = document.createElement("StorageOnAppdata");
		    storageOnAppdata.appendChild(document.createTextNode("-1"));
		    appList.appendChild(storageOnAppdata);
		    
		    final Element separateStorageByName = document.createElement("SeparateStorageByName");
		    separateStorageByName.appendChild(document.createTextNode("-1"));
		    appList.appendChild(separateStorageByName);
		    
		    final Element remoteStoragePath = document.createElement("RemoteStoragePath");
		    remoteStoragePath.appendChild(document.createTextNode(""));
		    appList.appendChild(remoteStoragePath);
		    
		    final Element automaticallyJoinInvite = document.createElement("AutomaticallyJoinInvite");
		    automaticallyJoinInvite.appendChild(document.createTextNode("-1"));
		    appList.appendChild(automaticallyJoinInvite);
		    
		    final Element enableHTTP = document.createElement("EnableHTTP");
		    enableHTTP.appendChild(document.createTextNode("-1"));
		    appList.appendChild(enableHTTP);
		    
		    final Element enableInGameVoice = document.createElement("EnableInGameVoice");
		    enableInGameVoice.appendChild(document.createTextNode("-1"));
		    appList.appendChild(enableInGameVoice);
		    
		    final Element enableLobbyFilter = document.createElement("EnableLobbyFilter");
		    enableLobbyFilter.appendChild(document.createTextNode("-1"));
		    appList.appendChild(enableLobbyFilter);
		    
		    final Element disableFriendList = document.createElement("DisableFriendList");
		    disableFriendList.appendChild(document.createTextNode("-1"));
		    appList.appendChild(disableFriendList);
		    
		    final Element disableLeaderboard = document.createElement("DisableLeaderboard");
		    disableLeaderboard.appendChild(document.createTextNode("-1"));
		    appList.appendChild(disableLeaderboard);
		    
		    final Element securedServer = document.createElement("SecuredServer");
		    securedServer.appendChild(document.createTextNode("-1"));
		    appList.appendChild(securedServer);
		    
		    final Element vR = document.createElement("VR");
		    vR.appendChild(document.createTextNode("-1"));
		    appList.appendChild(vR);
		    
		    final Element disableGC = document.createElement("DisableGC");
		    disableGC.appendChild(document.createTextNode("false"));
		    appList.appendChild(disableGC);
		    
		    final Element offline = document.createElement("Offline");
		    offline.appendChild(document.createTextNode("-1"));
		    appList.appendChild(offline);
		    
		    final Element extras = document.createElement("Extras");
		    extras.appendChild(document.createTextNode(""));
		    appList.appendChild(extras);
		    
		    final Element failOnNonExistenceStats = document.createElement("FailOnNonExistenceStats");
		    failOnNonExistenceStats.appendChild(document.createTextNode("false"));
		    appList.appendChild(failOnNonExistenceStats);
		    
		    final Element listenPort = document.createElement("ListenPort");
		    listenPort.appendChild(document.createTextNode("-1"));
		    appList.appendChild(listenPort);
		    
		    final Element maximumPort = document.createElement("MaximumPort");
		    maximumPort.appendChild(document.createTextNode("-1"));
		    appList.appendChild(maximumPort);
		    
		    final Element discoveryInterval = document.createElement("DiscoveryInterval");
		    discoveryInterval.appendChild(document.createTextNode("-1"));
		    appList.appendChild(discoveryInterval);
		    
		    final Element maximumConnection = document.createElement("MaximumConnection");
		    maximumConnection.appendChild(document.createTextNode("-1"));
		    appList.appendChild(maximumConnection);
		    
		    final Element defaultDlcSubscribed = document.createElement("DefaultDlcSubscribed");
		    defaultDlcSubscribed.appendChild(document.createTextNode("true"));
		    appList.appendChild(defaultDlcSubscribed);
		    
		    final Element enableOverlay = document.createElement("EnableOverlay");
		    enableOverlay.appendChild(document.createTextNode("-1"));
		    appList.appendChild(enableOverlay);
		    
		    final Element enableOnlinePlay = document.createElement("EnableOnlinePlay");
		    enableOnlinePlay.appendChild(document.createTextNode("-1"));
		    appList.appendChild(enableOnlinePlay);
		    
		    final Element enableHookRefCount = document.createElement("EnableHookRefCount");
		    enableHookRefCount.appendChild(document.createTextNode("true"));
		    appList.appendChild(enableHookRefCount);
		    
		    // MasterServerAddress
		    
		    final Element masterServerAddress = document.createElement("MasterServerAddress");
		    config.appendChild(masterServerAddress);
		    
		    final Element masterServerAddressString = document.createElement("string");
		    masterServerAddressString.appendChild(document.createTextNode("188.40.40.201:27010"));
		    masterServerAddress.appendChild(masterServerAddressString);
		    
            // BroadcastAddress
		    
		    final Element broadcastAddress = document.createElement("BroadcastAddress");
		    config.appendChild(broadcastAddress);
		    
		    final Element broadcastAddressString = document.createElement("string");
		    broadcastAddressString.appendChild(document.createTextNode("255.255.255.255"));
		    broadcastAddress.appendChild(broadcastAddressString);
		    
		    // Others
		    
		    final Element banList = document.createElement("BanList");
		    banList.appendChild(document.createTextNode(""));
		    config.appendChild(banList);
		    
		    final Element sortBy = document.createElement("SortBy");
		    sortBy.appendChild(document.createTextNode("SortByName"));
		    config.appendChild(sortBy);
		    
		    final Element groupBy = document.createElement("GroupBy");
		    groupBy.appendChild(document.createTextNode("GroupByNone"));
		    config.appendChild(groupBy);
		    
		    final Element windowSizeX = document.createElement("WindowSizeX");
		    windowSizeX.appendChild(document.createTextNode("339"));
		    config.appendChild(windowSizeX);
		    
		    final Element windowSizeY = document.createElement("WindowSizeY");
		    windowSizeY.appendChild(document.createTextNode("453"));
		    config.appendChild(windowSizeY);
		    
		    final Element windowPosX = document.createElement("WindowPosX");
		    windowPosX.appendChild(document.createTextNode("167"));
		    config.appendChild(windowPosX);
		    
		    final Element windowPosY = document.createElement("WindowPosY");
		    windowPosY.appendChild(document.createTextNode("103"));
		    config.appendChild(windowPosY);
		    
		    final Element hideMissingShortcut = document.createElement("HideMissingShortcut");
		    hideMissingShortcut.appendChild(document.createTextNode("false"));
		    config.appendChild(hideMissingShortcut);
		    
		    final Element hideToTray = document.createElement("HideToTray");
		    hideToTray.appendChild(document.createTextNode("false"));
		    config.appendChild(hideToTray);
		    
		    final Element paranoidMode = document.createElement("ParanoidMode");
		    paranoidMode.appendChild(document.createTextNode("false"));
		    config.appendChild(paranoidMode);
		    
		    final Element avatarPath = document.createElement("AvatarPath");
		    avatarPath.appendChild(document.createTextNode("avatar.png"));
		    config.appendChild(avatarPath);
		    
		    final Element personaName1 = document.createElement("PersonaName");
		    personaName1.appendChild(document.createTextNode("AccountName"));
		    config.appendChild(personaName1);
		    
		    final Element steamIdGeneration1 = document.createElement("SteamIdGeneration");
		    steamIdGeneration1.appendChild(document.createTextNode("GenerateRandom"));
		    config.appendChild(steamIdGeneration1);
		    
		    final Element manualSteamId1 = document.createElement("ManualSteamId");
		    manualSteamId1.appendChild(document.createTextNode("0"));
		    config.appendChild(manualSteamId1);
		    
		    final Element language1 = document.createElement("Language");
		    language1.appendChild(document.createTextNode("English"));
		    config.appendChild(language1);
		    
		    final Element lowViolence1 = document.createElement("LowViolence");
		    lowViolence1.appendChild(document.createTextNode("false"));
		    config.appendChild(lowViolence1);
		    
		    final Element storageOnAppdata1 = document.createElement("StorageOnAppdata");
		    storageOnAppdata1.appendChild(document.createTextNode("true"));
		    config.appendChild(storageOnAppdata1);
		    
		    final Element separateStorageByName1 = document.createElement("SeparateStorageByName");
		    separateStorageByName1.appendChild(document.createTextNode("false"));
		    config.appendChild(separateStorageByName1);
		    
		    final Element automaticallyJoinInvite1 = document.createElement("AutomaticallyJoinInvite");
		    automaticallyJoinInvite1.appendChild(document.createTextNode("true"));
		    config.appendChild(automaticallyJoinInvite1);
		    
		    final Element enableHTTP1 = document.createElement("EnableHTTP");
		    enableHTTP1.appendChild(document.createTextNode("false"));
		    config.appendChild(enableHTTP1);
		    
		    final Element enableInGameVoice1 = document.createElement("EnableInGameVoice");
		    enableInGameVoice1.appendChild(document.createTextNode("false"));
		    config.appendChild(enableInGameVoice1);
		    
		    final Element enableLobbyFilter1 = document.createElement("EnableLobbyFilter");
		    enableLobbyFilter1.appendChild(document.createTextNode("true"));
		    config.appendChild(enableLobbyFilter1);
		    
		    final Element disableFriendList1 = document.createElement("DisableFriendList");
		    disableFriendList1.appendChild(document.createTextNode("false"));
		    config.appendChild(disableFriendList1);
		    
		    final Element disableLeaderboard1 = document.createElement("DisableLeaderboard");
		    disableLeaderboard1.appendChild(document.createTextNode("false"));
		    config.appendChild(disableLeaderboard1);
		    
		    final Element securedServer1 = document.createElement("SecuredServer");
		    securedServer1.appendChild(document.createTextNode("true"));
		    config.appendChild(securedServer1);
		    
		    final Element enableVR = document.createElement("EnableVR");
		    enableVR.appendChild(document.createTextNode("false"));
		    config.appendChild(enableVR);
		    
		    final Element offline1 = document.createElement("Offline");
		    offline1.appendChild(document.createTextNode("false"));
		    config.appendChild(offline1);
		    
		    final Element quickJoinHotkey = document.createElement("QuickJoinHotkey");
		    quickJoinHotkey.appendChild(document.createTextNode("SHIFT + TAB"));
		    config.appendChild(quickJoinHotkey);
		    
		    final Element enableLog = document.createElement("EnableLog");
		    enableLog.appendChild(document.createTextNode("false"));
		    config.appendChild(enableLog);
		    
		    final Element markLogHotkey = document.createElement("MarkLogHotkey");
		    markLogHotkey.appendChild(document.createTextNode("CTRL + ALT + M"));
		    config.appendChild(markLogHotkey);
		    
		    final Element logFilter = document.createElement("LogFilter");
		    logFilter.appendChild(document.createTextNode("User Logged On"));
		    config.appendChild(logFilter);
		    
		    final Element minidump = document.createElement("Minidump");
		    minidump.appendChild(document.createTextNode("true"));
		    config.appendChild(minidump);
		    
		    final Element listenPort1 = document.createElement("ListenPort");
		    listenPort1.appendChild(document.createTextNode("31313"));
		    config.appendChild(listenPort1);
		    
		    final Element maximumPort1 = document.createElement("MaximumPort");
		    maximumPort1.appendChild(document.createTextNode("10"));
		    config.appendChild(maximumPort1);
		    
		    final Element discoveryInterval1 = document.createElement("DiscoveryInterval");
		    discoveryInterval1.appendChild(document.createTextNode("3"));
		    config.appendChild(discoveryInterval1);
		    
		    final Element maximumConnection1 = document.createElement("MaximumConnection");
		    maximumConnection1.appendChild(document.createTextNode("200"));
		    config.appendChild(maximumConnection1);
		    
		    final Element allowAnyoneConnect = document.createElement("AllowAnyoneConnect");
		    allowAnyoneConnect.appendChild(document.createTextNode("true"));
		    config.appendChild(allowAnyoneConnect);
		    
		    final Element adminPass = document.createElement("AdminPass");
		    adminPass.appendChild(document.createTextNode(""));
		    config.appendChild(adminPass);
		    
		    final Element enableOverlay1 = document.createElement("EnableOverlay");
		    enableOverlay1.appendChild(document.createTextNode("true"));
		    config.appendChild(enableOverlay1);
		    
		    final Element enableOnlinePlay1 = document.createElement("EnableOnlinePlay");
		    enableOnlinePlay1.appendChild(document.createTextNode("true"));
		    config.appendChild(enableOnlinePlay1);
		    
		    final Element overlayScreenshotHotkey = document.createElement("OverlayScreenshotHotkey");
		    overlayScreenshotHotkey.appendChild(document.createTextNode("F12"));
		    config.appendChild(overlayScreenshotHotkey);
				
		    
		    
		    final TransformerFactory transformerFactory = TransformerFactory.newInstance();
		    final Transformer transformer = transformerFactory.newTransformer();
		    final DOMSource source = new DOMSource(document);
		    final StreamResult sortie = new StreamResult(new File("file.xml"));
		    //final StreamResult result = new StreamResult(System.out);
				
		    transformer.setOutputProperty(OutputKeys.VERSION, "1.0");
		    transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
		    transformer.setOutputProperty(OutputKeys.STANDALONE, "yes");			
		    		
		    transformer.setOutputProperty(OutputKeys.INDENT, "yes");
		    transformer.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "2");
				
		    transformer.transform(source, sortie);	
		    
		    System.out.println("Finish");
		}
		catch (final ParserConfigurationException e) {
		    e.printStackTrace();
		}
		catch (TransformerConfigurationException e) {
		    e.printStackTrace();
		}
		catch (TransformerException e) {
		    e.printStackTrace();
		}			
	}
	
}
