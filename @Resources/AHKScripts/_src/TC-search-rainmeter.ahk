; ==================================================================================================
; AutoHotkey Version ..: 1.1.*
; Version .............: -
; Author ..............: chao-samu
;------------------------------------------------------------------------------------
; Script Name..........: TC-search-rainmeter
; Description .........: -
; Additional Info......: Script Parameters: [TCPath] [option_1] [drive-letter] [search-pattern]+
; .....................: TCPath: the path to your Total Commander installation
; .....................: option_1: "-A" (for everything); "-F" (for files only); "-V" (for directorys only). Is necessary!
; .....................: drive-letter: In the following format "C:\\" or "C:\;D:\\".  Is necessary!
; .....................: search-pattern: Your search pattern
; License..............: -
; ==================================================================================================

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.



; SCRIPT PARAMETER HANDLING ########################################################################
if 0 <= 3  ; The left side of a non-expression if-statement is always the name of a variable.
{
    MsgBox,
    (LTrim
    The script needs more then 3 parameter, but it only recieved %0%.

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

Loop, %0%  ; for every parameter
{
    if A_Index = 1
    {
        TCPath = %1%
    }
    else if A_Index = 2
    {
        option_1 = %2%
    }
    else if A_Index = 3
    {
        laufwerksname = %3%
        laufwerksname := StrReplace(laufwerksname, """", "\")
    }
    else
    {
        SearchParam := SearchParam . %A_Index%
    }
}

; FUNCTIONS ########################################################################################
TCChoseSearchOptions(option_1)
{
    IfWinActive, ahk_class TFindFile ahk_exe TOTALCMD.EXE
    {
        If option_1 = -V
        {
            Control,TabRight, 1, TMyTabbedNotebook1, ahk_class TFindFile
            Control, Check,, TCheckBox3, ahk_class TFindFile
            PostMessage, 0x00F1, 1,, TMyCheckBox9, ahk_class TFindFile
            Control,TabLeft, 1, TMyTabbedNotebook1, ahk_class TFindFile
        }
        else if option_1 = -F
        {
            Control,TabRight, 1, TMyTabbedNotebook1, ahk_class TFindFile
            Control, Check,, TCheckBox3, ahk_class TFindFile
            PostMessage, 0x00F1, 0,, TMyCheckBox9, ahk_class TFindFile
            Control,TabLeft, 1, TMyTabbedNotebook1, ahk_class TFindFile
        }
        else ;option_1 = -A
        {
            Control,TabRight, 1, TMyTabbedNotebook1, ahk_class TFindFile
            Control, Check,, TCheckBox3, ahk_class TFindFile
            PostMessage, 0x00F1, 2,, TMyCheckBox9, ahk_class TFindFile
            Control,TabLeft, 1, TMyTabbedNotebook1, ahk_class TFindFile
        }
        ;ControlClick, TButton16, ahk_class TFindFile ;seems not to work safely
        ControlFocus, TButton16, ahk_class TFindFile  ; necessary for second search
        ControlSend, TButton16, {Enter}, ahk_class TFindFile
    }
    IfWinActive, ahk_class TFindFile ahk_exe TOTALCMD64.EXE
    {
        If option_1 = -V
        {
            PostMessage, 0x1330, 1, 0, SysTabControl321, ahk_class TFindFile
            Sleep 10
            Control, Check,, Button18, ahk_class TFindFile
            PostMessage, 0x00F1, 1,, Button15, ahk_class TFindFile
            PostMessage, 0x1330, 0, 0, SysTabControl321, ahk_class TFindFile
        }
        else if option_1 = -F
        {
            PostMessage, 0x1330, 1, 0, SysTabControl321, ahk_class TFindFile
            Sleep 10
            Control, Check,, Button18, ahk_class TFindFile
            PostMessage, 0x00F1, 0,, Button15, ahk_class TFindFile
            PostMessage, 0x1330, 0, 0, SysTabControl321, ahk_class TFindFile
        }
        else ;option_1 =-A
        {
            PostMessage, 0x1330, 1, 0, SysTabControl321, ahk_class TFindFile
            Sleep 10
            Control, Check,, Button18, ahk_class TFindFile
            PostMessage, 0x00F1, 2,, Button15, ahk_class TFindFile
            PostMessage, 0x1330, 0, 0, SysTabControl321, ahk_class TFindFile
        }
        ;ControlClick, Button55, ahk_class TFindFile ;seems not to work safely
        ControlFocus, Button55, ahk_class TFindFile  ; necessary for second search
        ControlSend, Button55, {Enter}, ahk_class TFindFile
    }
}

; MAIN #############################################################################################
IfWinExist, ahk_class TFindFile
{
    WinActivate, ahk_class TFindFile
    WinWaitActive, ahk_class TFindFile
    ControlSetText, Edit2, %laufwerksname%, ahk_class TFindFile
    ControlSetText, Edit3, %SearchParam%, ahk_class TFindFile
    Sleep, 100 ;necessary for TC string save time in Edit3
    TCChoseSearchOptions(option_1)
}
else
{
    IfWinExist, ahk_class TTOTAL_CMD
    {
        IfWinExist, ahk_class TNASTYNAGSCREEN
        {
            WinWaitClose, ahk_class TNASTYNAGSCREEN
        }
        IfWinExist, ahk_class TDLG2FILEACTIONMIN
        {
            WinWaitClose, ahk_class TDLG2FILEACTIONMIN
        }
        WinActivate, ahk_class TTOTAL_CMD
        WinWaitActive, ahk_class TTOTAL_CMD
        PostMessage, 1075, 501, , , ahk_class TTOTAL_CMD ; send cm_searchfor
        WinActivate, ahk_class TFindFile
        WinWaitActive, ahk_class TFindFile
        ControlSetText, Edit2, %laufwerksname%, ahk_class TFindFile
        ControlSetText, Edit3, %SearchParam%, ahk_class TFindFile
        Sleep, 100 ;necessary for TC string save time in Edit3
        TCChoseSearchOptions(option_1)
    }
    else
    {
        Run, %TCPath%
        WinActivate, ahk_class TTOTAL_CMD
        WinWaitActive, ahk_class TTOTAL_CMD
        IfWinExist, ahk_class TNASTYNAGSCREEN
        {
            WinWaitClose, ahk_class TNASTYNAGSCREEN
        }
        IfWinExist, ahk_class TDLG2FILEACTIONMIN
        {
            WinWaitClose, ahk_class TDLG2FILEACTIONMIN
        }
        PostMessage, 1075, 501, , , ahk_class TTOTAL_CMD ; send cm_searchfor
        WinActivate, ahk_class TFindFile
        WinWaitActive, ahk_class TFindFile
        ControlSetText, Edit2, %laufwerksname%, ahk_class TFindFile
        ControlSetText, Edit3, %SearchParam%, ahk_class TFindFile
        Sleep, 100 ;necessary for TC string save time in Edit3
        TCChoseSearchOptions(option_1)
    }
}