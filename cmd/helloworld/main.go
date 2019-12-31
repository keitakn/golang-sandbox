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
	http.Handle("/", String("Hello World golang-sandbox!!!"))
	http.ListenAndServe(":8080", nil)
}
