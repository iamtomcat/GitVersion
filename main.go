package main

import (
	"log"
	"os/exec"
)

func main() {
	cmd := exec.Command("git rev-parse --verify HEAD")
	err := cmd.Run()

	if err != nil {
		log.Fatal("Git not installed")
	}
}
