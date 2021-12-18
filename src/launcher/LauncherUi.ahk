
#Include ShortcutUi.ahk
#Include MousePositionUi.ahk
#Include SettingUi.ahk
#Include GameUi.ahk

class LauncherUi {
    __New() {
        this.Gui := 0
        this.WinTitle := 'DFarm - Launcher'
        this.ShortcutUi := ShortcutUi()
        this.MousePositionUi := MousePositionUi()
        this.SettingUi := SettingUi()
        this.GameUi := 0
    }


    Create() {
        
        this.Gui := Gui("-Caption",this.WinTitle)
        icon := A_MyDocuments . "\Dfarm\assets\icon.ico"
        TraySetIcon(icon)
       
        this.Gui.Add("Picture", "x0 y20", A_MyDocuments . "\Dfarm\assets\launcher\background.png")

        this.Gui.Add("Text", "x0 y0 w250 h40 +BackgroundTrans")
        .OnEvent("Click", this.UiMove.Bind(this)) 

        this.Gui.Add("Picture", "x0 y0", A_MyDocuments . "\Dfarm\assets\launcher\titlebar.png")

        this.Gui.Add("Picture", "x270 y3 w20 h20 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\cross.png")
        .OnEvent("Click", this.Close.Bind(this)) 

        this.Gui.Add("Picture", "x70 y250 w160 h40 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\lancer.png")
        .OnEvent("Click", this.OpenGame.Bind(this)) 

        this.Gui.Add("Picture", "x40 y320 w58 h58 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\setting.png")
        .OnEvent("Click", this.SettingUi.Show.Bind(this.SettingUi)) 

        this.Gui.Add("Picture", "x120 y320 w58 h58 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\keyboard.png")
        .OnEvent("Click", this.ShortcutUi.Show.Bind(this.ShortcutUi)) 

        this.Gui.Add("Picture", "x200 y320 w58 h58 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\cursor.png")
        .OnEvent("Click", this.MousePositionUi.Show.Bind(this.MousePositionUi)) 


        this.Gui.Show("w300 h400")
    }

    OpenGame(*){
        this.GameUi := GameUi()
        this.GameUi.Show()
        this.Gui.Destroy()
    }

    UiMove(*){
        PostMessage(0xA1, 2,,, "A")
    }

    Close(*) {
        ExitApp
    }

    Show(*) {
        UniqueID := WinExist(this.WinTitle)
        if(UniqueID = 0) {
            this.Create()
        } 
    }
    
   
}