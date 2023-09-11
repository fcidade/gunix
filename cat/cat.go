package main

import (
	"bufio"
	"fmt"
	"os"
	"strings"
)

func main() {

	var filePaths []string
	var flags string

	if len(os.Args) <= 1 {
		filePaths = []string{os.Stdin.Name()}
	} else {
		filePaths = os.Args[1:]
		if strings.HasPrefix(filePaths[0], "-") {
			if filePaths[0] == "-" {
				filePaths = []string{os.Stdin.Name()}
			} else {
				flags = filePaths[0]
				filePaths = filePaths[1:]
			}
		}
	}

	shouldIgnoreEmptyLines := strings.Contains(flags, "b")
	shouldPrintLineNumbers := strings.Contains(flags, "n") || shouldIgnoreEmptyLines

	for _, path := range filePaths {

		file, err := os.Open(path)
		if err != nil {
			if _, ok := err.(*os.PathError); ok {
				fmt.Fprintf(os.Stderr, "cat: %s: No such file or directory\n", path)
				continue
			}
			panic(err)
		}
		defer file.Close()

		scanner := bufio.NewScanner(file)

		line := 1
		for scanner.Scan() {
			text := scanner.Text()
			isLineEmpty := text == ""
			if shouldPrintLineNumbers && !(shouldIgnoreEmptyLines && isLineEmpty) {
				fmt.Printf("%6d\t", line)
				line++
			}

			fmt.Println(text)

		}
	}
}
