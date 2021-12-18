;AHKv2

class Updater {
    __New() {
      this.version := "0"
      this.CreateDir()
      this.CheckForUpdate()
    }

    Unz(sZip, sUnz)
    {
      fso := ComObject("Scripting.FileSystemObject")
      If Not fso.FolderExists(sUnz) 
        fso.CreateFolder(sUnz)
      psh  := ComObject("Shell.Application")
      zippedItems := psh.Namespace( sZip ).items().count
      psh.Namespace( sUnz ).CopyHere( psh.Namespace( sZip ).items, 4|16 )
      Loop {
          sleep 50
          unzippedItems := psh.Namespace( sUnz ).items().count
          ToolTip(" Unzipping in progress..")
          if(zippedItems = unzippedItems) {
            break
          }
      }
      ToolTip
      FileDelete(sZip)  
    }

    CheckForUpdate() {
      checkUpdateGui := Gui("-Caption", "DFarm - Check Update")
      checkUpdateGui.Add("Text","w250", "DFarm::")
      Text := checkUpdateGui.Add("Text","w250", "Recherche de mise a jour ... ")
      checkUpdateGui.Show("w250")
  
      whr := ComObject("WinHttp.WinHttpRequest.5.1")
      whr.Open("GET", "https://raw.githubusercontent.com/Dfarm-Tools/DFarm/master/version")
      whr.Send()
      whr.WaitForResponse()
      lastVersion := whr.ResponseText

      this.UpdateVersionFile(lastVersion)

      if(lastVersion != this.version) {
        Text.Value := "Telechargement de la mise a jour ..."

        this.InstallNewVersion(lastVersion)
      } else {
        this.RunLauncher()
      }
    }

    RunLauncher(){
      Run(A_MyDocuments . "\DFarm\exe\DFarmLauncher.exe")
      ExitApp
    }

    UpdateVersionFile(lastVersion) {
      if FileExist(A_MyDocuments . "\DFarm\version") {
        this.version := FileRead(A_MyDocuments . "\DFarm\version")
        FileDelete(A_MyDocuments . "\DFarm\version")
      } 
      FileAppend lastVersion, A_MyDocuments . "\DFarm\version"
    }

  
    
    InstallNewVersion(lastVersion) {
      Download("https://github.com/Dfarm-Tools/DFarm/archive/refs/tags/" . lastVersion . ".zip", A_MyDocuments . "\DFarm\update.zip")
      this.Unz(A_MyDocuments . "\DFarm\update.zip",  A_MyDocuments . "\DFarm\update")

      DirCopy( A_MyDocuments . "\DFarm\update\DFarm-" . lastVersion . "\assets", A_MyDocuments . "\DFarm\assets", true)
      DirCopy( A_MyDocuments . "\DFarm\update\DFarm-" . lastVersion . "\exe", A_MyDocuments . "\DFarm\exe", true)

      if(not FileExist(A_MyDocuments . "\DFarm\conf.ini")) {
        FileCopy(A_MyDocuments . "\DFarm\update\DFarm-" . lastVersion . "\conf.ini", A_MyDocuments . "\DFarm\conf.ini") 
      }

      DirDelete(A_MyDocuments . "\DFarm\update", true)

      this.RunLauncher()
    }

    CreateDir() {
        DirCreate(A_MyDocuments . "\DFarm")
        DirCreate(A_MyDocuments . "\DFarm\exe")
        DirCreate(A_MyDocuments . "\Dfarm\assets")
        DirCreate(A_MyDocuments . "\DFarm\characters")
    }

}

Updater()