class Characters {
    __New() {
        this.characters := []
        this.currentCharacterIndex := 0
        
        this.pseudoX1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "pseudo_x1")
        this.pseudoY1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "pseudo_y1")
        this.pseudoX2 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "pseudo_x2")
        this.pseudoY2 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "pseudo_y2")
        
        this.changeWindow  := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "setting", "switch_on_move")
        this.clickMinDelay := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "delay", "click_delay_min")
        this.clickMaxDelay := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "delay", "click_delay_max")

        this.searchInterval := 800
        this.search := ObjBindMethod(this, "TickSeach")
    }

    SetGlobalShortcut(state:= "On")
    {
        next := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "suivant")
        if(next != '') {
            Hotkey(next, this.GoNext.Bind(this), state)
        }

        prev := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "precedent")
        if(prev != '') {
            Hotkey(prev, this.GoPrevious.Bind(this), state)
        }

        ready := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "pret")
        if(ready != '') {
            Hotkey(ready, this.Ready.Bind(this), state)
        }

        join := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "rejoindre")
        if(join != '') {
            Hotkey(join, this.Join.Bind(this), state)
        }
    }

    SetClickShortcut(state := 'On') {

        clickDelay := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "clic_delai")
        if(clickDelay != '') {
            Hotkey(clickDelay, this.ClickAllWithDelay.Bind(this), state)
        }

        clickInstant := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "clic_instant")
        if(clickInstant != '') {
            Hotkey(clickInstant, this.ClickAll.Bind(this), state)
        }
    }

    SetArrowShortcut(state := 'On') {
        top := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "haut")
        if(top != '') {
            Hotkey(top, this.MoveTop.Bind(this), state)
        }

        right := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "droite")
        if(right != '') {
            Hotkey(right, this.MoveRight.Bind(this), state)
        }

        down := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "bas")
        if(down != '') {
            Hotkey(down, this.MoveDown.Bind(this), state)
        }

        left := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "shortcut", "gauche")
        if(left != '') {
            Hotkey(left, this.MoveLeft.Bind(this), state)
        }
    }

    Init() {
        dfarmWindows := WinGetList("::DFarm")
        for this_id in dfarmWindows
        {
            this_title := WinGetTitle(this_id)
            word_array := StrSplit(this_title, "::DFarm")
            this.characters.push(word_array[1])
        }
    
        dofusWindows := WinGetList("- Dofus")
    
        for this_id in dofusWindows
        {
            this_title := WinGetTitle(this_id)
            word_array := StrSplit(this_title, " - Dofus")
            this.characters.push(word_array[1])
            WinSetTitle(word_array[1] . "::DFarm", this_title)
        }

        shortcutGlobal := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "setting", "shortcut_global")
        shortcutClick := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "setting", "shortcut_click")
        shortcutArrow := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "setting", "shortcut_arrow")

        this.SetGlobalShortcut(shortcutGlobal)
        this.SetClickShortcut(shortcutClick)
        this.SetArrowShortcut(shortcutArrow)
    }

    Group(*) {
        
        chatX1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "chat_x1")
        chatY1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "chat_y1")

        groupX1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "group_x1")
        groupY1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "group_y1")

        groupMinDelay := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "delay", "group_delay_min")
        groupMaxDelay := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "delay", "group_delay_max")

        for key, character in this.characters
            {
                if(key != 1) {
                    Sleep(400)
                    ControlClick("x" . chatX1 . " y" . chatY1, this.characters[1])
                    Send('/invite ' . character . " {Enter}")
    
                    Sleep(500)

                    ControlClick("x" . groupX1 . " y" . groupY1, character)
        
                    if(groupMaxDelay != 0) {
                        delay := Random(groupMinDelay, groupMaxDelay)
                        Sleep(delay)
                    }
                }
            }
    }

    Ready(*) {
        x1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "ready_x1")
        y1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "ready_y1")

        delay := Random(this.clickMinDelay, this.clickMaxDelay)
        this.ClickAllTo(x1, y1, delay)
    }

    Join(*) {
        x1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "join_x1")
        y1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "join_y1")
        delay := Random(this.clickMinDelay, this.clickMaxDelay)
        this.ClickAllTo(x1, y1, delay)
    }

    MoveTop(*) {
        x1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "up_x1")
        y1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "up_y1")
        delay := Random(this.clickMinDelay, this.clickMaxDelay)
        this.ClickAllTo(x1, y1, delay)
    }
    

    MoveRight(*) {
        x1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "right_x1")
        y1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "right_y1")
        delay := Random(this.clickMinDelay, this.clickMaxDelay)
        this.ClickAllTo(x1, y1, delay)
    }

    MoveDown(*) {
        x1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "down_x1")
        y1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "down_y1")
        delay := Random(this.clickMinDelay, this.clickMaxDelay)
        this.ClickAllTo(x1, y1, delay)
    }

    MoveLeft(*) {
        x1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "left_x1")
        y1 := IniRead(A_MyDocuments . "\Dfarm\conf.ini", "pos", "left_y1")
        delay := Random(this.clickMinDelay, this.clickMaxDelay)
        this.ClickAllTo(x1, y1, delay)
    }

    ClickAll(*) {
        MouseGetPos &xpos, &ypos 
        this.ClickAllTo(xpos, ypos)
    }

    ClickAllWithDelay(*) {
        MouseGetPos &xpos, &ypos 
        delay := Random(this.clickMinDelay, this.clickMaxDelay)
        this.ClickAllTo(xpos, ypos, delay, this.changeWindow)
    }

    ClickAllTo(x1, y1, delay := 0, changeWindow := 0) {
        for character in this.characters
            {
                if(changeWindow = 1) {
                    WinActivate(character) 
                }

                ControlClick("x" . x1 . " y" . y1, character)
                if(delay != 0) {
                    Sleep delay
                }
            }
    }

    GoNext(*){
        if(this.characters.Length = 0) {
            return
        }
    
        if(this.currentCharacterIndex = 0 or this.currentCharacterIndex = this.characters.Length) {
            this.currentCharacterIndex := 1
        } else {
            this.currentCharacterIndex := this.currentCharacterIndex + 1
        }
    
        WinActivate(this.characters[this.currentCharacterIndex]) 
    }
    
    GoPrevious(*){
        if(this.characters.Length = 0) {
            return
        }
    
        if(this.currentCharacterIndex = 0 or this.currentCharacterIndex = 1) {
            this.currentCharacterIndex := this.characters.Length
        } else {
            this.currentCharacterIndex := this.currentCharacterIndex - 1
        }
    
        WinActivate(this.characters[this.currentCharacterIndex]) 
    }

    ; SEACH FUNC
    StartSearch() {
        SetTimer(this.search, this.searchInterval, -500)
    }

    StopSearch() {
        SetTimer(this.search, 0)
    }

    TickSeach() {
        for character in this.characters
            {
                CoordMode("Pixel", "Screen")
                if (ImageSearch(&FoundX, &FoundY, this.pseudoX1, this.pseudoY1, this.pseudoX2, this.pseudoY2, "*2 " . A_MyDocuments . "\Dfarm\characters\" . character . ".png")){
                    WinActivate(character) 
                }
            }
    }
    ; ---------------
}