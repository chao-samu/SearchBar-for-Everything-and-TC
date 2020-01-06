; ==============================================================================
; AutoHotkey Version ..: 1.1.*
; Version .............: -
; Author ..............: chao-samu
;-------------------------------------------------------------------------------
; Script Name..........: DC-search-rainmeter
; Description .........: -
; Additional Info......: Script Parameters: [DCPath] [option_1] [drive-letter] [search-pattern]+
; .....................: DCPath: the path to your Double Commander installation
; .....................: option_1: "-A" (for everything); "-F" (for files only); "-V" (for directorys only). Is necessary!
; .....................: drive-letter: In the following format "C:\\" or "C:\;D:\\".  Is necessary!
; .....................: search-pattern: Your search pattern
; License..............: -
; development notes....: better option for find window recognition, better imp. of openFindDialouge()
; ==============================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; MAIN #########################################################################
checkCmdArgs()
DCcmd := getCmdArgs()

if WinExist("ahk_class Window ahk_exe doublecmd.exe")  {
    startSearch(DCcmd["driveName"], DCcmd["searchParam"], DCcmd["option_1"])
}
else {
    if WinExist("ahk_class DClass ahk_exe doublecmd.exe") {
        openFindDialouge()
        startSearch(DCcmd["driveName"], DCcmd["searchParam"], DCcmd["option_1"])
    }
    else {
        Run, % DCcmd["DCPath"]
        openFindDialouge()
        startSearch(DCcmd["driveName"], DCcmd["searchParam"], DCcmd["option_1"])
    }
}

; FUNCTIONS ####################################################################
checkCmdArgs() {
    argsCount := A_Args.Length()
    if (A_Args.Length() <= 3) {
        MsgBox,
        (LTrim
        The script needs more then 3 parameter, but it only recieved %argsCount%.

        Script Parameters: [DCPath] [option_1] [drive-letter] [search-pattern]+


        [DCPath]
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
            aArray["DCPath"] := value
        else if (key = 2)
            aArray["option_1"] := value 
        else if (key = 3)
            aArray["driveName"] := StrReplace(value, """", "\")   
        else
            aArray["searchParam"] := aArray["searchParam"] . value      
    }

    return aArray
}

openFindDialouge() {

        WinActivate, ahk_class DClass ahk_exe doublecmd.exe
        WinWaitActive, ahk_class DClass ahk_exe doublecmd.exe
        ; ControlSend,,!{F7}, ahk_class DClass ahk_exe doublecmd.exe ; not working
        ControlSend,,{LAlt Down}{F7}{LAlt Up}, ahk_class DClass ahk_exe doublecmd.exe
        
}

startSearch(driveName, searchParam, option_1) {

        WinActivate, ahk_class Window ahk_exe doublecmd.exe
        WinWaitActive, ahk_class Window ahk_exe doublecmd.exe
        setFindDialougeTab("start")
        ControlSetText, Edit6, %driveName%, ahk_class Window ahk_exe doublecmd.exe
        ControlSetText, Edit4, %searchParam%, ahk_class Window ahk_exe doublecmd.exe
        ControlFocus, Edit6, ahk_class Window ahk_exe doublecmd.exe
        ControlFocus, Edit4, ahk_class Window ahk_exe doublecmd.exe
        selectDCSearchOption(option_1)
        
}

setFindDialougeTab(tabPosition) {

    ; Clear filter is maybe the better option
    if (tabPosition == "start") {
        loop, 10 {
            Control, TabLeft, 1, SysTabControl321, ahk_class Window ahk_exe doublecmd.exe
        }
    } else if (tabPosition == "end"){
         loop, 10 {
            Control, TabRight, 1, SysTabControl321, ahk_class Window ahk_exe doublecmd.exe
        }       
    }

}

selectDCSearchOption(option_1) {

    if !WinActive("ahk_class Window ahk_exe doublecmd.exe")
        return

    Control, TabRight, 1, SysTabControl321, ahk_class Window ahk_exe doublecmd.exe
    
    if (option_1 = "-V")        
      ControlSetText, Edit1, d+, ahk_class Window ahk_exe doublecmd.exe
    else if (option_1 = "-F")
      ControlSetText, Edit1, d-, ahk_class Window ahk_exe doublecmd.exe
    else ;option_1 = -A
      ControlSetText, Edit1,, ahk_class Window ahk_exe doublecmd.exe   
        
    Control, TabLeft, 1, SysTabControl321, ahk_class Window ahk_exe doublecmd.exe
    ControlSend, Button5, {Enter}, ahk_class Window ahk_exe doublecmd.exe
    
}