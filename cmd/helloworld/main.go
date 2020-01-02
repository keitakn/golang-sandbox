package main

import (
	"fmt"
	"net/http"
)

type String string

func (s String) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, s)
}

func main() {
	msg := "Hello World golang-sandbox 🐱"
	http.Handle("/", String(msg))
	http.ListenAndServe(":8080", nil)
}
