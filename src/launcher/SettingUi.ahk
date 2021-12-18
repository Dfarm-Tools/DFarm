#Include ShortcutUi.ahk
#Include MousePositionUi.ahk

class SettingUi {
    __New() {
        this.Gui := 0
        this.WinTitle := 'DFarm - Setting'
    }

    Create() {
        
        this.Gui := Gui("-Caption",this.WinTitle)
        this.Gui.Add("Picture", "x0 y20", A_MyDocuments . "\Dfarm\assets\setting\background.png")

        icon := A_MyDocuments . "\Dfarm\assets\icon.ico"
        TraySetIcon(icon)

        uiMove := this.Gui.Add("Text", "x0 y0 w750 h40 +BackgroundTrans")
        uiMove.OnEvent("Click", this.GetMethod('UiMove').Bind(this)) 

        this.Gui.Add("Picture", "x0 y0", A_MyDocuments . "\Dfarm\assets\setting\titlebar.png")

        uiClose := this.Gui.Add("Picture", "x770 y3 w20 h20 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\cross.png")
        uiClose.OnEvent("Click", this.GetMethod('Close').Bind(this)) 

        pseudoX1Ui := this.Gui.Add("Edit","x50 y100 w80 h20 vpseudo_x1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "pseudo_x1"))
        pseudoX1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        pseudoY1Ui := this.Gui.Add("Edit","x50 y130 w80 h20 vpseudo_y1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "pseudo_y1"))
        pseudoY1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        pseudoX2Ui := this.Gui.Add("Edit","x50 y160 w80 h20 vpseudo_x2", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "pseudo_x2"))
        pseudoX2Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        pseudoY2Ui := this.Gui.Add("Edit","x50 y190 w80 h20 vpseudo_y2", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "pseudo_y2"))
        pseudoY2Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))



        joinX1Ui := this.Gui.Add("Edit","x190 y100 w80 h20 vjoin_x1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "join_x1"))
        joinX1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        joinY1Ui := this.Gui.Add("Edit","x190 y130 w80 h20 vjoin_y1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "join_y1"))
        joinY1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        readyX1Ui := this.Gui.Add("Edit","x320 y100 w70 h20 vready_x1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "ready_x1"))
        readyX1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        readyY1Ui := this.Gui.Add("Edit","x320 y130 w70 h20 vready_y1" , IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "ready_y1"))
        readyY1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        groupX1Ui := this.Gui.Add("Edit","x440 y100 w70 h20 vgroup_x1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "group_x1"))
        groupX1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        groupY1Ui := this.Gui.Add("Edit","x440 y130 w70 h20 vgroup_y1" , IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "group_y1"))
        groupY1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))



        moveMinUi := this.Gui.Add("Edit","x70 y295 w140 h20 vmove_delay_min", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "delay", "click_delay_min"))
        moveMinUi.OnEvent("Change", this.GetMethod('updateDelay').Bind(this))

        moveMaxUi := this.Gui.Add("Edit","x70 y325 w140 h20 vmove_delay_max", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "delay", "click_delay_max"))
        moveMaxUi.OnEvent("Change", this.GetMethod('updateDelay').Bind(this))

        groupMinUi := this.Gui.Add("Edit","x70 y410 w140 h20 vgroup_delay_min", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "delay", "group_delay_min"))
        groupMinUi.OnEvent("Change", this.GetMethod('updateDelay').Bind(this))

        groupMaxUi := this.Gui.Add("Edit","x70 y440 w140 h20 vgroup_delay_max", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "delay", "group_delay_max"))
        groupMaxUi.OnEvent("Change", this.GetMethod('updateDelay').Bind(this))

        switchMoveUi := this.Gui.Add("CheckBox", "x320 y170 h40 vswitch_on_move", "Switch perso apres mouvement ? ")
        switchMoveUi.SetFont("cffffff s12", "Impact")
        switchMoveUi.OnEvent("Click", this.GetMethod('updateSetting').Bind(this))


        upX1Ui := this.Gui.Add("Edit","x275 y295 w70 h20 vup_x1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "up_x1"))
        upX1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        upY1Ui := this.Gui.Add("Edit","x275 y325 w70 h20 vup_y1" , IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "up_y1"))
        upY1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        rightX1Ui := this.Gui.Add("Edit","x385 y295 w70 h20 vright_x1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "right_x1"))
        rightX1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        rightY1Ui := this.Gui.Add("Edit","x385 y325 w70 h20 vright_y1" , IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "right_y1"))
        rightY1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        
        leftX1Ui := this.Gui.Add("Edit","x497 y295 w70 h20 vleft_x1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "left_x1"))
        leftX1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        leftY1Ui := this.Gui.Add("Edit","x497 y325 w70 h20 vleft_y1" , IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "left_y1"))
        leftY1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        downX1Ui := this.Gui.Add("Edit","x615 y295 w70 h20 vdown_x1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "down_x1"))
        downX1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        downY1Ui := this.Gui.Add("Edit","x615 y325 w70 h20 vdown_y1" , IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "down_y1"))
        downY1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        chatX1Ui := this.Gui.Add("Edit","x275 y405 w70 h20 vchat_x1", IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "chat_x1"))
        chatX1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        chatY1Ui := this.Gui.Add("Edit","x275 y435 w70 h20 vchat_y1" , IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "chat_y1"))
        chatY1Ui.OnEvent("Change", this.GetMethod('Update').Bind(this))

        uiClose := this.Gui.Add("Picture", "x440 y410 w160 h40 +BackgroundTrans", A_MyDocuments . "\Dfarm\assets\common\fermer.png")
        uiClose.OnEvent("Click", this.GetMethod('Close').Bind(this)) 
        

        this.Gui.Show("w800 h500")
    }

    updateDelay(GuiCtrlObj, Info){
        IniWrite(GuiCtrlObj.Value, A_MyDocuments . "\Dfarm\conf.ini", "delay", GuiCtrlObj.Name)
    }

    updateSetting(GuiCtrlObj, Info){
        IniWrite(GuiCtrlObj.Value, A_MyDocuments . "\Dfarm\conf.ini", "setting", GuiCtrlObj.Name)
    }

    Update(GuiCtrlObj, Info){
        IniWrite(GuiCtrlObj.Value, A_MyDocuments . "\Dfarm\conf.ini", "pos", GuiCtrlObj.Name)
    }

    UiMove(*){
        PostMessage(0xA1, 2,,, "A")
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
    
   
}