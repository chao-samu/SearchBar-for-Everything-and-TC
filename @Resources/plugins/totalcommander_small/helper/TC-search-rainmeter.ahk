; ==============================================================================
; AutoHotkey Version ..: 1.1.*
; Version .............: -
; Author ..............: chao-samu
;-------------------------------------------------------------------------------
; Script Name..........: TC-search-rainmeter
; Description .........: -
; Additional Info......: Script Parameters: [TCPath] [option_1] [drive-letter] [search-pattern]+
; .....................: TCPath: the path to your Total Commander installation
; .....................: option_1: "-A" (for everything); "-F" (for files only); "-V" (for directorys only). Is necessary!
; .....................: drive-letter: In the following format "C:\\" or "C:\;D:\\".  Is necessary!
; .....................: search-pattern: Your search pattern
; License..............: -
; development notes....: cmd switch /S=F not recommended for tc, because to process the result, it requires a running tc instance.
; ==============================================================================

#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; MAIN #########################################################################
checkCmdArgs()
TCcmd := getCmdArgs()

if WinExist("ahk_class TFindFile") {
    startSearch(TCcmd["driveName"], TCcmd["searchParam"], TCcmd["option_1"])
}
else {
    if WinExist("ahk_class TTOTAL_CMD") {
        waitForLicenseWindow()
        WinActivate, ahk_class TTOTAL_CMD
        WinWaitActive, ahk_class TTOTAL_CMD
        PostMessage, 1075, 501, , , ahk_class TTOTAL_CMD ; send cm_searchfor
        startSearch(TCcmd["driveName"], TCcmd["searchParam"], TCcmd["option_1"])
    }
    else {
        Run, % TCcmd["TCPath"]
        WinActivate, ahk_class TTOTAL_CMD
        WinWaitActive, ahk_class TTOTAL_CMD
        waitForLicenseWindow()
        PostMessage, 1075, 501, , , ahk_class TTOTAL_CMD ; send cm_searchfor
        startSearch(TCcmd["driveName"], TCcmd["searchParam"], TCcmd["option_1"])
    }
}

; FUNCTIONS ####################################################################
checkCmdArgs() {

    argsCount := A_Args.Length()
    if (A_Args.Length() <= 3) {
        MsgBox,
        (LTrim
        The script needs more then 3 parameter, but it only recieved %argsCount%.

        Script Parameters: [TCPath] [option_1] [drive-letter] [search-pattern]+

        [TCPath]
        The path to your Total Commander installation, for instance "C:\totalcmd\TOTALCMD64.EXE".
            You can use 32bit or 64bit version. Is necessary!

        [option_1]
        "-A" (for everything); "-F" (for files only); "-V" (for directorys only). Is necessary!

        [drive-letter]
        In the following format "C:\\" or "C:\;D:\\".  Is necessary!

        [search-pattern]+
        Your search pattern, every additional parameter is handled as a part of the search pattern.
        )
        ExitApp
    }

}

