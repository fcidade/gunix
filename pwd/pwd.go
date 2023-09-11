package main

import (
	"fmt"
	"os"
	"path/filepath"
)

type Mode int

const (
	Logical Mode = iota
	Physical
)

func pwd(mode Mode) (string, error) {
	workingDir, err := os.Getwd()
	if mode == Logical {
		return workingDir, err
	}

	return filepath.EvalSymlinks(workingDir)

}

func main() {
	mode := Logical
	if len(os.Args) > 1 {
		switch os.Args[1] {
		case "-P":
			mode = Physical
		case "-L":
			mode = Logical
		default:
			fmt.Fprintf(os.Stderr, "usage: pwd [-L | -P]\n")
			os.Exit(1)
		}
	}

	output, err := pwd(mode)
	if err != nil {
		panic(err)
	}
	fmt.Println(output)
}
