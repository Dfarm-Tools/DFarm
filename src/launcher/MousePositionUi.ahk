class MousePositionUi {
    __New() {
        this.Gui := 0
        this.CoordText := 0
        this.WinTitle := 'DFarm - Cursor'
        this.shortcut := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "position_souris")

        this.SetShortcutMousePOS()
    }

    SetShortcutMousePOS()
    {
        mousePosShortcut := this.shortcut
        if(mousePosShortcut != '') {
            Hotkey(mousePosShortcut, this.UpdateOSD.Bind(this))
        }
    }

    Create() {


        this.Gui := Gui("+AlwaysOnTop -Caption", this.WinTitle)
        
        icon := A_MyDocuments . "\Dfarm\assets\icon.ico"
        TraySetIcon(icon)

        this.Gui.Add("Picture", "x0 y20", A_MyDocuments . "\Dfarm\assets\mouse\background.png")

        this.Gui.Add("Text", "x0 y0 w180 h40 +BackgroundTrans")
        .OnEvent("Click", this.GetMethod('UiMove').Bind(this)) 

        this.Gui.Add("Picture", "x0 y0", A_MyDocuments . "\Dfarm\assets\mouse\titlebar.png")

        this.Gui.Add("Picture", "x180 y3 w20 h20 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\cross.png")
        .OnEvent("Click", this.GetMethod('Close').Bind(this)) 
        
        this.CoordTextX := this.Gui.Add("Text", "cffffff w150 h90 x10 y60 +BackgroundTrans", "XXXXX") 
        this.CoordTextX.SetFont("cffffff s30", "Impact")

        this.CoordTextY := this.Gui.Add("Text", "cffffff w150 h90 x10 y100 +BackgroundTrans", "YYYYY") 
        this.CoordTextY.SetFont("cffffff s30", "Impact")
        
        this.Gui.Add("Text", "w200 h20 x10 y160 ca0a0a0 +BackgroundTrans", this.shortcut . " pour nouvelle position")
        .SetFont("cffffff s12", "Impact")

        this.Gui.Add("Picture", "x30 y200 w160 h40 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\fermer.png")
        .OnEvent("Click", this.GetMethod('Close').Bind(this)) 
        
        this.Gui.Show("x150 y200 w220 h250 NoActivate") 
        
    }
    
    UiMove(*){
        PostMessage(0xA1, 2,,, "A")
    }
    
    Close(*) {
        this.Gui.Destroy()
    }
    
    UpdateOSD(*)
    {
        CoordMode("Mouse", "Screen")
        MouseGetPos &MouseX, &MouseY
        this.CoordTextX.Value := "X : " MouseX 
        this.CoordTextY.Value := "Y : " MouseY
    }
    
    
    Show(*) {
        UniqueID := WinExist(this.WinTitle)
        if(UniqueID = 0) {
            this.Create() 
        }
        this.UpdateOSD()
    }
    
}