;AHKv2
#Include LauncherUi.ahk

class Main {
    __New() {
      this.Launch()
    }

    Launch() {
        this.LauncherUi := LauncherUi()
        this.LauncherUi.Show()
    }  

}

Main()