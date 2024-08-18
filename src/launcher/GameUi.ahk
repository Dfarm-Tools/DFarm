#Include Characters.ahk
#Include LauncherUi.ahk

class GameUi {
    __New() {
        this.Gui := 0
        this.WinTitle := 'DFarm - Game'
        this.switch := 0
        this.Characters := Characters()
        this.command := '/travel [00,12]'

        this.switchOnGui := 0
        this.switchOffGui := 0

        this.Characters.Init()
    }

    Create() {

        this.Gui := Gui("-Caption +AlwaysOnTop",this.WinTitle)
        this.Gui.Add("Picture", "x0 y20 h410", A_MyDocuments . "\Dfarm\assets\game\background.png")

        icon := A_MyDocuments . "\Dfarm\assets\icon.ico"
        TraySetIcon(icon)

        this.Gui.Add("Text", "x0 y0 w120 h40 +BackgroundTrans")
        .OnEvent("Click", this.GetMethod('UiMove').Bind(this)) 

        this.Gui.Add("Picture", "x0 y0", A_MyDocuments . "\Dfarm\assets\game\titlebar.png")

        this.Gui.Add("Picture", "x150 y3 w20 h20 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\cross.png")
        .OnEvent("Click", this.GetMethod('Close').Bind(this)) 

        this.Gui.Add("Picture", "x5 y60 w160 h40 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\grouper.png")
        .OnEvent("Click", this.Characters.Group.Bind(this.Characters)) 

        this.switchOffGui := this.Gui.Add("Picture", "x5 y120 w160 h40 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\switch_off.png")
        this.switchOffGui.OnEvent("Click", this.GetMethod('ChangeSwitch').Bind(this)) 

        this.switchOnGui := this.Gui.Add("Picture", "x5 y120 w160 h40 +BackgroundTrans +Hidden", A_MyDocuments . "\Dfarm\assets\common\switch_on.png")
        this.switchOnGui.OnEvent("Click", this.GetMethod('ChangeSwitch').Bind(this)) 

        this.Gui.Add("Picture", "x5 y180 w160 h40 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\rejoindre.png")
        .OnEvent("Click", this.Characters.Join.Bind(this.Characters)) 

        this.Gui.Add("Picture", "x5 y240 w160 h40 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\pret.png")
        .OnEvent("Click", this.Characters.Ready.Bind(this.Characters)) 

        command := this.Gui.Add("Edit","x5 y305 w160 h25 vcommand")
        command.OnEvent("Change", this.GetMethod('SetCommand').Bind(this))

        this.Gui.Add("Picture", "x5 y335 w160 h40 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\exec.png")
        .OnEvent("Click", this.GetMethod('ExecCommand').Bind(this)) 

        this.Gui.Show("w170 h400")
    }

    SetCommand(GuiCtrlObj, Info){
        this.command := GuiCtrlObj.Value
    }

    ExecCommand(*){
        this.Characters.CommandInChat(this.command) 
    }

    ChangeSwitch(*){
        if(this.switch = 0) {
            this.switchOffGui.Visible := false
            this.switchOnGui.Visible := true
            this.switch := 1
            this.Characters.StartAutoSwitch()
        } else {
            this.switchOffGui.Visible := true
            this.switchOnGui.Visible := false
            this.switch := 0
            this.Characters.StopAutoSwitch()
        }
    }

    UiMove(*){
        PostMessage(0xA1, 2,,, "A")
    }

    Close(*) {
        this.LauncherUi := LauncherUi()
        this.LauncherUi.Show()
        this.Characters.StopAutoSwitch()
        this.Characters.SetGlobalShortcut("Off")
        this.Characters.SetClickShortcut("Off")
        this.Characters.SetArrowShortcut("Off")
        this.Gui.Destroy()
    }

    Show(*) {
        UniqueID := WinExist(this.WinTitle)
        if(UniqueID = 0) {
            this.Create()
        } 
    }

}