getCmdArgs() {

    aArray := {}

    for key, value in A_Args {
        if (key = 1)
            aArray["TCPath"] := value
        else if (key = 2)
            aArray["option_1"] := value 
        else if (key = 3)
            aArray["driveName"] := StrReplace(value, """", "\") 
        else
            aArray["searchParam"] := aArray["searchParam"] . value 
    }

    return aArray
}

waitForLicenseWindow() {

    if WinExist("ahk_class TNASTYNAGSCREEN")
        WinWaitClose, ahk_class TNASTYNAGSCREEN
    if WinExist("ahk_class TDLG2FILEACTIONMIN")
        WinWaitClose, ahk_class TDLG2FILEACTIONMIN

}

startSearch(driveName, searchParam, option_1) {
    WinActivate, ahk_class TFindFile
    WinWaitActive, ahk_class TFindFile
    ControlSetText, Edit2, , ahk_class TFindFile
    ControlSend, Edit2, {Text}%driveName%, ahk_class TFindFile ;ControlSetText not working safely
    ControlSetText, Edit3, %searchParam%, ahk_class TFindFile
    selectTCSearchOption(option_1)
}

selectTCSearchOption(option_1) {

    if WinActive("ahk_class TFindFile ahk_exe TOTALCMD.EXE")
        selectTCSearchOption32(option_1)
    else if WinActive("ahk_class TFindFile ahk_exe TOTALCMD64.EXE")
        selectTCSearchOption64(option_1)
}

selectTCSearchOption32(option_1) {

    if (option_1 = "-V") { 
        ;PostMessage, 0x130C, 2,, TMyCheckBox11, ahk_class TFindFile ;or 0x130B alternative tab control
        Control, TabRight, 1, TMyTabbedNotebook1, ahk_class TFindFile
        Sleep 50 ;necessary for window creating time, otherwise its not saving the settings
        Control, Check,, TMyCheckBox14, ahk_class TFindFile
        ;PostMessage, 0x00F1, 1,, TMyCheckBox11, ahk_class TFindFile
        ControlSend, TMyCheckBox11, {Space 2}, ahk_class TFindFile
        Control, TabLeft, 1, TMyTabbedNotebook1, ahk_class TFindFile
    }
    else if (option_1 = "-F") {
        ;PostMessage, 0x130C, 2,, TMyCheckBox11, ahk_class TFindFile ;or 0x130B alternative tab control
        Control, TabRight, 1, TMyTabbedNotebook1, ahk_class TFindFile
        Sleep 50 ;necessary for window creating time, otherwise its not saving the settings
        Control, Check,, TMyCheckBox14, ahk_class TFindFile
        ;PostMessage, 0x00F1, 0,, TMyCheckBox11, ahk_class TFindFile
        ControlSend, TMyCheckBox11, {Space 1}, ahk_class TFindFile
        Control, TabLeft, 1, TMyTabbedNotebook1, ahk_class TFindFile
    } else {
        ;PostMessage, 0x130C, 2,, TMyCheckBox11, ahk_class TFindFile ;or 0x130B alternative tab control
        Control, TabRight, 1, TMyTabbedNotebook1, ahk_class TFindFile
        Sleep 50 ;necessary for window creating time, otherwise its not saving the settings
        Control, UnCheck,, TMyCheckBox14, ahk_class TFindFile
        ;PostMessage, 0x00F1, 2,, TMyCheckBox11, ahk_class TFindFile
        ControlSend, TMyCheckBox11, {Space 3}, ahk_class TFindFile
        Control, TabLeft, 1, TMyTabbedNotebook1, ahk_class TFindFile
    }

    ;ControlFocus, TButton19, ahk_class TFindFile  ; necessary for second search
    ControlFocus, TButton21, ahk_class TFindFile ; necessary for second search
    ControlSend, TButton21, {Enter}, ahk_class TFindFile
}

selectTCSearchOption64(option_1) {

    if (option_1 = "-V") { ;folders
        PostMessage, 0x1330, 1, 0, SysTabControl321, ahk_class TFindFile
        Sleep 10000 ;necessary for window creating time, otherwise the ongoing PostMessage calls come to early
        Control, Check,, Button18, ahk_class TFindFile
        PostMessage, 0x00F1, 1,, Button15, ahk_class TFindFile
        PostMessage, 0x1330, 0, 0, SysTabControl321, ahk_class TFindFile
    }
    else if (option_1 = "-F") { ;files
        PostMessage, 0x1330, 1, 0, SysTabControl321, ahk_class TFindFile
        Sleep 10000 ;necessary for window creating time, otherwise the ongoing PostMessage calls come to early
        Control, Check,, Button18, ahk_class TFindFile
        PostMessage, 0x00F1, 0,, Button15, ahk_class TFindFile
        PostMessage, 0x1330, 0, 0, SysTabControl321, ahk_class TFindFile
    } else {
        PostMessage, 0x1330, 1, 0, SysTabControl321, ahk_class TFindFile
        Sleep 10000 ;necessary for window creating time, otherwise the ongoing PostMessage calls come to early
        Control, UnCheck,, Button18, ahk_class TFindFile
        PostMessage, 0x1330, 0, 0, SysTabControl321, ahk_class TFindFile 
    }

    ;ControlFocus, Button55, ahk_class TFindFile  ; necessary for second search
    ControlFocus, Button58, ahk_class TFindFile ; necessary for second search
    ControlSend, Button58, {Enter}, ahk_class TFindFile
}