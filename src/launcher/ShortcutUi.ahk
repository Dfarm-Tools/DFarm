class ShortcutUi {
    __New() {
        this.Gui := 0
        this.HotkeyInput := 0
        this.ShortcutInput := 0
        this.WinTitle := 'DFarm - ShortCut'
        this.ShortcutList := ["suivant", "precedent","haut", "droite", "bas", "gauche", "rejoindre", "grouper", "pret", "clic_delai", "clic_instant", "position_souris"]
    }


    UiMove(*){
        PostMessage(0xA1, 2,,, "A")
    }

    Create() {
        this.Gui := Gui("-Caption",this.WinTitle)
        icon := A_MyDocuments . "\Dfarm\assets\icon.ico"
        TraySetIcon(icon)

        this.Gui.Add("Picture", "x0 y20", A_MyDocuments . "\Dfarm\assets\shortcut\background.png")

        this.Gui.Add("Text", "x0 y0 w250 h40 +BackgroundTrans")
        .OnEvent("Click", this.GetMethod('UiMove').Bind(this)) 

        this.Gui.Add("Picture", "x0 y0", A_MyDocuments . "\Dfarm\assets\shortcut\titlebar.png")

        this.Gui.Add("Picture", "x270 y3 w20 h20 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\cross.png")
        .OnEvent("Click", this.GetMethod('Close').Bind(this)) 


        this.ShortcutInput := this.Gui.Add("ListBox", "x10 y60 w200 h150 vColorChoice", this.ShortcutList)
        this.ShortcutInput.OnEvent("Change",  this.SelectShortcut.Bind(this))
        
        this.HotkeyInput := this.Gui.Add("Hotkey", "x10 y260  w200 vChosenHotkey")
        this.HotkeyInput.OnEvent("Change",  this.SetShortcut.Bind(this))

        this.Gui.Add("Picture", "x70 y320 w160 h40 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\fermer.png")
        .OnEvent("Click", this.GetMethod('Close').Bind(this)) 

        this.Gui.Show("w300 h380")
    }

    Close(*) {
        this.Gui.Destroy()
    }

    Show(*) {
        UniqueID := WinExist(this.WinTitle)
        if(UniqueID = 0) {
            this.Create()
        } 
    }
    
    SelectShortcut(GuiCtrlObj, Info) {
        this.HotkeyInput.Value := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", GuiCtrlObj.Text)
    }
    
    SetShortcut(GuiCtrlObj, Info) {
        IniWrite(GuiCtrlObj.Value, A_MyDocuments . "\Dfarm\conf.ini", "shortcut", this.ShortcutInput.Text)
    }
}