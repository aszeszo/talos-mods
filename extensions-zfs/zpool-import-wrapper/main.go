package main

import (
	"log"
	"os/exec"
)

func main() {

	log.Println("zpool-import-wrapper: running \"zpool import -fa\"")

	cmd := exec.Command("/usr/local/sbin/zpool", "import", "-fa")

	out, err := cmd.CombinedOutput()

	log.Printf("%s", out)

	if err != nil {
		log.Println(err)
		log.Fatal("zpool-import-wrapper: \"zpool import -fa\" did not run successfully; exiting...")
	} else {
		log.Println("zpool-import-wrapper: \"zpool import -fa\" command ran successfully; sleeping forever...")
		select {}
	}
}
